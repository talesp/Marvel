//
//  CharacterNetworkRepository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 30/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation
import os.log

class CharacterNetworkRepository: Repository {

    private var dataTask: URLSessionDataTask?

    private(set) var loadedElements: [Character] = []

    var count: Int

    var updatedData: ((Result<[Character?], RepositoryError>, Int) -> Void)

    private(set) var pageSize: Int
    
    private(set) lazy var repository = NetworkRepository<CharacterResource>(pageSize: self.pageSize) { (characterResources, loadedPage) in

        self.count = characterResources.count
        let mapped = characterResources.compactMap { Character(with: $0) }
        self.loadedElements.append(contentsOf: mapped )
        self.updatedData(.success(mapped), loadedPage)
    }

    init(pageSize: Int,
         updatedData: @escaping (Result<[Character?], RepositoryError>, Int) -> Void) {
        self.pageSize = pageSize
        self.count = 0
        self.updatedData = updatedData
    }

    func items(pageIndex: Int?,
               completion: @escaping (Result<[Character?], RepositoryError>) -> Void) {
        if let pageIndex = pageIndex {
            repository.loadDataIfNeeded(for: pageIndex)
            completion(.success(self.loadedElements))
        }
    }

    func items(withNameStarting name: String,
               completion: @escaping (Result<[Character?], RepositoryError>) -> Void) {
        
        let resource = CharacterResource.resource(nameStartingWith: name)
        self.dataTask?.cancel()
        self.dataTask = nil
        self.dataTask = repository.webservice.load(resource) { result in

            switch result {
            case .success(let element):
                let mapped = element.data.results.compactMap({ Character(with: $0) })
                completion(.success(mapped))
            case .failure(let error):
                os_log("[%{public}@ L%{public}d]: %{public}@", log: .default, type: .error, #function, #line, error.localizedDescription)
            }

        }
    }

}

extension CharacterNetworkRepository: BidirectionalCollection {
    typealias Index = Int
    typealias Element = Character?
    
    var startIndex: Index { return repository.startIndex }
    var endIndex: Index { return repository.endIndex }

    func index(after index: Index) -> Index {
        return repository.index(after: index)
    }

    func index(before index: Index) -> Index {
        return repository.index(before: index)
    }

    /// Accesses and sets elements for a given flat index position.
    /// Currently, setter can only be used to replace non-optional values.
    subscript (position: Index) -> Character? {
        get {
            guard let resource = repository[position] else { return nil }
            return Character(with: resource)
        }
    }

}

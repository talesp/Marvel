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

    private var dataTask: URLSessionDataTask? = nil

    private(set) var loadedElements: [Character] = []

    var count: Int

    private(set) var updatedData: (([Character], Int) -> Void)

    private(set) var pageSize: Int
    
    private lazy var repository = NetworkRepository<CharacterResource>(pageSize: self.pageSize) { (characterResources, loadedPage) in

        os_log("%{characterResources}@", log: OSLog.default, type: OSLogType.debug)

        self.count = self.repository.count
        let mapped = characterResources.compactMap { Character(with: $0) }
        self.loadedElements.append(contentsOf: mapped )
        self.updatedData(mapped, loadedPage)
    }

    init(pageSize: Int, updatedData: @escaping ([Character], Int) -> Void) {
        self.pageSize = pageSize
        self.count = 0
        self.updatedData = updatedData
    }

    func items(pageIndex: Int?, completion: @escaping ([Character]) -> Void) {
        if let pageIndex = pageIndex {
            repository.loadData(for: pageIndex)
            completion([])// self.loadedElements)
        }
    }

    func items(withNameStarting name: String, pageIndex: Int?, completion: @escaping ([Character]) -> Void) {
        let resource = CharacterResource.resource(nameStartingWith: name)
        self.dataTask?.cancel()
        self.dataTask = nil
        self.dataTask = repository.webservice.load(resource) { result in

            switch result {
            case .success(let element):
                completion(element.data.results.compactMap({ Character(with: $0) }))
            case .failure(let error):
                fatalError(error.localizedDescription)
            }

        }
    }

}

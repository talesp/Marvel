//
//  CharacterNetworkRepository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 30/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class CharacterNetworkRepository: Repository {

    private var dataTask: URLSessionDataTask? = nil

    private(set) var loadedElements: [CharacterResource] = []
    var count: Int
    private(set) var updatedData: (([CharacterResource], Int) -> Void)

    private(set) var pageSize: Int
    private lazy var repository = NetworkRepository<CharacterResource>(pageSize: self.pageSize) { (characterResources, loadedPage) in
        self.count = self.repository.count
        self.loadedElements.append(contentsOf: characterResources)
        self.updatedData(characterResources, loadedPage)
    }

    init(pageSize: Int, updatedData: @escaping ([CharacterResource], Int) -> Void) {
        self.pageSize = pageSize
        self.count = 0
        self.updatedData = updatedData
    }

    func items(pageIndex: Int?, completion: @escaping ([CharacterResource]) -> Void) {
        if let pageIndex = pageIndex {
            repository.loadData(for: pageIndex)
            completion(self.loadedElements)
        }
    }

    func items(withNameStarting name: String, pageIndex: Int?, completion: @escaping ([CharacterResource]) -> Void) {
        let resource = CharacterResource.resource(nameStartingWith: name)
        self.dataTask?.cancel()
        self.dataTask = nil
        self.dataTask = repository.webservice.load(resource) { result in

            switch result {
            case .success(let element):
                completion(element.data.results)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }

        }
    }

}

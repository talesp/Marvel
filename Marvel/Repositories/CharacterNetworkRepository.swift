//
//  CharacterNetworkRepository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 30/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

final class CharacterNetworkRepository: NetworkRepository<CharacterResource>, Repository {

    private var dataTask: URLSessionDataTask?

    var all: [CharacterResource] {
        return self.loadedElements
    }

    func items(pageIndex: Int?, completion: @escaping ([CharacterResource]) -> Void) {
        if let pageIndex = pageIndex {
            completion(self.loadedElements)
        }
    }

    func items(withNameStarting name: String, pageIndex: Int?, completion: @escaping ([CharacterResource]) -> Void) {
        let resource = CharacterResource.resource(nameStartingWith: name)
        self.dataTask?.cancel()
        self.dataTask = nil
        self.dataTask = webservice.load(resource) { result in

            switch result {
            case .success(let element):
                completion(element.data.results)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }

        }
    }

}

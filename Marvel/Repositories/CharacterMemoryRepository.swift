//
//  CharactersMemoryRepository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class CharacterMemoryRepository: Repository {

    init(pageSize: Int, nextRepository: CharacterPersistencyRepository?, updatedData: @escaping ([Character], Int) -> Void) {
        self.pageSize = pageSize
        self.nextRepository = nextRepository
        self.updatedData = updatedData
    }
    
    let pageSize: Int

    private(set) var loadedElements: [Character] = []
    private(set) var updatedData: ([Character], Int) -> Void

    private let nextRepository: CharacterPersistencyRepository?

    var count: Int {
        return nextRepository?.count ?? 0
    }

    func items(pageIndex: Int?, completion: @escaping ([Character]) -> Void) {
        
        completion(self.loadedElements)

        self.nextRepository?.items(pageIndex: pageIndex, completion: { [weak self] characters in
            self?.loadedElements.append(contentsOf: characters)
            if let elements = self?.loadedElements {
                completion(elements)
            }
        })
    }

    func items(withNameStarting name: String, pageIndex: Int?, completion: @escaping ([Character]) -> Void) {
        completion(loadedElements)
    }

}

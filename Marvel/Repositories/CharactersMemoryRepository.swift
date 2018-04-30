//
//  CharactersMemoryRepository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class CharactersMemoryRepository: Repository {

    required init(pageSize: Int) {
        fatalError("use `init(pageSize:netxtRepository`")
    }

    init(pageSize: Int, nextRepository: CharacterPersistencyRepository?) {
        self.pageSize = pageSize
        self.nextRepository = nextRepository
    }
    
    let pageSize: Int

    private lazy var networkRepository = NetworkRepository<CharacterResource> { (data: [CharacterResource], pageIndex: Int) in
        let mapped: [Character] = data.compactMap { Character(with: $0) }
        self.all.insert(contentsOf: mapped, at: data.count * pageIndex)
    }

    private let nextRepository: CharacterPersistencyRepository?

    var count: Int {
        return networkRepository.count
    }

    private(set) var all: [Character] = []

    func items(pageIndex: Int?, completion: ([Character]) -> Void) {
        let characters: [Character] = networkRepository.compactMap { resource in
            return Character(with: resource)
        }
        completion(characters)
    }

    func items(withNameStarting name: String, pageIndex: Int?, completion: ([Character]) -> Void) {
        completion(all)
    }

    func item(identifier: Int, completion: (Character?) -> Void) {
        let character = all.first { $0.identifier == identifier }
        completion(character)
    }

}

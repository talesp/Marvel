//
//  CharactersMemoryRepository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class CharacterMemoryRepository: Repository {
    
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

    func items(pageIndex: Int?, completion: @escaping ([Character]) -> Void) {
        let characters: [Character] = networkRepository.compactMap { resource in
            guard let resource = resource else { return nil }
            return Character(with: resource)
        }
        completion(characters)
    }

    func items(withNameStarting name: String, pageIndex: Int?, completion: @escaping ([Character]) -> Void) {
        completion(all)
    }

}

//
//  CharactersMemoryRepository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class CharactersMemoryRepository: Repository {

    let pageSize: Int
    private lazy var networkRepository = NetworkRepository<CharacterResource> { (data: [CharacterResource], pageIndex: Int) in
        let mapped: [Character] = data.compactMap { Character(with: $0) }
        self.all.insert(contentsOf: mapped, at: data.count * pageIndex)
    }

    private let nextRepository: CharacterPersistencyRepository?
    override init() {
        super.init()
        _ = self.networkRepository
    }
    @objc dynamic lazy var all: [Character] = []

    required init(pageSize: Int) {
        fatalError("use `init(pageSize:netxtRepository`")
    }

    func items(completion: ([Character]) -> Void) {
        let characters: [Character] = networkRepository.compactMap { resource in
            guard let resource = resource else { return nil }
            return Character(with: resource)
        }
        completion(characters)
    }

    private(set) var all: [Character] = []

    var count: Int = 0

    func items(pageIndex: Int?, completion: ([Character]) -> Void) {
        completion(all)
    }

    func items(withNameStarting name: String, pageIndex: Int?, completion: ([Character]) -> Void) {
        completion(all)
    }

    func item(identifier: Int, completion: (Character?) -> Void) {
        let character = all.first { $0.idendifier == identifier }
        completion(nil)
    }

}

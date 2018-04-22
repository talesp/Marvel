//
//  CharactersMemoryRepository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

final class CharactersMemoryRepository: NSObject, Repository {

    private var _all: [Character] = []
    @objc dynamic var all: [Character] {
        items { characters in
            self._all = characters
        }
        return self._all
    }

    var count: Int {
        return all.count
    }

    func items(completion: ([Character]) -> Void) {
        let characters = [Character]()
        completion(characters)
    }

    func items(for query: String, completion: ([Character]) -> Void) {

    }

    func item(identifier: Int, completion: (Character) -> Void) {
        let character = Character()
        completion(character)
    }
}

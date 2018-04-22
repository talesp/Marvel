//
//  CharactersMemoryRepository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

final class CharactersMemoryRepository: Repository {

    private(set) var all: [Character] = [] {
        get {
            items { characters in
                self.all = characters
            }
        }
    }

    func items(completion: (items: [Character]) -> Void) {
        var characters = [Character]()
        completion(items: characters)
    }

    func items(for query: String, completion: (items: [Element]) -> Void) {
        
    }

    func item(identifier: Int, completion: (item: Element) -> Void) {
        var character = Character(id: 0,
                                  name: "",
                                  description: "",
                                  modified: Date(),
                                  resourceURI: "",
                                  urls: [],
                                  thumbnailData: Data(),
                                  comics: nil,
                                  stories: nil,
                                  events: nil,
                                  series: nil)
        completion(items: character)
    }
}

//
//  CharactersMemoryRepository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class CharactersMemoryRepository: Repository {

    var all: [Character] = []

    var count: Int = 0

    func items(pageSize: Int?, pageIndex: Int?, completion: ([Character]) -> Void) {
        completion(all)
    }

    func items(withNameStarting name: String, pageSize: Int?, pageIndex: Int, completion: ([Character]) -> Void) {
        completion(all)
    }

    func item(identifier: Int, completion: (Character?) -> Void) {
        completion(nil)
    }

}

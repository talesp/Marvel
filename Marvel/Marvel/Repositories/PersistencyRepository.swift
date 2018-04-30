//
//  PersistencyRepository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 29/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation
import CoreData

class CharacterPersistencyRepository: Repository {

    var pageSize: Int

    private let store: PersistencyStack

    var all: [Character] = []

    var count: Int = 0

    required init(pageSize: Int) {
        self.store = PersistencyStack(modelName: PersistencyStack.modelName)
        self.pageSize = pageSize
    }

    init(pageSize: Int, store: PersistencyStack = PersistencyStack(modelName: PersistencyStack.modelName)) {
        self.pageSize = pageSize
        self.store = store
    }

    func items(pageIndex: Int?, completion: ([Character]) -> Void) {
        let request = CharacterEntity.fetchRequest(pageSize: self.pageSize, pageIndex: pageIndex ?? 0)
        do {
            let characters = try store.viewContext.fetch(request).map { entity in
                return Character(with: entity)
            }
            completion(characters)
        }
        catch let error {
            fatalError("ERROR: [\(error.localizedDescription)]")
        }

    }

    func items(withNameStarting name: String, pageIndex: Int, completion: ([Character]) -> Void) {
        // <#code#>
    }

    func item(identifier: Int, completion: (Character?) -> Void) {
        // <#code#>
    }

}

//
//  CharacterPersistencyRepository.swift
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

    private let nextRepository: CharacterNetworkRepository?
    
    required init(pageSize: Int) {
        fatalError("Use `init(pageSize:store:nextRepository:)` intead")
    }

    init(pageSize: Int,
         store: PersistencyStack = PersistencyStack(modelName: PersistencyStack.modelName),
         nextRepository: CharacterNetworkRepository?) {
        self.pageSize = pageSize
        self.store = store
        self.nextRepository = nextRepository
    }

    func items(pageIndex: Int?, completion: @escaping ([Character]) -> Void) {
        let request = CharacterEntity.fetchRequest(pageSize: self.pageSize, pageIndex: pageIndex ?? 0)
        do {
            let characters = try store.viewContext.fetch(request).map { entity in
                return Character(with: entity)
            }
            completion(characters)
        }
        catch let error {
            //TODO:
            fatalError("ERROR: [\(error.localizedDescription)]")
        }

    }

    func items(withNameStarting name: String, pageIndex: Int?, completion: @escaping ([Character]) -> Void) {
        let request = CharacterEntity.fetchRequest(withNameStarting: name, pageSize: self.pageSize, pageIndex: pageIndex ?? 0)
        do {
            let characters = try store.viewContext.fetch(request).map { entity in
                return Character(with: entity)
            }
            completion(characters)
        }
        catch {
            //TODO:
            fatalError("ERROR: [\(error.localizedDescription)]")
        }
    }

}

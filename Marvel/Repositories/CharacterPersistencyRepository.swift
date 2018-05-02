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
    var updatedData: (([Character], Int) -> Void)

    var pageSize: Int

    private let store: PersistencyStack

    private(set) var loadedElements: [Character] = []

    var count: Int = 0

    private lazy var nextRepository: CharacterNetworkRepository = {
        return CharacterNetworkRepository(pageSize: self.pageSize,
                                          updatedData: { (resources, page) in
                                            let characters = resources.map({ resource in
                                                return Character(with: resource)
                                            })

                                            self.store.insertOrUpdate(characters: characters)
        })
    }()

    init(pageSize: Int,
         store: PersistencyStack = PersistencyStack(modelName: PersistencyStack.modelName),
         updatedData: @escaping ([Character], Int) -> Void) {
        self.pageSize = pageSize
        self.store = store
        store.load()
        self.updatedData = updatedData
    }

    func items(pageIndex: Int?, completion: @escaping ([Character]) -> Void) {
        let request = CharacterEntity.fetchRequest(pageSize: self.pageSize, pageIndex: pageIndex ?? 0)
        do {
            let characters = try store.viewContext.fetch(request).map { entity in
                return Character(with: entity)
            }
            completion(characters)
            self.nextRepository.items(pageIndex: pageIndex, completion: { resources in
                let characters = resources.map { Character(with: $0) }
                completion(characters)
            })
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

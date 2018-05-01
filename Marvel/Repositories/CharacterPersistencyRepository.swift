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

    private(set) var loadedElements: [Character] = []

    var count: Int = 0

    private lazy var nextRepository: CharacterNetworkRepository = {
        return CharacterNetworkRepository(pageSize: self.pageSize,
                                          startPage: 0,
                                          webservice: Webservice(),
                                          updatedData: { (resources, page) in
                                            dump(resources)
                                            dump(page)
                                            fatalError("implement")
        })
    }()

    required init(pageSize: Int) {
        fatalError("Use `init(pageSize:store:nextRepository:)` intead")
    }

    lazy var net = CharacterNetworkRepository(pageSize: 10)

    init(pageSize: Int, store: PersistencyStack) {
        self.pageSize = pageSize
        self.store = store
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

//
//  PersistencyStack.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 28/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation
import CoreData

class PersistencyStack {

    static var modelName: String { return "Marvel" }
    
    let persistentContainer: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    lazy var backgroundContext: NSManagedObjectContext = persistentContainer.newBackgroundContext()

    init(modelName: String) {

        persistentContainer = NSPersistentContainer(name: modelName)
//        backgroundContext = persistentContainer.newBackgroundContext()
    }

    func configureContexts() {
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true

        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }

    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            self.autoSaveViewContext()
            self.configureContexts()
            completion?()
        }
    }
}

extension PersistencyStack {
    func insertOrUpdate(characters: [CharacterModel]) {

//        let fetchRequest = CharacterEntity.fetchRequest(withIdentifiers: characters.map({ $0.identifier }))
        DispatchQueue.main.async {
            let fetchRequest = NSFetchRequest<CharacterEntity>(entityName: CharacterEntity.entityName)
            let privateManagedObjectContext = self.persistentContainer.newBackgroundContext()
            let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { asynchronousFetchResult in
                guard let existingCharacters = asynchronousFetchResult.finalResult else { return }

                DispatchQueue.main.async {
                    // Do something
                    print("here")
                }

                //            let idSet = Set<Int32>(existingCharacters.compactMap({ characterEntity -> Int32? in
                //                return characterEntity.identifier
                //            }))
                //
                //            existingCharacters.forEach({ entity in
                //                if let newData = characters.first(where: { $0.identifier == entity.identifier }) {
                //                    entity.update(with: newData, inContext: self.backgroundContext)
                //                }
                //            })
                //            let newCharacters = characters.filter { character in
                //                idSet.contains(character.identifier) == false
                //            }
                //
                //            for character in newCharacters {
                //                CharacterEntity(with: character, inContext: self.backgroundContext)
                //            }
            }

            privateManagedObjectContext.perform {
                do {
                    // Executes `asynchronousFetchRequest`
                    try privateManagedObjectContext.execute(asynchronousFetchRequest)
                } catch let error {
                    print("NSAsynchronousFetchRequest error: \(error)")
                }
                //            self.backgroundContext.perform {
                //                do {
                //                    let result = try self.backgroundContext.execute(asynchronousFetchRequest)
                //                    try self.backgroundContext.save()
                //                }
                //                catch {
                //                    fatalError(error.localizedDescription)
                //                }
                //        }
                
            }
        }
    }
    
}

// MARK: - Autosaving

extension PersistencyStack {
    func autoSaveViewContext(interval: TimeInterval = 30) {
        print("autosaving")

        guard interval > 0 else {
            print("cannot set negative autosave interval")
            return
        }

        if viewContext.hasChanges {
            try? viewContext.save()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveViewContext(interval: interval)
        }
    }
}

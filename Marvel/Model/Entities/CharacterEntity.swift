//
//  CharacterEntity.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 29/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation
import CoreData

extension CharacterEntity: CharacterModel {
    
    var urls: [URL]? {
        return self.urlEntities?.compactMap({ urlEntity in
            if let urlEntity = urlEntity as? URLEntity, let urlString = urlEntity.urlString {
                return URL(string: urlString)
            }
            return nil
        })
    }

    var comics: [ComicModel]? {
        return self.comicEntities?.compactMap({ entity in
            if let entity = entity as? ComicEntity {
                return entity
            }
            return nil
        })
    }

    var stories: [StoryModel]? {
        return self.storyEntities?.compactMap({ entity in
            if let entity = entity as? StoryEntity {
                return entity
            }
            return nil
        })
    }

    var events: [EventModel]? {
        return self.eventEntities?.compactMap({ entity in
            if let entity = entity as? EventEntity {
                return entity
            }
            return nil
        })
    }

    var series: [SerieModel]? {
        return self.serieEntities?.compactMap({ entity in
            if let entity = entity as? SerieEntity {
                return entity
            }
            return nil
        })
    }

    var thumbnailURL: URL? {
        guard let urlString = self.thumbnailURLString else { return nil }
        return URL(string: urlString)
    }

    static func fetchRequest(pageSize: Int, pageIndex: Int) -> NSFetchRequest<CharacterEntity> {
        let request = NSFetchRequest<CharacterEntity>(entityName: CharacterEntity.entityName)
        request.fetchBatchSize = pageSize
        request.fetchOffset = pageIndex
        return request
    }

    static func fetchRequest(withNameStarting name: String, pageSize: Int, pageIndex: Int) -> NSFetchRequest<CharacterEntity> {
        let request = NSFetchRequest<CharacterEntity>(entityName: CharacterEntity.entityName)
        request.predicate = NSPredicate(format: "name beginswith[c] '%@'", name)
        request.fetchBatchSize = pageSize
        request.fetchOffset = pageIndex
        return request
    }

    static func fetchRequest(withIdentifier identifier: Int) -> NSFetchRequest<CharacterEntity> {
        let request = NSFetchRequest<CharacterEntity>(entityName: CharacterEntity.entityName)
        request.predicate = NSPredicate(format: "identifier == '%@'", identifier)
        return request
    }
}

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

    @discardableResult
    convenience init(with model: CharacterModel, inContext context: NSManagedObjectContext) {
        self.init(context: context)
        self.identifier = model.identifier
        self.name = model.name
        self.summary = model.summary
        self.modified = model.modified
        self.resourceURI = model.resourceURI
        model.urls?.forEach({ url in
            let newURLEntity = URLEntity(with: url, inContext: context)
            self.addToUrlEntities(newURLEntity)
        })
        model.comics?.forEach({ comic in
            let newComic = ComicEntity(with: comic, inContext: context)
            self.addToComicEntities(newComic)
        })
        self.thumbnailURLString = model.thumbnailURL?.absoluteString
        model.stories?.forEach({ story in
            let newStory = StoryEntity(with: story, inContext: context)
            self.addToStoryEntities(newStory)
        })
        model.events?.forEach({ event in
            let newEvent = EventEntity(with: event, inContext: context)
            self.addToEventEntities(newEvent)
        })
        model.series?.forEach({ serie in
            let newSerie = SerieEntity(with: serie, inContext: context)
            self.addToSerieEntities(newSerie)
        })
    }

    func update(with model: CharacterModel, inContext context: NSManagedObjectContext) {
        self.identifier = model.identifier
        self.name = model.name
        self.summary = model.summary
        self.modified = model.modified
        self.resourceURI = model.resourceURI
        model.urls?.forEach({ url in
            let newURLEntity = URLEntity(with: url, inContext: context)
            self.addToUrlEntities(newURLEntity)
        })
        model.comics?.forEach({ comic in
            let newComic = ComicEntity(with: comic, inContext: context)
            self.addToComicEntities(newComic)
        })
        self.thumbnailURLString = model.thumbnailURL?.absoluteString
        model.stories?.forEach({ story in
            let newStory = StoryEntity(with: story, inContext: context)
            self.addToStoryEntities(newStory)
        })
        model.events?.forEach({ event in
            let newEvent = EventEntity(with: event, inContext: context)
            self.addToEventEntities(newEvent)
        })
        model.series?.forEach({ serie in
            let newSerie = SerieEntity(with: serie, inContext: context)
            self.addToSerieEntities(newSerie)
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
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }

    static func fetchRequest(withNameStarting name: String, pageSize: Int, pageIndex: Int) -> NSFetchRequest<CharacterEntity> {
        let request = NSFetchRequest<CharacterEntity>(entityName: CharacterEntity.entityName)
        request.predicate = NSPredicate(format: "name beginswith[c] '%@'", name)
        request.fetchBatchSize = pageSize
        request.fetchOffset = pageIndex
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }

    static func fetchRequest(withIdentifiers identifiers: [Int32]) -> NSFetchRequest<CharacterEntity> {
        let request = NSFetchRequest<CharacterEntity>(entityName: CharacterEntity.entityName)
        request.predicate = NSPredicate(format: "identifier in '%@'", identifiers)
        return request
    }
}

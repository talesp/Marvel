//
//  Character.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct Character: CharacterModel {

    /// The unique ID of the character resource.
    let id: Int

    ///  The name of the character.
    let name: String?

    ///  A short bio or description of the character.
    let summary: String?

    ///  The date the resource was most recently modified.
    let modified: Date?

    /// The canonical URL identifier for this resource.
    let resourceURI: String?

    /// A set of public web site URLs for the resource.
    let urls: [URL]?

    /// The representative image for this character.
    let thumbnailURL: URL?

    /// A resource list containing comics which feature this character.
    let comics: [ComicModel]?

    /// A resource list of stories in which this character appears.
    let stories: [StoryModel]?

    /// A resource list of events in which this character appears.
    let events: [EventModel]?

    /// A resource list of series in which this character appears.
    let series: [SerieModel]?

    @available(*, unavailable)
    init() {
        fatalError("Not implemented")
    }

    init(with model: CharacterModel) {
        self.id = model.id
        self.name = model.name
        self.summary = model.summary
        self.modified = model.modified
        self.resourceURI = model.resourceURI
        self.urls = model.urls
        self.thumbnailURL = model.thumbnailURL
        self.comics = model.comics
        self.stories = model.stories
        self.events = model.events
        self.series = model.series
    }
}

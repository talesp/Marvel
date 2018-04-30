//
//  Character.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

protocol CharacterModel {
    /// The unique ID of the character resource.
    var idendifier: Int { get }

    ///  The name of the character.
    var name: String? { get }

    ///  A short bio or description of the character.
    var summary: String? { get }

    ///  The date the resource was most recently modified.
    var modified: Date? { get }

    /// The canonical URL identifier for this resource.
    var resourceURI: String? { get }

    /// A set of public web site URLs for the resource.
    var urls: [URL]? { get }

    /// The representative image for this character.
    var thumbnailURL: URL? { get }

    /// A resource list containing comics which feature this character.
    var comics: [ComicModel]? { get }

    /// A resource list of stories in which this character appears.
    var stories: [StoryModel]? { get }

    /// A resource list of events in which this character appears.
    var events: [EventModel]? { get }

    /// A resource list of series in which this character appears.
    var series: [SerieModel]? { get }
}

struct Character: CharacterModel {

    /// The unique ID of the character resource.
    let idendifier: Int

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

    init() {
        self.idendifier = 0
        self.name = "3D-Man!"
        self.summary = ""
        self.modified = Date()
        self.resourceURI = ""
        self.urls = []
        self.thumbnailURL = nil
        self.comics = nil
        self.stories = nil
        self.events = nil
        self.series = nil
    }

    init(with model: CharacterModel) {
        self.idendifier = model.idendifier
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

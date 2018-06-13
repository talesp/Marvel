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

    var isFavorited: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case summary = "description"
        case modified
        case resourceURI
        case urlsResources = "urls"
        case thumbnailResource = "thumbnail"
        case comicResources = "comics"
        case storyResources = "stories"
        case eventResources = "events"
        case serieResources = "series"
    }

    init(from decoder: Decoder) throws {
        (decoder as? JSONDecoder)?.dateDecodingStrategy = .iso8601
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        summary = try container.decodeIfPresent(String.self, forKey: .summary)
        modified = try container.decodeIfPresent(Date.self, forKey: .modified)
        resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI)
        urls = nil
        thumbnailURL = nil
        comics = try container.decodeIfPresent([Comic].self, forKey: .comicResources)
        stories = try container.decodeIfPresent([Story].self, forKey: .storyResources)
        events = try container.decodeIfPresent([Event].self, forKey: .eventResources)
        series = try container.decodeIfPresent([Serie].self, forKey: .serieResources)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(summary, forKey: .summary)
        try container.encodeIfPresent(comics as? [Comic], forKey: Character.CodingKeys.comicResources)
    }

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

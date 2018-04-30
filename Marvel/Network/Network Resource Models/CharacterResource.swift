//
//  CharacterResource.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 19/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct CharacterResource: CharacterModel {

    /// The unique ID of the character resource.
    let identifier: Int32

    ///  The name of the character.
    let name: String?

    ///  A short bio or description of the character.
    let summary: String?

    ///  The date the resource was most recently modified.
    let modified: Date?

    /// The canonical URL identifier for this resource.
    let resourceURI: String?

    var urls: [URL]? {
        return urlsResources?.compactMap({ resource in
            return URL(string: resource.urlString)
        })
    }

    /// A set of public web site URLs for the resource.
    let urlsResources: [URLResource]?

    var thumbnailURL: URL? {
        guard let path = thumbnailResource?.path, let pathExtension = thumbnailResource?.extension else { return nil }
        return URL(string: "\(path).\(pathExtension)")
    }

    /// The representative image for this character.
    let thumbnailResource: ImageResource?

    /// A resource list containing comics which feature this character.
    let comicResources: ListResource<ComicSummaryResource>?
    var comics: [ComicModel]? {
        return comicResources?.items.compactMap({ $0 })
    }
    /// A resource list of stories in which this character appears.
    let storyResources: ListResource<StorySummaryResource>?
    var stories: [StoryModel]? {
        return storyResources?.items.compactMap({ $0 })
    }

    /// A resource list of events in which this character appears.
    let eventResources: ListResource<EventSummaryResource>?
    var events: [EventModel]? {
        return eventResources?.items.compactMap({ $0 })
    }

    /// A resource list of series in which this character appears.
    let serieResources: ListResource<SerieSummaryResource>?
    var series: [SerieModel]? {
        return serieResources?.items.compactMap({ $0 })
    }

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
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
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(Int32.self, forKey: .identifier)
        name = try container.decode(String.self, forKey: .name)
        summary = try container.decode(String.self, forKey: .summary)
        modified = try container.decode(Date.self, forKey: .modified)
        resourceURI = try container.decode(String.self, forKey: .resourceURI)
        urlsResources = try container.decode([URLResource].self, forKey: .urlsResources)
        thumbnailResource = try container.decode(ImageResource.self, forKey: .thumbnailResource)
        comicResources = try container.decode(ListResource<ComicSummaryResource>.self, forKey: .comicResources)
        storyResources = try container.decode(ListResource<StorySummaryResource>.self, forKey: .storyResources)
        eventResources = try container.decode(ListResource<EventSummaryResource>.self, forKey: .eventResources)
        serieResources = try container.decode(ListResource<SerieSummaryResource>.self, forKey: .serieResources)

    }
}

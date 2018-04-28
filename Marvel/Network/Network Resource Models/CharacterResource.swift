//
//  CharacterResource.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 19/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct CharacterResource: Codable {
    /// The unique ID of the character resource.
    let id: Int

    ///  The name of the character.
    let name: String

    ///  A short bio or description of the character.
    let description: String

    ///  The date the resource was most recently modified.
    let modified: Date

    /// The canonical URL identifier for this resource.
    let resourceURI: String

    /// A set of public web site URLs for the resource.
    let urls: [URLResource]

    /// The representative image for this character.
    let thumbnail: ImageResource

    /// A resource list containing comics which feature this character.
    let comics: ListResource<ComicSummaryResource>

    /// A resource list of stories in which this character appears.
    let stories: ListResource<StorySummaryResource>

    /// A resource list of events in which this character appears.
    let events: ListResource<EventSummaryResource>

    /// A resource list of series in which this character appears.
    let series: ListResource<SerieSummaryResource>
}

extension CharacterResource: PagedResource {
    static func search(with text: String) -> Resource<CharacterResource> {
        
        let components = URLComponents(url: MarvelAPIConfig.baseURL, resolvingAgainstBaseURL: true)

        let url = components?.url?.appendingPathComponent("characters") !! "Error appending path"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return Resource(url: url, decoder: decoder)
    }

    static func search(with id: Int) -> Resource<CharacterResource> {

        let components = URLComponents(url: MarvelAPIConfig.baseURL, resolvingAgainstBaseURL: true)

        let url = components?.url?.appendingPathComponent("characters") !! "Error appending path"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return Resource(url: url, decoder: decoder)
    }

    public static func resource(for page: Int = 0) -> Resource<DataWrapperResource<CharacterResource>> {

        let components = URLComponents(url: MarvelAPIConfig.baseURL, resolvingAgainstBaseURL: true)

        let url = components?.url?.appendingPathComponent("characters") !! "Error appending path"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return Resource(url: url, decoder: decoder)
    }
}

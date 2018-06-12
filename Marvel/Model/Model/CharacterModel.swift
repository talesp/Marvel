//
//  CharacterModel.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 30/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

protocol CharacterModel {
    /// The unique ID of the character resource.
    var id: Int { get }

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

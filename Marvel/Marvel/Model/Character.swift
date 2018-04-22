//
//  Character.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class Character: NSObject {

    /// The unique ID of the character resource.
    let idendifier: Int

    ///  The name of the character.
    let name: String

    ///  A short bio or description of the character.
    let desc: String

    ///  The date the resource was most recently modified.
    let modified: Date

    /// The canonical URL identifier for this resource.
    let resourceURI: String

    /// A set of public web site URLs for the resource.
    let urls: [URL]?

    /// The representative image for this character.
    let thumbnailData: Data?

    /// A resource list containing comics which feature this character.
    let comics: [Comic]?

    /// A resource list of stories in which this character appears.
    let stories: [Story]?

    /// A resource list of events in which this character appears.
    let events: [Event]?

    /// A resource list of series in which this character appears.
    let series: [Serie]?

    override init() {
        self.idendifier = 0
        self.name = "3D-Man!"
        self.desc = ""
        self.modified = Date()
        self.resourceURI = ""
        self.urls = []
        self.thumbnailData = nil
        self.comics = nil
        self.stories = nil
        self.events = nil
        self.series = nil
        super.init()
    }
}

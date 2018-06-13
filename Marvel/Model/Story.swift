//
//  Story.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct Story: StoryModel, Codable {
    ///  The path to the individual story resource.,
    let resourceURI: String?

    /// The canonical name of the story.,
    let name: String?

    /// The type of the story (interior or cover).
    let type: String?

    init(with model: StoryModel) {
        self.resourceURI = model.resourceURI
        self.name = model.name
        self.type = model.type
    }
}

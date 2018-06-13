//
//  Comic.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct Comic: ComicModel, Codable {
    /// The path to the individual comic resource.,
    let resourceURI: String?

    /// The canonical name of the comic.
    let name: String?

    init(with model: ComicModel) {
        self.name = model.name
        self.resourceURI = model.resourceURI
    }
}

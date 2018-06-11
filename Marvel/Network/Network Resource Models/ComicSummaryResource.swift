//
//  ComicSummaryResource.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 19/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct ComicSummaryResource: ComicModel, Decodable {
    /// The path to the individual comic resource.,
    let resourceURI: String?

    /// The canonical name of the comic.
    let name: String?
}

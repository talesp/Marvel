//
//  StorySummaryResource.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 19/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct StorySummaryResource: Codable {
    ///  The path to the individual story resource.,
    let resourceURI: String

    /// The canonical name of the story.,
    let name: String

    /// The type of the story (interior or cover).
    let type: String
}

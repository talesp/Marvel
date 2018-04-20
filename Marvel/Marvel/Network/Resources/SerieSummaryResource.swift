//
//  SerieSummaryResource.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 19/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct SerieSummaryResource: Codable {
    /// The path to the individual series resource.,
    let resourceURI: String

    /// The canonical name of the series.
    let name: String
}

//
//  DataContainerResource.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 19/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct DataContainerResource: Codable {
    /// The requested offset (number of skipped results) of the call.,
    let offset: String

    /// The requested result limit
    let limit: Int

    ///  The total number of resources available given the current filter set.
    let total: Int

    /// The total number of results returned by this call.
    let count: Int

    /// The list of characters returned by the call.
    let results: [CharacterResource]
}

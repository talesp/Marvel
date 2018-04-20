//
//  ListResource.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 19/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct ListResource<T: Codable>: Codable {
    //swiftlint:disable line_length
    /// The number of total available issues in this list. Will always be greater than or equal to the "returned" value.,
    let available: Int
    //swiftlint:enable line_length

    /// The number of issues returned in this collection (up to 20).,
    let returned: Int

    /// The path to the full list of issues in this collection.,
    let collectionURI: String

    /// The list of returned items in this collection.
    let items: [T]
}

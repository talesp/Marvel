//
//  URLResource.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 19/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct URLResource: Codable {
    /// A text identifier for the URL.,
    let type: String

    /// A full URL (including scheme, domain, and path).
    let urlString: String

    enum CodingKeys: String, CodingKey {
        case type
        case urlString = "url"
    }
}

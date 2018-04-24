//
//  JSONDecoder.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 24/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

extension JSONDecoder {
    convenience init(dateDecodingStrategy: DateDecodingStrategy = .iso8601) {
        self.init()
        self.dateDecodingStrategy = dateDecodingStrategy
    }
}

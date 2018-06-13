//
//  JSONEncoder.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 12/06/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

extension JSONEncoder {
    convenience init(dateEncodingStrategy: DateEncodingStrategy = .iso8601) {
        self.init()
        self.dateEncodingStrategy = dateEncodingStrategy
    }
}

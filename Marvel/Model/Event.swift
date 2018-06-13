//
//  Event.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct Event: EventModel, Codable {
    /// The path to the individual event resource.,
    let resourceURI: String?

    /// The name of the event.
    let name: String?

    init(with model: EventModel) {
        self.resourceURI = model.resourceURI
        self.name = model.name
    }
}

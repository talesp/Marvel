//
//  EventSummaryResource.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 19/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct EventSummaryResource: EventModel, Decodable {
    /// The path to the individual event resource.,
    let resourceURI: String?

    /// The name of the event.
    let name: String?
}

//
//  EventModel.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 30/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

protocol EventModel {
    /// The path to the individual event resource.,
    var resourceURI: String? { get }

    /// The name of the event.
    var name: String? { get }

}

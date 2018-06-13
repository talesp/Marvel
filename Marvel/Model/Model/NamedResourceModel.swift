//
//  NamedResourceModel.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 10/06/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

protocol NamedResourceModel: Codable {
    /// The path to the individual Serie resource.,
    var resourceURI: String? { get }

    /// The canonical name of the Serie.
    var name: String? { get }
}

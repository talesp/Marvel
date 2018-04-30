//
//  SerieModel.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 30/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

protocol SerieModel {
    /// The path to the individual Serie resource.,
    var resourceURI: String? { get }

    /// The canonical name of the Serie.
    var name: String? { get }
}

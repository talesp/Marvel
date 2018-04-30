//
//  Serie.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

protocol SerieModel {
    /// The path to the individual Serie resource.,
    var resourceURI: String? { get }

    /// The canonical name of the Serie.
    var name: String? { get }
}

struct Serie: SerieModel {
    /// The path to the individual Serie resource.,
    let resourceURI: String?

    /// The canonical name of the Serie.
    let name: String?

    init(with model: SerieModel) {
        self.name = model.name
        self.resourceURI = model.resourceURI
    }
}

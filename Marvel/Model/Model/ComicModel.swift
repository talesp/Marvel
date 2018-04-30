//
//  ComicModel.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 30/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

protocol ComicModel {
    /// The path to the individual comic resource.,
    var resourceURI: String? { get }

    /// The canonical name of the comic.
    var name: String? { get }
}

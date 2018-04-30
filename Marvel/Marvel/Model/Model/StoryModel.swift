//
//  StoryModel.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 30/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

protocol StoryModel {
    ///  The path to the individual story resource.,
    var resourceURI: String? { get }

    /// The canonical name of the story.,
    var name: String? { get }

    /// The type of the story (interior or cover).
    var type: String? { get }
}

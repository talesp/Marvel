//
//  ImageResource.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 19/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct ImageResource: Decodable {
    /// The directory path of to the image.
    let path: String?
    /// The file extension for the image.
    let `extension`: String?
}

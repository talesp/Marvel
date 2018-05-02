//
//  URLModel.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 01/05/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

protocol URLModel {
    /// A text identifier for the URL.
    var type: String? { get }

    /// A full URL (including scheme, domain, and path)
    var urlString: String? { get }

}

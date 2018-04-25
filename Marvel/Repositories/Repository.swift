//
//  Repository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

protocol Repository: class {
    associatedtype Element

    /// All elements. Should be used for observation
    var all: [Element] { get }
    var count: Int { get }
    func items(completion: ([Element]) -> Void)
    func items(for query: String, completion: ([Element]) -> Void)
    func item(identifier: Int, completion: (Element?) -> Void)

}

//
//  Repository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

protocol Repository {
    associatedtype Element

    /// All elements. Should be used for observation
    var all: [Element] { get }
    func items(completion: (items: [Element]) -> Void)
    func items(for query: String, completion: (items: [Element]) -> Void)
    func item(identifier: Int, completion: (item: Element) -> Void)

}

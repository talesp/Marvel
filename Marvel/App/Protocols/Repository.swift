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
    var pageSize: Int { get }

    init(pageSize: Int)
    func items(pageIndex: Int?, completion: @escaping ([Element]) -> Void)
    func items(withNameStarting name: String, pageIndex: Int?, completion:@escaping  ([Element]) -> Void)

}

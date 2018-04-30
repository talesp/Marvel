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

    var all: [Element] { get }
    var count: Int { get }
    var pageSize: Int { get }

    init(pageSize: Int)
    func items(pageIndex: Int?, completion: ([Element]) -> Void)
    func items(withNameStarting name: String, pageIndex: Int?, completion: ([Element]) -> Void)
    func item(identifier: Int, completion: (Element?) -> Void)

}

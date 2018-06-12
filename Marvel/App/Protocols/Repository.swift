//
//  Repository.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

enum RepositoryError: Error {
    case error
}

protocol Repository: class, BidirectionalCollection {
    
    associatedtype Element

    /// All elements. Should be used for observation

    var count: Int { get }
    var pageSize: Int { get }

    var updatedData: ((Result<[Element], RepositoryError>, Int) -> Void) { get }

    func items(pageIndex: Int?, completion: @escaping (Result<[Element], RepositoryError>) -> Void)
    func items(withNameStarting name: String, completion: @escaping  (Result<[Element], RepositoryError>) -> Void)

}

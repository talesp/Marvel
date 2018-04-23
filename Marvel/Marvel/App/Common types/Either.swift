//
//  Either.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 23/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

enum Either<L, R> {
    case left(L)
    case right(R)
}

//
//  TitledImageViewModel.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 22/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

enum Either<L, R> {
    case left(L)
    case right(R)
}

struct TitledImageViewModel {
    let title: String
    let placeholderImage: UIImage?
    let imageOrURL: Either<UIImage, URL>
}

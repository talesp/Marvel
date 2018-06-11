//
//  TitledImageViewModel.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 22/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

struct TitledImageViewModel {
    let title: String
    let placeholderImage: UIImage?
    let imageOrURL: Either<UIImage, URL>
    private(set) weak var view: TitledImageView?

    init(for view: TitledImageView,
         title: String,
         placeholderImage: UIImage? = nil,
         imageOrURL: Either<UIImage, URL>) {
        self.view = view
        self.title = title
        self.placeholderImage = placeholderImage
        self.imageOrURL = imageOrURL

        switch self.imageOrURL {
        case .left(let image):
            view.setup(image: image, title: self.title)
        case .right(let url):
            view.setup(title: self.title, placeholderImage: self.placeholderImage, imageURL: url)
        }
    }
}

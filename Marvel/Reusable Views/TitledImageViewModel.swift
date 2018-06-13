//
//  TitledImageViewModel.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 22/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class TitledImageViewModel {
    let title: String
    let placeholderImage: UIImage?
    let imageOrURL: Either<UIImage, URL>
    private(set) weak var view: TitledImageView?

    var toggleFavoriteCharacter: (String) -> Void

    init(for view: TitledImageView,
         title: String,
         placeholderImage: UIImage? = nil,
         favorite: Bool,
         imageOrURL: Either<UIImage, URL>,
         toggleFavoriteCharacter: @escaping ((String) -> Void)) {

        self.view = view
        self.view?.isFavorite = favorite
        self.title = title
        self.placeholderImage = placeholderImage
        self.imageOrURL = imageOrURL
        self.toggleFavoriteCharacter = toggleFavoriteCharacter

        switch self.imageOrURL {
        case .left(let image):
            view.setup(image: image, title: self.title)
        case .right(let url):
            view.setup(title: self.title, placeholderImage: self.placeholderImage, imageURL: url)
        }

        self.view?.toggleFavorite = { [weak self] in
            self?.toggleFavoriteCharacter(title)
        }
    }
}

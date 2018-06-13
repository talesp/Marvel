//
//  CharacterDetailViewModel.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

struct CharacterDetailViewModel {

    private(set) weak var view: CharacterDetailView?

    var model: CharacterModel

    var name: String {
        return model.name ?? "Unkown"
    }

    var description: String {
        return model.summary ?? "Empty description"
    }

    var comics: [ComicModel]? {
        return  model.comics
    }

    var stories: [StoryModel]? {
        return model.stories
    }

    var events: [EventModel]? {
        return model.events
    }

    var series: [SerieModel]? {
        return model.series
    }

    var image: UIImage {
        guard let url = model.thumbnailURL, let data = try? Data(contentsOf: url) else { return UIImage.placeholder }

        return UIImage(data: data) !! "Invalid image data"
    }

    init(for view: CharacterDetailView, model: Character, toggleFavoriteCharacter: @escaping ((String) -> Void)) {
        self.view = view
        self.model = model
        self.view?.setup(title: model.name!, //swiftlint:disable:this force_unwrapping
                         placeholderImage: nil,
                         imageOrURL: Either<UIImage, URL>.right(model.thumbnailURL!), //swiftlint:disable:this force_unwrapping
                         description: model.summary ?? "",
                         comics: model.comics,
                         events: model.events,
                         stories: model.stories,
                         series: model.series,
                         toggleFavoriteCharacter: toggleFavoriteCharacter)
    }
}

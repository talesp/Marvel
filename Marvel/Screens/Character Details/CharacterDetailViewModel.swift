//
//  CharacterDetailViewModel.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

struct CharacterDetailViewModel {
    var model: Character

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

    init(model: Character) {
        self.model = model
    }
}
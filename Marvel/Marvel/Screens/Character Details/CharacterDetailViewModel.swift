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
        return model.name
    }

    var description: String {
        return model.description
    }

    var comics: [Comic] {
        return  model.comics
    }

    var stories: [Story] {
        return model.stories
    }

    var events: [Event] {
        return model.events
    }

    var series: [Serie] {
        return model.series
    }

    var image: UIImage {
        return UIImage(data: model.thumbnailData) !! "Invalid image data"
    }

    init(model: Character) {
        self.model = model
    }
}

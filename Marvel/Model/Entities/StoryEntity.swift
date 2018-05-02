//
//  StoryEntity.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 30/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation
import CoreData

extension StoryEntity: StoryModel {
    convenience init(with model: StoryModel, inContext context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = model.name
        self.resourceURI = model.resourceURI
        self.type = model.type
    }
}

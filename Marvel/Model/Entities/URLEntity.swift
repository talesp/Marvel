//
//  URLEntity.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 01/05/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation
import CoreData

extension URLEntity: URLModel {

    convenience init(with model: URLModel, inContext context: NSManagedObjectContext) {
        self.init(context: context)
        self.type = model.type
        self.urlString = model.urlString
    }

    convenience init(with url: URL, inContext context: NSManagedObjectContext) {
        self.init(context: context)
        self.urlString = url.absoluteString
    }
}

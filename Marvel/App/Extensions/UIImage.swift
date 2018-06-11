//
//  UIImage.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 30/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

extension UIImage {

    static var placeholder: UIImage {
        return UIImage(named: "placeholder") !! "image not fount: typo or not added to the project"
    }

    static var error: UIImage {
        return UIImage(named: "errorImage") !! "image not fount: typo or not added to the project"
    }

    static var loading: UIImage {
        return UIImage(named: "loadingImage") !! "image not fount: typo or not added to the project"
    }
}

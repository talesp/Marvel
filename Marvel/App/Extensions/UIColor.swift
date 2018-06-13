//
//  UIColor.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 11/06/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

extension UIColor {
    var image: UIImage {
        let rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        self.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image! //swiftlint:disable:this force_unwrapping
    }
}

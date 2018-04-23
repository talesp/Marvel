//
//  AppCoordinator.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

class AppCoordinator {

    let navigationController: UINavigationController
    private var rootViewCoordinator: CharactersListCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        rootViewCoordinator = CharactersListCoordinator(navigationController: self.navigationController)
        rootViewCoordinator?.start()
    }
}

//
//  AppDelegate.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 18/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appCoordinator: AppCoordinator?
    var window: UIWindow?

    fileprivate func setupAppearance() {
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIColor.darkGray.image, for: .default)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        let rootViewController = UINavigationController()
        window?.rootViewController = rootViewController

        appCoordinator = AppCoordinator(navigationController: rootViewController)
        appCoordinator?.start()

        setupAppearance()

        window?.makeKeyAndVisible()

        return true
    }

}

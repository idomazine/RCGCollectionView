//
//  AppDelegate.swift
//  RCGCollectionView
//
//  Created by idomazine on 2021/05/25.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = ColorPalettesViewController()
            window.makeKeyAndVisible()
            return window
        }()
        
        return true
    }
}


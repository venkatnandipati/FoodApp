//
//  AppDelegate.swift
//  FoodApp
//
//  Created by VenkateswaraReddy Nandipati on 12/07/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupCommonNavigationBar()
        return true
    }

    private func setupCommonNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor(displayP3Red: 105/255, green: 78/255, blue: 34/255, alpha: 1.0)
        UINavigationBar.appearance().backgroundColor = UIColor(displayP3Red: 122/255, green: 62/255, blue: 75/255, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().tintColor = UIColor.white
    }
}

//
//  NavigationViewController.swift
//  FoodApp
//
//  Created by VenkateswaraReddy Nandipati on 21/07/22.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCommonNavigationBar()
        jailBreakChecker()
        // Do any additional setup after loading the view.
    }
    private func setupCommonNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor(displayP3Red: 105/255, green: 78/255, blue: 34/255, alpha: 1.0)
        UINavigationBar.appearance().backgroundColor = UIColor(displayP3Red: 122/255, green: 62/255, blue: 75/255, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().tintColor = UIColor.white
    }
    private func jailBreakChecker() {
        // Jail Break Check
        if UIDevice.current.isJailBroken {
            exit(0)
        }
    }
}

//
//  HTML2StringExt.swift
//  FoodApp
//
//  Created by VenkateswaraReddy Nandipati on 12/07/22.
//

import Foundation
import UIKit

// MARK: UIStoryboard Extension
extension UIStoryboard {
    func instantiate<T>() -> T where T: UIViewController {
        guard let vc1 = instantiateViewController(withIdentifier: T.className) as? T else {
            fatalError("View Controller with identifier \(T.className) not found in \(self)")
        }
        return vc1
    }
}
extension NSObject {
    class var className: String {
        String(describing: self)
    }
}

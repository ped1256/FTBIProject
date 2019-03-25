//
//  Extensions.swift
//  FeelTheBeatInside
//
//  Created by Pedro Emanuel on 25/03/19.
//  Copyright © 2019 Pedro Emanuel. All rights reserved.
//

import Foundation
extension UIScreen {
    static func isIphoneX() -> Bool {
        let screen = UIScreen.main.bounds
        if screen.size.height >= 812 {
            return true
        } else {
            return false
        }
    }
}

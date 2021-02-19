//
//  UINavigationController+Extension.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/19.
//

import UIKit

extension UINavigationController {
    func setTransparentStyle() {
        if #available(iOS 13.0, *) {
            let barAppearance =  UINavigationBarAppearance()
            barAppearance.configureWithTransparentBackground()
            barAppearance.backgroundColor = nil
            barAppearance.shadowColor = nil
            navigationBar.standardAppearance = barAppearance
        } else {
            let image = UIImage()
            navigationBar.setBackgroundImage(image, for: .default)
            navigationBar.shadowImage = image
        }
    }
}

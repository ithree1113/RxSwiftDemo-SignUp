//
//  UIColor+Extension.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/19.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }

    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }
}

extension UIColor {
    struct FlatColor {
        struct Green {
            static let usuaoGreen = UIColor(rgb: 0x91B493)
        }
        
        struct Blue {

        }
        
        struct Violet {

        }
        
        struct Yellow {
            static let tohohYellow = UIColor(rgb: 0xFFC408)
        }
        
        struct Orange {

        }
        
        struct Red {

        }
        
        struct Gray {

        }
        
        struct Black {

        }
        
        struct White {

        }
    }
}

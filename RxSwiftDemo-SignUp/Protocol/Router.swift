//
//  Router.swift
//  RxSwiftDemo-SignUp
//
//  Created by EddieCheng on 2021/1/13.
//

import UIKit

protocol Router: class {
    func present(_ viewController: UIViewController, animated: Bool)
    
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?)
    
    func dismiss(animated: Bool)
}

extension Router {
    func present(_ viewController: UIViewController, animated: Bool) {
        present(viewController, animated: animated, onDismissed: nil)
    }
}

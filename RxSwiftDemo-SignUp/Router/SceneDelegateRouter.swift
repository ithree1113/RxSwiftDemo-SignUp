//
//  SceneDelegateRouter.swift
//  RxSwiftDemo-SignUp
//
//  Created by EddieCheng on 2021/1/13.
//

import UIKit

class SceneDelegateRouter: Router {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func dismiss(animated: Bool) {
        
    }
}

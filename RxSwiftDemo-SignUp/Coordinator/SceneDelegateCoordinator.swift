//
//  SceneDelegateCoordinator.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/19.
//

import UIKit

class SceneDelegateCoordinator: Coordinator {
    var children: [Coordinator] = []
    let router: Router
    
    //MARK: - Life cycle
    init(router: Router) {
        self.router = router
    }
    
    deinit {
        printLog(message: "")
    }
    
    //MARK: - Method
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        let vc = UIViewController(nibName: nil, bundle: nil)
        vc.view.backgroundColor = .blue
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.setTransparentStyle()
        router.present(navigationController, animated: false)
    }
}

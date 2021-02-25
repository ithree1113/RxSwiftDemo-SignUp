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
        let viewModel = SignInViewModel(apiClient: StubAPIClient.shared)
        let signInVC = SignInViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: signInVC)
        navigationController.setTransparentStyle()
        router.present(navigationController, animated: false)
        
        let navRouter = NavigationRouter(navigationController: navigationController)
        let entryCoordinator = EntryCoordinator(router: navRouter)
        signInVC.coordinator = entryCoordinator
        presentChild(entryCoordinator, animated: false) {
            
        }
    }
}

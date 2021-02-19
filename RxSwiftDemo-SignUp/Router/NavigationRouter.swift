//
//  NavigationRouter.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/19.
//

import UIKit

class NavigationRouter: NSObject {
    private let navigationController: UINavigationController
    private let routerRootViewController: UIViewController?
    private var onDismissForViewController: [UIViewController: (() -> Void)] = [:]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        routerRootViewController = navigationController.viewControllers.first
        super.init()
        navigationController.delegate = self
    }
}

extension NavigationRouter: Router {
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        onDismissForViewController[viewController] = onDismissed
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func dismiss(animated: Bool) {
        guard let routerRootViewController = routerRootViewController else {
            navigationController.popToRootViewController(animated: animated)
            return
        }
        performOnDismissed(for: routerRootViewController)
        navigationController.popToViewController(routerRootViewController, animated: animated)
    }
    
    func performOnDismissed(for viewController: UIViewController) {
        guard let onDismiss = onDismissForViewController[viewController] else {
            return
        }
        onDismiss()
        onDismissForViewController[viewController] = nil
    }
}

extension NavigationRouter: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let dismissViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(dismissViewController) else {
            return
        }
        performOnDismissed(for: dismissViewController)
    }
}

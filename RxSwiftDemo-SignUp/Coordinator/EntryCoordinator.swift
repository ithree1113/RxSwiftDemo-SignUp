//
//  EntryCoordinator.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/24.
//

import Foundation
import RxSwift
import RxCocoa


class EntryCoordinator: Coordinator {
    var children: [Coordinator] = []
    let router: Router
    
    private var onDismissed: (() -> Void)?
    
    init(router: Router) {
        self.router = router
    }
    
    deinit {
        printLog(message: "")
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        self.onDismissed = onDismissed
    }
    
    func dismiss(animated: Bool) {
        onDismissed?()
    }
}

extension EntryCoordinator: SignInVCDelegate {
    
}

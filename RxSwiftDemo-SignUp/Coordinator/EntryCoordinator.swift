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
    private let disposeBag = DisposeBag()
    
    private var signUpBtnTappedKey: Void?
    
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
    var signUpBtnTapped: PublishRelay<Void> {
        if let signUpBtnTapped = objc_getAssociatedObject(self, &signUpBtnTappedKey) as? PublishRelay<Void> {
            return signUpBtnTapped
        }
        let signUpBtnTapped = PublishRelay<Void>()
        
        signUpBtnTapped.subscribe(onNext: { [unowned self] in
            let signUpVC = SignUpViewController(delegate: self)
            router.present(signUpVC, animated: true)
        }).disposed(by: disposeBag)
        
        objc_setAssociatedObject(self, &signUpBtnTappedKey, signUpBtnTapped, .OBJC_ASSOCIATION_RETAIN)
        
        return signUpBtnTapped
    }
}

extension EntryCoordinator: SignUpVCDelegate {
    
}

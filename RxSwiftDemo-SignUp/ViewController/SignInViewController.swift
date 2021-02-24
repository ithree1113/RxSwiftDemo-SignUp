//
//  SignInViewController.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/24.
//

import UIKit
import RxSwift
import RxCocoa

protocol SignInVCDelegate: class {
    
}

class SignInViewController: UIViewController {

    weak var coordinator: SignInVCDelegate?
    
    //MARK: - Lifecycle
    init(delegate: SignInVCDelegate? = nil) {
        self.coordinator = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        printLog(message: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
    }
}

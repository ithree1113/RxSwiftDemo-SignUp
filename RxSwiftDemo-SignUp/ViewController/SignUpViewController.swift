//
//  SignUpViewController.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/24.
//

import UIKit

protocol SignUpVCDelegate: class {
    
}

class SignUpViewController: UIViewController {

    //MARK: - Private
    private weak var coordinator: SignUpVCDelegate?
    
    //MARK: - Lifecycle
    init(delegate: SignUpVCDelegate? = nil) {
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
        view.backgroundColor = .white
    }
}

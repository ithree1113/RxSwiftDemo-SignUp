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
    var signUpBtnTapped: PublishRelay<Void> { get }
}

class SignInViewController: UIViewController {

    weak var coordinator: SignInVCDelegate?
    
    //MARK: - Private
    private let accountLabel: UILabel = {
        let al = UILabel()
        al.text = "Account(3-64)"
        al.font = UIFont.systemFont(ofSize: 16)
        return al
    }()
    private let accountTextField: UITextField = {
        let atf = UITextField()
        atf.placeholder = "Please enter your account"
        atf.borderStyle = .roundedRect
        atf.layer.borderColor = UIColor.red.cgColor
        return atf
    }()
    private let passwordLabel: UILabel = {
        let pl = UILabel()
        pl.text = "Password(4-20)"
        pl.font = UIFont.systemFont(ofSize: 16)
        return pl
    }()
    private let passwordTextField: UITextField = {
        let ptf = UITextField()
        ptf.placeholder = "Please enter your password"
        ptf.borderStyle = .roundedRect
        ptf.layer.borderColor = UIColor.red.cgColor
        return ptf
    }()
    private let signInBtn: MainButton = {
        let sib = MainButton()
        sib.setTitle("Sign In", for: .normal)
        return sib
    }()
    private let seperateLine: UIView = {
        let sl = UIView()
        sl.backgroundColor = .lightGray
        return sl
    }()
    private let signUpBtn: MainButton = {
        let sub = MainButton()
        sub.setTitle("Sign up", for: .normal)
        sub.backgroundColor = UIColor.FlatColor.Green.usuaoGreen
        return sub
    }()
    
    private let viewModel: SignInViewModelType
    private let disposeBag = DisposeBag()
    
    //MARK: - Lifecycle
    init(viewModel: SignInViewModelType, delegate: SignInVCDelegate? = nil) {
        self.viewModel = viewModel
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
        
        layoutView()
        setupBinding()
    }
}

//MARK: - Binding
private extension SignInViewController {
    func setupBinding() {
        accountTextField.rx.text.orEmpty
            .bind(to: viewModel.input.account)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.input.password)
            .disposed(by: disposeBag)
        
        let isAccountValid = RxTextValidator(input: accountTextField.rx.text.orEmpty, type: .account).validate().skip(1)
            .share(replay: 1, scope: .whileConnected)
            
        let isPasswordValid = RxTextValidator(input: passwordTextField.rx.text.orEmpty, type: .password).validate().skip(1)
            .share(replay: 1, scope: .whileConnected)
            
        isAccountValid.map({ $0 ? 0 : 1 })
            .subscribe(onNext: { [unowned self] width in
                accountTextField.layer.borderWidth = width
            }).disposed(by: disposeBag)

        isPasswordValid.map({ $0 ? 0 : 1 })
            .subscribe(onNext: { [unowned self] width in
                passwordTextField.layer.borderWidth = width
            }).disposed(by: disposeBag)
        
        signInBtn.rx.tap.flatMapLatest { _ in
            Observable.combineLatest(isAccountValid, isPasswordValid) { $0 && $1 }
        }.filter({ $0 })
        .map({ _ in })
        .bind(to: viewModel.input.signInAction)
        .disposed(by: disposeBag)
        
        if let coordinator = coordinator {
            signUpBtn.rx.tap
                .bind(to: coordinator.signUpBtnTapped)
                .disposed(by: disposeBag)
        }
    }
}

//MARK: - Layout
private extension SignInViewController {
    func layoutView() {
        let layoutGuide = UILayoutGuide()
        view.addLayoutGuide(layoutGuide)
        layoutGuide.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            maker.left.equalTo(view.safeAreaLayoutGuide).offset(50)
            maker.right.equalTo(view.safeAreaLayoutGuide).offset(-50)
            maker.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(accountLabel)
        accountLabel.snp.makeConstraints { maker in
            maker.top.left.equalTo(layoutGuide)
        }
        
        view.addSubview(accountTextField)
        accountTextField.snp.makeConstraints { maker in
            maker.left.right.equalTo(layoutGuide)
            maker.top.equalTo(accountLabel.snp.bottom).offset(10)
        }
        
        view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { maker in
            maker.left.equalTo(layoutGuide)
            maker.top.equalTo(accountTextField.snp.bottom).offset(20)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { maker in
            maker.left.right.equalTo(layoutGuide)
            maker.top.equalTo(passwordLabel.snp.bottom).offset(10)
        }
        
        view.addSubview(signInBtn)
        signInBtn.snp.makeConstraints { maker in
            maker.left.right.equalTo(layoutGuide)
            maker.height.equalTo(40)
            maker.top.equalTo(passwordTextField.snp.bottom).offset(30)
        }
        
        view.addSubview(seperateLine)
        seperateLine.snp.makeConstraints { maker in
            maker.height.equalTo(1)
            maker.left.right.equalTo(layoutGuide)
            maker.top.equalTo(signInBtn.snp.bottom).offset(30)
        }
        
        view.addSubview(signUpBtn)
        signUpBtn.snp.makeConstraints { maker in
            maker.left.right.equalTo(layoutGuide)
            maker.height.equalTo(40)
            maker.top.equalTo(seperateLine.snp.bottom).offset(30)
        }
    }
}

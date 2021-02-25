//
//  SignInViewModel.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/25.
//

import Foundation
import RxSwift
import RxCocoa

protocol SignInViewModelInput {
    var account: BehaviorRelay<String> { get }
    var password: BehaviorRelay<String> { get }
    var signInAction: PublishRelay<Void> { get }
}

protocol SignInViewModelOutput {
    var signInSuccess: Driver<Void> { get }
    var errorMessage: Driver<String> { get }
}

protocol SignInViewModelType {
    var input: SignInViewModelInput { get }
    var output: SignInViewModelOutput { get }
}

class SignInViewModel: SignInViewModelType, SignInViewModelInput, SignInViewModelOutput {
    var input: SignInViewModelInput { self }
    var output: SignInViewModelOutput { self }
    
    let account = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let signInAction = PublishRelay<Void>()
    
    var signInSuccess: Driver<Void> {
        return _signInResult.asDriver(onErrorJustReturn: Void())
    }
    var errorMessage: Driver<String> {
        return _errorMessage.asDriver(onErrorJustReturn: "")
    }
    
    //MARK: - Private
    private let apiClient: APIClientProtocol
    private let disposeBag = DisposeBag()
    private let _signInResult = PublishRelay<Void>()
    private let _errorMessage = PublishRelay<String>()
    
    //MARK: - Lifecycle
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
        
        setupBinding()
    }
}

//MARK: - Binding
private extension SignInViewModel {
    func setupBinding() {
        signInAction.flatMapLatest { [unowned self] _ -> Observable<Result<AccountAPI.SignIn.ResponseType, Error>> in
            let signIn = AccountAPI.SignIn(account: account.value, password: password.value)
            return apiClient.request(signIn)
        }.subscribe(onNext: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if response.isSuccess() {
                    self._signInResult.accept(Void())
                } else {
                    self._errorMessage.accept(response.reply.message)
                }
            case .failure(let error):
                self._errorMessage.accept(error.localizedDescription)
            }
        }).disposed(by: disposeBag)
    }
}

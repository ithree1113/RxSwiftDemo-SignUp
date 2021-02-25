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
    
}

protocol SignInViewModelOutput {
    
}

protocol SignInViewModelType {
    var input: SignInViewModelInput { get }
    var output: SignInViewModelOutput { get }
}

class SignInViewModel: SignInViewModelType, SignInViewModelInput, SignInViewModelOutput {
    var input: SignInViewModelInput { self }
    var output: SignInViewModelOutput { self }
    
    //MARK: - Private
    private let apiClient: APIClientProtocol
    
    //MARK: - Lifecycle
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
}

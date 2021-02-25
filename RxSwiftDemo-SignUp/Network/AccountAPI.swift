//
//  AccountAPI.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/25.
//

import Foundation
import Moya

enum AccountAPI {
    struct SignIn: DecodableResponseTargetType {
        
        typealias ResponseType = DataResponse<SignInRespModel>
        
        var path: String { "api/signin" }
        var task: Task { .requestParameters(parameters: ["account": account, "password": password], encoding: JSONEncoding.default) }
        var sampleData: Data { "{\"status\":\"0000\",\"reply\":{\"message\":\"Success.\",\"data\":{\"id\":\"Test ID\",\"name\":\"Test\",\"status\":\"0\",\"token\":\"Test Token\"}}}".data(using: String.Encoding.utf8)!}
        
        private let account: String
        private let password: String
        
        init(account: String, password: String) {
            self.account = account
            self.password = password
        }
    }
}

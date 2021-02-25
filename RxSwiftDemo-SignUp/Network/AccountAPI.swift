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
        var sampleData: Data { "{\"status\":\"0000\",\"reply\":{\"message\":\"Success.\",\"data\":{\"id\":\"30dbb0e0-ad30-11ea-8245-295ce257d627\",\"name\":\"Test\",\"status\":\"0\",\"token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZGIuaXdlZWNhcmUuY29tXC9hcGlcL3YxXC9sb2dpbiIsImlhdCI6MTYwMzY4Nzc5OCwibmJmIjoxNjAzNjg3Nzk4LCJqdGkiOiJPQnlxeFRnTE9mZjZpT0FLIiwic3ViIjoiMzBkYmIwZTAtYWQzMC0xMWVhLTgyNDUtMjk1Y2UyNTdkNjI3IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.zrfvv5ueQGZm3in9qyI-tkpOitX0Hw2GyyWHpW5hhFk\"}}}".data(using: String.Encoding.utf8)!}
        
        private let account: String
        private let password: String
        
        init(account: String, password: String) {
            self.account = account
            self.password = password
        }
    }
}

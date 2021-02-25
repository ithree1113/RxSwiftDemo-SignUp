//
//  DecodableResponseTargetType.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/25.
//

import Foundation
import Moya

protocol DecodableResponseTargetType: TargetType {
  associatedtype ResponseType: Decodable
}

extension DecodableResponseTargetType {
    var method: Moya.Method { .post }
    var baseURL: URL { URL(string: "https://api.domain.com")! }
    var headers: [String : String]? { nil }
    var sampleData: Data { Data() }
}

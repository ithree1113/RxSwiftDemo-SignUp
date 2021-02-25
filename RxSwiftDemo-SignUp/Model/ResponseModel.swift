//
//  ResponseModel.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/25.
//

import Foundation

struct BaseResponse: Codable {
    var status: String
    let reply: BaseReply
}

struct BaseReply: Codable {
    let message: String
}

struct DataResponse<T: Codable>: Codable {
    var status: String
    let reply: DataReply<T>
}

struct DataReply<T :Codable>: Codable {
    let message: String
    let data: T?
    
    private enum CodingKeys: String, CodingKey {
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        message = try container.decode(String.self, forKey: .message)
        data = try container.decodeIfPresent(T.self, forKey: .data)
    }
}

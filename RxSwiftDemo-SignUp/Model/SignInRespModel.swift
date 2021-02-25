//
//  SignInRespModel.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/25.
//

import Foundation

struct SignInRespModel: Codable {
    let id: String
    let name: String
    let token: String
    let status: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case token
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        token = try container.decodeIfPresent(String.self, forKey: .token) ?? ""
        status = try container.decode(String.self, forKey: .status) == "1"
    }
}

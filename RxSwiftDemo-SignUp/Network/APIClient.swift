//
//  APIClient.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/25.
//

import Foundation
import Moya
import RxSwift
import Alamofire

protocol APIClientProtocol {
    var provider: MoyaProvider<MultiTarget> { get }
    func request<Request: DecodableResponseTargetType>(_ request: Request) -> Observable<Result<Request.ResponseType, Error>>
}

extension APIClientProtocol {
    func request<Request: DecodableResponseTargetType>(_ request: Request) -> Observable<Result<Request.ResponseType, Error>> {
        let target = MultiTarget.init(request)
        
        return provider.rx.request(target)
            .filterSuccessfulStatusCodes()
            .map(Request.ResponseType.self)
            .asObservable()
            .map({ Result<Request.ResponseType, Error>.success($0)})
            .catchError { error in
                Observable.just(Result<Request.ResponseType, Error>.failure(error))
        }
    }
}

class DefaultAlamofireSession: Alamofire.Session {
    static let shared: DefaultAlamofireSession = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 30 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 30 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireSession(configuration: configuration)
    }()
}

final public class APIClient: APIClientProtocol {
    
    public static let shared = APIClient()
    let provider = MoyaProvider<MultiTarget>(session: DefaultAlamofireSession.shared)
    
    private init() {}
}

final public class StubAPIClient: APIClientProtocol {
    
    public static let shared = StubAPIClient()
    let provider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub, session: DefaultAlamofireSession.shared)
    
    private init() {}
}


//
//  GlobalMethod.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/19.
//

import Foundation

func printLog<T>(message: T,
                    file: String = #file,
                  method: String = #function,
                    line: Int = #line)
{
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}

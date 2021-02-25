//
//  TextValidator.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/24.
//

import Foundation
import RxSwift
import RxCocoa

enum ValidationType {
    case account
    case password
}

class RxTextValidator {
    private let input: ControlProperty<String>
    private let type: ValidationType
    private let regex: NSPredicate
    
    init(input: ControlProperty<String>, type: ValidationType) {
        self.input = input
        self.type = type
        self.regex = NSPredicate(format:"SELF MATCHES %@", RegExPatternFactory().getRegExPattern(type))
    }
    
    func validate() -> Observable<Bool> {
        return input.map { text in
            return self.regex.evaluate(with: text)
        }
    }
}

class TextValidator {
    var input: String
    var type: ValidationType
    private let regex: NSPredicate
    
    init(input: String, type: ValidationType) {
        self.input = input
        self.type = type
        self.regex = NSPredicate(format:"SELF MATCHES %@", RegExPatternFactory().getRegExPattern(type))
    }
    
    func update(input: String, type: ValidationType) {
        self.input = input
        self.type = type
    }
    
    func validate() -> Bool {
        return self.regex.evaluate(with: input)
    }
}

private struct RegExPatternFactory {
    func getRegExPattern(_ type: ValidationType) -> String {
        
        switch type {
        case .account:
            return "^[A-Za-z0-9\\_]{3,64}$"
        case .password:
            return "^[A-Za-z0-9\\@\\#\\$\\%\\^\\&]{4,20}$"
        }
    }
}

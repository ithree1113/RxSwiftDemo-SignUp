//
//  MainButton.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/19.
//

import UIKit
import RxSwift
import RxCocoa

class MainButton: UIButton {

    let isValid = BehaviorRelay<Bool>(value: true)
    
    //MARK: - Private
    private let disposeBag = DisposeBag()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupBinding()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.midY
    }
}

//MARK: - Binding
private extension MainButton {
    func setupBinding() {
        isValid.map({ isValid in
            isValid ? UIColor.FlatColor.Yellow.tohohYellow : UIColor.lightGray
        }).bind(to: rx.backgroundColor)
        .disposed(by: disposeBag)
        
        isValid.bind(to: rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

//MARK: - Private Method
private extension MainButton {
    func setupView() {
        backgroundColor = UIColor.FlatColor.Yellow.tohohYellow
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
    }
}

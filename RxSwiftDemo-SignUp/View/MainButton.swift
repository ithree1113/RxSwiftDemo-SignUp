//
//  MainButton.swift
//  RxSwiftDemo-SignUp
//
//  Created by YuHsiang on 2021/2/19.
//

import UIKit


class MainButton: UIButton {

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.midY
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

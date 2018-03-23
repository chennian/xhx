//
//  BMDeatilAddressInputView.swift
//  fdIos
//
//  Created by MichaelChan on 2017/12/6.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import RxSwift
class ZJHeadTopicInputView: SNBaseView {
    
    var deatailText : String{
        get {
            return tv.text
        }
        set{
            placeholderLab.isHidden = newValue.utf8.count > 0 
            tv.text = newValue
        }
        
    }
    override var backgroundColor: UIColor?{
        didSet{
            tv.backgroundColor = backgroundColor
        }
    }
    var placeholderT : String {
        get {
            return placeholderLab.text!
        }
        set{
            placeholderLab.text = newValue
//            tv.text = newValue
        }
    }
    var font : UIFont?{
        didSet{
            placeholderLab.font = font
            tv.font = font
        }
    }
    var textColor : UIColor = .black{
        didSet{
            tv.textColor = textColor
        }
    }
    var placeholderColor :UIColor = .black{
        didSet{
            placeholderLab.textColor = placeholderColor
        }
    }
    override func resignFirstResponder() -> Bool {
        return tv.resignFirstResponder()
    }
    
    override func setupView() {
        addSubview(tv)
        addSubview(placeholderLab)
        tv.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
        placeholderLab.snp.makeConstraints { (make) in
            make.top.snEqualTo(20)
            make.left.snEqualTo(15)
        }
    }

    let tv = UITextView().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(32)
        
    }
    
    let placeholderLab = UILabel().then{
        $0.textColor = Color(0xcecece)
        $0.font = Font(30)
        $0.text = "说点说么吧"
    }
    
    
    override func bindEvent() {

        tv.rx.didBeginEditing.subscribe(onNext: {[unowned self] () in
            self.placeholderLab.isHidden = true
        }).disposed(by: disposeBag)
        
        
        tv.rx.didEndEditing.subscribe(onNext: {[unowned self] () in
            self.placeholderLab.isHidden = self.tv.text!.utf16.count != 0
        }).disposed(by: disposeBag)
    }

}









//
//  SNTimerButton.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/24.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import RxSwift


/// 每次点击按钮需调用start方法
class SNTimerButton: UIButton {
    
//    let buttonVari = Variable("验证码")
    
    let time : Int
    let content : String
    init(remainTime: Int, title: String = "验证码") {
        time = remainTime
        content = title
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var remainSecond = 0 {
        willSet {
//            buttonVari.value = "\(newValue)秒"
            setTitle("\(newValue)秒", for: .normal)
            if newValue <= 0 {
                isCounting = false
                isEnabled = true
//                buttonVari.value = "验证码"
                setTitle("验证码", for: .normal)
                
            }
        }
    }
    
    var countdownTimer : Timer?
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                
                remainSecond = time
                
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                
            }
            
        }
    }
    
    @objc func updateTime(timer: Timer) {
        // 计时开始时，逐秒减少remainingSeconds的值
        remainSecond -= 1
    }
    
    func start() {
        
        isEnabled = false
        isCounting = true
    }

}

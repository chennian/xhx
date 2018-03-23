//
//  SMSButton.swift
//  BaiXiangPay
//
//  Created by 蘇崢 on 2017/3/23.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class SMSButton: UIButton {

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setTitle("获取验证码", for: .normal)
		self.backgroundColor = COLOR_e60013
		self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		self.titleLabel?.textColor = UIColor.white
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setTitle("获取验证码", for: .normal)
        self.backgroundColor = COLOR_e60013
		self.layer.cornerRadius  = 5
		self.layer.masksToBounds = true
		self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
		self.titleLabel?.textColor = UIColor.white
	}
	let time = 60
	
	var startedTimer:Timer?
	var isCounting = false {
		willSet{
			if newValue {
				startedTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
				remainingSeconds = time
				self.backgroundColor = COLOR_9C9C9C
			} else {
				startedTimer?.invalidate()
				startedTimer = nil
                self.backgroundColor = COLOR_e60013
			}
			self.isEnabled = !newValue
		}
	}
	var remainingSeconds: Int = 0 {
		willSet {
			self.setTitle("\(newValue)s", for: UIControlState())
			
			if newValue <= 0 {
				self.setTitle("获取验证码", for: UIControlState())
				isCounting = false
			}
			
		}
	}
	func updateTimer(_ timer: Timer) {
		remainingSeconds -= 1
	}

	func stopCounting()->Void{
		startedTimer?.invalidate()
		startedTimer = nil
        self.backgroundColor = COLOR_e60013
	}
}

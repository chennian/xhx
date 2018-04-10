//
//  LBLoginFooterView.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/23.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBLoginFooterView: UIView {
    
    var phoeRegistAction:((_ btn:UIButton)->Void)?
    var forgotPasswordAction:((_ btn:UIButton)->Void)?
	var WeChatLoginAction:((_ btn:UIButton)->Void)?
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 235)
		setupUI()
        phoneRegistBtn.addTarget(self, action: #selector(phoneRegistAction(_:)), for: .touchUpInside)
        forgotPasswordBtn.addTarget(self, action: #selector(forgotPasswordAction(_:)), for: .touchUpInside)
		wechatBtn.addTarget(self, action: #selector(wxLoginAction(_ :)), for: .touchUpInside)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private let phoneRegistBtn = UIButton()
	private let forgotPasswordBtn = UIButton()
	private let lineView = UIView()
	private let loginLabel = UILabel()
	private let wechatBtn = UIButton()
	
	private	func setupUI() {
		addSubview(phoneRegistBtn)
		addSubview(forgotPasswordBtn)
		addSubview(lineView)
		addSubview(loginLabel)
		addSubview(wechatBtn)
		
		phoneRegistBtn.translatesAutoresizingMaskIntoConstraints = false
		forgotPasswordBtn.translatesAutoresizingMaskIntoConstraints = false
		lineView.translatesAutoresizingMaskIntoConstraints = false
		loginLabel.translatesAutoresizingMaskIntoConstraints = false
		wechatBtn.translatesAutoresizingMaskIntoConstraints = false
		
		phoneRegistBtn.setTitle("手机号注册", for: .normal)
		phoneRegistBtn.setTitleColor(COLOR_222222, for: .normal)
		phoneRegistBtn.titleLabel?.font = FONT_22PX
		
		forgotPasswordBtn.setTitle("忘记密码", for: .normal)
		forgotPasswordBtn.setTitleColor(COLOR_222222, for: .normal)
		forgotPasswordBtn.titleLabel?.font = FONT_22PX
		
		lineView.backgroundColor = COLOR_999999
		
		loginLabel.text = "其他方式登录"
		loginLabel.textAlignment = .center
		loginLabel.font = FONT_24PX
		loginLabel.backgroundColor = COLOR_ffffff
		loginLabel.textColor = COLOR_222222
		
        wechatBtn.setBackgroundImage(UIImage(named:"icon_otherLogIn_wechat"), for: .normal)
		
		addConstraint(BXLayoutConstraintMake(phoneRegistBtn, .left, .equal,self,.left,40))
		addConstraint(BXLayoutConstraintMake(phoneRegistBtn, .top, .equal,self,.top,5))
        addConstraint(BXLayoutConstraintMake(phoneRegistBtn, .height, .equal,nil,.height,40))

		addConstraint(BXLayoutConstraintMake(forgotPasswordBtn, .right, .equal,self,.right,-40))
		addConstraint(BXLayoutConstraintMake(forgotPasswordBtn, .top, .equal,self,.top, 5))
        addConstraint(BXLayoutConstraintMake(forgotPasswordBtn, .height, .equal,nil,.height,40))

		addConstraint(BXLayoutConstraintMake(lineView, .centerY, .equal,self,.centerY))
		addConstraint(BXLayoutConstraintMake(lineView, .height, .equal,nil,.height,0.5))
		addConstraint(BXLayoutConstraintMake(lineView, .left, .equal,self,.left,40))
		addConstraint(BXLayoutConstraintMake(lineView, .right, .equal,self,.right,-40))
		
		addConstraint(BXLayoutConstraintMake(loginLabel, .centerX, .equal,self,.centerX))
		addConstraint(BXLayoutConstraintMake(loginLabel, .centerY, .equal,lineView,.top))
		addConstraint(BXLayoutConstraintMake(loginLabel, .width, .equal,nil,.width,125*AUTOSIZE_X))

		addConstraint(BXLayoutConstraintMake(wechatBtn, .centerX, .equal,self,.centerX))
		addConstraint(BXLayoutConstraintMake(wechatBtn, .top, .equal,lineView,.top,30))
		addConstraint(BXLayoutConstraintMake(wechatBtn, .width, .equal,nil,.width,40))
		addConstraint(BXLayoutConstraintMake(wechatBtn, .height, .equal,nil,.height,40))
        
//        wechatBtn.isHidden = !WXManager.isWXAppInstalled
        wechatBtn.isHidden = true
        loginLabel.isHidden = true
        lineView.isHidden = true
		
	}
    func phoneRegistAction(_ btn:UIButton) {
        guard let action = phoeRegistAction else { return  }
        action(btn)
    }
    func forgotPasswordAction(_ btn:UIButton) {
        guard let action = forgotPasswordAction else { return  }
        action(btn)
    }
	func wxLoginAction(_ button:UIButton) {
		guard let action = WeChatLoginAction else { return }
		action(button)
	}
}






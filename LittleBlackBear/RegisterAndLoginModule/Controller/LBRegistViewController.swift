//
//  LBRegistViewController.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/23.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBRegistViewController: LBRegistLoginBaseViewController {
    
    fileprivate var isRedingPrivate:Bool = false
    fileprivate let protocolButton = LBPrivatePolicyButtonView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "注册"
    
        cellItems = [
            .input(imgName: "userLogoIcon", placeHolder: "请填写手机号"),
            .input(imgName: "passwordIcon", placeHolder: "请填写登录密码"),
            .verifInput(imgName: "vailMsgCodeIcon", placeHolder: "请输入验证码"),
            .button(title: "注册", height: 80),
            
        ]
        textFieldKeyBoradTys=[.phone,.password,.number,.number]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"left_arrow_white")?.withRenderingMode(.alwaysOriginal),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(popViewController))
        tableView.tableFooterView = protocolButton
        protocolButton.clickPrivateBtn = {[weak self] (button)in
            button.isSelected = !button.isSelected
            self?.isRedingPrivate = button.isSelected
        }
        protocolButton.clickPrivateDetailBtn = {[weak self](_) in
            guard let  `self` = self else{return}
            let viewController = LBPrivatePolicyWebViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.boldSystemFont(ofSize: 15.0)]
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(COLOR_e60013), for: .default)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor.white), for: .default)
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func registLoginCell(registLogin cell: LBRegistLoginCell, _ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    override func registLoginCell(registLogin cell: LBRegistLoginCell, textFieldDidEndEditing textField: UITextField) {
        super.registLoginCell(registLogin: cell, textFieldDidEndEditing: textField)
        Print(textField.text)
    }
    
    
    override func registLoginCell(registLogin cell: LBRegistLoginCell, verificationButtonClick verificationButton: SMSButton) {
        
        super.registLoginCell(registLogin: cell, verificationButtonClick: verificationButton)
        guard let phone = cellContentDict[IndexPath(row: 0, section: 0)] as? String else {
            UIAlertView(title: "提示",
                        message: "注册手机号不能，请输入手机号",
                        delegate: nil,
                        cancelButtonTitle: nil,
                        otherButtonTitles: "确定").show()
            return
        }
        verificationButton.isCounting = true 
        LBSendRegValiMsgCodeServer.sendRegValiMsgCode(phone: phone, type: "0")
    }
    override func registLoginCell(registLogin cell: LBRegistLoginCell, commitButtonClick commitButton: UIButton) {
        super.registLoginCell(registLogin: cell, commitButtonClick: commitButton)
        commitData()

        
    }
    func commitData() {
        guard let phone = cellContentDict[IndexPath(row: 0, section: 0)] as? String,phone.count > 0 else {
            UIAlertView(title: "提示",
                        message: "注册手机号不能，请输入手机号",
                        delegate: nil,
                        cancelButtonTitle: nil,
                        otherButtonTitles: "确定").show()
            return
        }
        
        guard let password  = cellContentDict[IndexPath(row: 0, section: 1)] as? String,password.count > 0 else {
            UIAlertView(title: "提示",
                        message: "密码不能为空，请输入密码",
                        delegate: nil,
                        cancelButtonTitle: nil,
                        otherButtonTitles: "确定").show()
            return
        }
        guard password.count >= 6 else {
            showAlertView("密码必须大于6位数", "确定", nil)
            return 
        }
        guard let msgCode  = cellContentDict[IndexPath(row: 0, section: 2)] as? String,msgCode.count > 0 else {
            UIAlertView(title: "提示",
                        message: "验证码不能为空，请输入验证码",
                        delegate: nil,
                        cancelButtonTitle: nil,
                        otherButtonTitles: "确定").show()
            return
        }
        
        guard isRedingPrivate == true else{
			showAlertView("请勾选 我已阅读并接受《小黑熊用户协议》", "确定", { _ in})
            return
        }
        
        let parameters:[String:Any] = [
            "phoneNumber":phone,
            "msgCode":msgCode,
            "password":password,
        ]
        
        LBKeychain.set(phone, key: PHONE_NUMBER)
        LBHttpService.LB_Request(.mobileRegister,
                                 method: .post,
                                 parameters: parameters,
                                 headers: nil,
                                 success: { [weak self] (json) in
            guard let strongSelf = self else{return}
            strongSelf.navigationController?.popViewController(animated: true)
            
            }, failure: {[weak self] (failItem) in
                guard let strongSelf = self else{return}
                strongSelf.showAlertView(failItem.message, "确定", nil)
        }) {[weak self] (error) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)
        }
    }
}

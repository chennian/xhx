//
//  LBFindPayPassswordViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/4.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBFindPayPassswordViewController: LBRegistLoginBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "找回密码"
        cellItems = [
            .input(imgName: "userLogoIcon", placeHolder: "请输入手机号"),
            .verifInput(imgName: "vailMsgCodeIcon", placeHolder: "请输入验证码"),
            .input(imgName: "passwordIcon", placeHolder: "请输入新密码"),
            .input(imgName: "passwordIcon", placeHolder: "请再次输入新密码"),
            .button(title: "下一步", height: 80),
            
        ]
        textFieldKeyBoradTys=[.phone,.number,.password,.password,.unknown]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"left_arrow_white")?.withRenderingMode(.alwaysOriginal),style: .plain,target: self, action: #selector(popViewController))
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
            UIAlertView(title: "提示", message: "手机号不能为空，请输入手机号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        verificationButton.isCounting = true
        LBSendRegValiMsgCodeServer.sendRegValiMsgCode(phone: phone, type: "2")
        
    }
    
    override func registLoginCell(registLogin cell: LBRegistLoginCell, commitButtonClick commitButton: UIButton) {
        super.registLoginCell(registLogin: cell, commitButtonClick: commitButton)
        Print(cellContentDict)
        
        guard let phone = cellContentDict[IndexPath(row: 0, section: 0)] as? String,phone.count  > 0 else {
            UIAlertView(title: "提示", message: "手机号不能为空，请输入手机号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        guard let msgCode  = cellContentDict[IndexPath(row: 0, section: 1)] as? String, msgCode.count  > 0 else {
            UIAlertView(title: "提示", message: "验证码不能为空，请输入验证码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        guard let password  = cellContentDict[IndexPath(row: 0, section: 2)] as? String,password.count  > 0 else {
            UIAlertView(title: "提示", message: "密码不能为空，请输入密码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        guard let confirmPassword = cellContentDict[IndexPath(row: 0, section: 3)] as? String, confirmPassword.count  > 0 else {
            UIAlertView(title: "提示", message: "请再次输入密码!", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        guard password.count == 6 else {
            showAlertView("密码必须等6位数", "确定", nil)
            return
        }
        guard password == confirmPassword  else {
            showAlertView("两次输入密码不一致请重新输入密码", "确定", nil)
            return
        }
        
        let parameters:[String:Any] = [
            "phoneNumber":phone,
            "msgCode":msgCode,
            "newPayPwd":password,
            "surePayPwd":confirmPassword,
            "appType":"2"
        ]
        
        LBHttpService.LB_Request(.findPayPassword, method: .post, parameters: lb_md5Parameter(parameter:parameters), headers: nil, success: {[weak self] (json) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView("找回成功", "确定",{ (_) in
                strongSelf.navigationController?.popViewController(animated: true)
            })
            }, failure: {[weak self] (failItem) in
                guard let  `self` = self else{return}
                self.showAlertView(failItem.message, "确定", nil)
                
        }) { [weak self](error) in
            guard let  `self` = self else{return}
            self.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)
        }
    }
    

}

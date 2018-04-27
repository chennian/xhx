//
//  LBBindPhoneViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/29.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBBindPhoneViewController: LBRegistLoginBaseViewController {
    
    var bindPhoneSuccessHandler:((_ phone:String,_ password:String)->())?
    // 是否是新用户
    fileprivate var isNewUser:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "绑定手机号"
        cellItems = [
            .input(imgName: "userLogoIcon", placeHolder: "请输入手机号"),
            .input(imgName: "passwordIcon", placeHolder: "请填写新密码"),
            .button(title: "下一步", height: 80),
            
        ]
        textFieldKeyBoradTys=[.phone,.password,.unknown]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"left_arrow_white")?.withRenderingMode(.alwaysOriginal),style: .plain,target: self, action: #selector(popViewController))
    }
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white,
                                                                   NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 15.0)]
        
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
        if cell.currentIndexPath?.section == 0 {
            
            let phone = textField.text ?? ""

            LBHttpService.LB_Request(.userInfoDetail, method: .get, parameters: lb_md5Parameter(parameter: ["phoneNumber":phone]), success: { (_) in
                    // 该手机号已经注册小黑熊平台
                
                }, failure: { [weak self](failItem) in
                    guard let `self` = self else {return}
                    self.isNewUser = true
                    self.cellItems = [
                        .input(imgName: "userLogoIcon", placeHolder: phone),
                        .verifInput(imgName: "vailMsgCodeIcon",placeHolder: "请输入验证码"),
                        .input(imgName: "passwordIcon", placeHolder: "请填写新密码"),
                        .button(title: "下一步", height: 80),
                        
                    ]
                    self.textFieldKeyBoradTys.insert(.number, at: 1)
                    self.tableView.reloadData()
                    self.cellContentDict[IndexPath(row: 0, section: 0)] = phone
                
            }) {[weak self] (error) in
                guard let strongSelf = self else{return}
                strongSelf.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)
            }
        }
    }
    
    
    override func registLoginCell(registLogin cell: LBRegistLoginCell, verificationButtonClick verificationButton: SMSButton) {
        super.registLoginCell(registLogin: cell, verificationButtonClick: verificationButton)
        
        guard let phone = cellContentDict[IndexPath(row: 0, section: 0)] as? String else {
            UIAlertView(title: "提示", message: "手机号不能为空，请输入手机号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        verificationButton.isCounting = true
        LBSendRegValiMsgCodeServer.sendRegValiMsgCode(phone: phone, type: "0")
        
    }
    
    override func registLoginCell(registLogin cell: LBRegistLoginCell, commitButtonClick commitButton: UIButton) {
        super.registLoginCell(registLogin: cell, commitButtonClick: commitButton)
        Print(cellContentDict)
        
        guard let phone = cellContentDict[IndexPath(row: 0, section: 0)] as? String,phone.count > 0 else {
            UIAlertView(title: "提示", message: "手机号不能为空，请输入手机号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        if  isNewUser == false {
            
            guard let password  = cellContentDict[IndexPath(row: 0, section: 1)] as? String,password.count > 0 else {
                UIAlertView(title: "提示", message: "密码不能为空，请输入密码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                return
            }
            guard password.count >= 6 else {
                showAlertView("密码必须大于6位数", "确定", nil)
                return
            }
            let parameters:[String:Any] = [
                "phoneNumber":phone,
                "openId":LBKeychain.get(WX_OPEN_ID),
                "unionId":LBKeychain.get(WX_UNION_ID),
                "password":password
                
            ]
            
            LBHttpService.LB_Request(.bindWeixinMobile, method: .post, parameters: lb_md5Parameter(parameter:parameters), headers: nil, success: {[weak self] (json) in
                guard let strongSelf = self else{return}
                guard let action = strongSelf.bindPhoneSuccessHandler else{return}
                action(phone,password)
                strongSelf.navigationController?.popViewController(animated: false)
                
                }, failure: {[weak self] (failItem) in
                    guard let `self`  = self else{return}
                    self.showAlertView(failItem.message, "确定", nil)
            }) {[weak self]  (error) in
                guard let `self`  = self else{return}
                self.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)
                
            }
            
        }else{
            
            guard let msgCode  = cellContentDict[IndexPath(row: 0, section: 1)] as? String else {
                UIAlertView(title: "提示", message: "验证码不能为空，请输入验证码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                return
            }
            
            guard let password  = cellContentDict[IndexPath(row: 0, section: 2)] as? String else {
                UIAlertView(title: "提示", message: "密码不能为空，请输入密码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                return
            }
            guard password.count >= 6 else {
                showAlertView("密码必须大于6位数", "确定", nil)
                return
            }
            let parameters:[String:Any] = [
                "phoneNumber":phone,
                "msgCode":msgCode,
                "openId":LBKeychain.get(WX_OPEN_ID),
                "unionId":LBKeychain.get(WX_UNION_ID),
                "password":password
                
            ]
            
            LBHttpService.LB_Request(.bindWeixinMobile, method: .post, parameters: lb_md5Parameter(parameter:parameters), headers: nil, success: {[weak self] (json) in
                guard let strongSelf = self else{return}
                guard let action = strongSelf.bindPhoneSuccessHandler else{return}
                action(phone,password)
                strongSelf.navigationController?.popViewController(animated: false)
                }, failure: {[weak self] (failItem) in
                    guard let `self`  = self else{return}
                    self.showAlertView(failItem.message, "确定", nil)
            }) {[weak self]  (error) in
                guard let `self`  = self else{return}
                self.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)

            }
        }

    }

}

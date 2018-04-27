//
//  LBModifyPayPasswordViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/5.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit


class LBModifyPayPasswordViewController: LBRegistLoginBaseViewController {

 
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "修改支付密码"
        cellItems = [
            .input(imgName: "passwordIcon", placeHolder: "请输入旧支付密码"),
            .input(imgName: "passwordIcon", placeHolder: "请输入新支付密码"),
            .input(imgName: "passwordIcon", placeHolder: "请确认新支付密码"),
            .button(title: "下一步", height: 80),
            
        ]
        textFieldKeyBoradTys=[.password,.password,.password]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"left_arrow_white")?.withRenderingMode(.alwaysOriginal),style: .plain,target: self, action: #selector(popViewController))
    }
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 15.0)]
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
        textField.addTarget(self, action: #selector(textFieldDidEditing(_ :)), for: .editingChanged)
        return true
    }
    
    override func registLoginCell(registLogin cell: LBRegistLoginCell, textFieldDidEndEditing textField: UITextField) {
    
        super.registLoginCell(registLogin: cell, textFieldDidEndEditing: textField)
        Print(textField.text)
    }
    
    func textFieldDidEditing(_ textField:UITextField){
        if (textField.text ?? "" ).count >= 6{
            guard let text = textField.text else{return}
            textField.text = text.substring(to: text.index(text.startIndex, offsetBy: 6))
            
        }
    }
    
    override func registLoginCell(registLogin cell: LBRegistLoginCell, commitButtonClick commitButton: UIButton) {
        super.registLoginCell(registLogin: cell, commitButtonClick: commitButton)
        
        guard let oldPassword = cellContentDict[IndexPath(row: 0, section: 0)] as? String,oldPassword.count > 0 else {
            UIAlertView(title: "提示", message: "请输入旧支付密码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        guard let nwesPassword  = cellContentDict[IndexPath(row: 0, section: 1)] as? String,nwesPassword.count > 0 else {
            UIAlertView(title: "提示", message: "请输入新支付密码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        guard let sureLoginPwd  = cellContentDict[IndexPath(row: 0, section: 2)] as? String,sureLoginPwd.count  > 0 else {
            UIAlertView(title: "提示", message: "请确认新支付密码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        guard nwesPassword == sureLoginPwd else {
            UIAlertView(title: "提示", message: "两次输入密码不一致，请重新输入", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        guard nwesPassword.count == 6 else {
            UIAlertView(title: "提示", message: "密码必须等于6位", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        let parameters:[String:Any] = [
            "mercNum":LBKeychain.get(CURRENT_MERC_ID),
            "oldActpw":oldPassword,
            "newActpw":nwesPassword,
            "okNewActpw":sureLoginPwd,
        ]
        LBHttpService.LB_Request(.updatePayPass, method: .post, parameters:lb_md5Parameter(parameter: parameters), headers: nil, success: {[weak self] (json) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView("支付密码修改成功", "确认", { (_) in
                strongSelf.navigationController?.popViewController(animated: true)
            })
            
            }, failure: {[weak self] (failItem) in
                guard let strongSelf = self else{return}
                strongSelf.showAlertView(failItem.message, "确定", nil)
                
        }) { [weak self](error) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(error.localizedDescription, "确定", nil)
        }
    }

}

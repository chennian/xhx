//
//  LBModifyLoginPassword.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/5.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBModifyLoginPassword: LBRegistLoginBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "修改登录密码"
        cellItems = [
            .input(imgName: "passwordIcon", placeHolder: "请输入旧密码"),
            .input(imgName: "passwordIcon", placeHolder: "请输入新密码"),
            .input(imgName: "passwordIcon", placeHolder: "请确认新密码"),
            .button(title: "下一步", height: 80),
            
        ]
        textFieldKeyBoradTys=[.password,.password,.password]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"left_arrow_white")?.withRenderingMode(.alwaysOriginal),style: .plain,target: self, action: #selector(popViewController))
    }
    
    @objc func popViewController() {
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
        return true
    }
    
    override func registLoginCell(registLogin cell: LBRegistLoginCell, textFieldDidEndEditing textField: UITextField) {
        super.registLoginCell(registLogin: cell, textFieldDidEndEditing: textField)
        Print(textField.text)
    }
    
    

    override func registLoginCell(registLogin cell: LBRegistLoginCell, commitButtonClick commitButton: UIButton) {
        super.registLoginCell(registLogin: cell, commitButtonClick: commitButton)
        Print(cellContentDict)
        
        guard let oldPassword = cellContentDict[IndexPath(row: 0, section: 0)] as? String else {
            UIAlertView(title: "提示", message: "旧密码不能为空,请输入旧密码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        guard let nwesPassword  = cellContentDict[IndexPath(row: 0, section: 1)] as? String else {
            UIAlertView(title: "提示", message: "请输入新密码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        guard let sureLoginPwd  = cellContentDict[IndexPath(row: 0, section: 2)] as? String else {
            UIAlertView(title: "提示", message: "请确认新密码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        guard nwesPassword.count >= 6 else {
            UIAlertView(title: "提示", message: "密码必须大于6位", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        guard nwesPassword == sureLoginPwd else {
            UIAlertView(title: "提示", message: "两次输入密码不一致，请重新输入", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        let parameters:[String:Any] = [
            "mercNum":LBKeychain.get(CURRENT_MERC_ID),
            "oldLoginPwd":oldPassword,
            "newLoginPwd":nwesPassword,
            "sureLoginPwd":sureLoginPwd,
            "appType":"2" // 1安卓  2iOS
        ]
        LBHttpService.LB_Request(.modLoginPwdCommit, method: .post, parameters:lb_md5Parameter(parameter: parameters), headers: nil, success: {[weak self] (json) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView("修改成功", "确认", { (_) in
            
                let viewController = LBLoginViewController()
                strongSelf.present(LBNavigationController(rootViewController: viewController), animated: true, completion: nil)
                viewController.loginSuccessHanlder = {
                    viewController.dismiss(animated: true, completion: nil)
                    strongSelf.navigationController?.popViewController(animated: true)
                }
                
            })
           
            }, failure: { (failItem) in
                
        }) { (error) in
            
        }
    }
 
}

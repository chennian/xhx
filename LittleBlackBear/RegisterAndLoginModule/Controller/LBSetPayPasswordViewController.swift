//
//  LBSetPayPasswordViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/29.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBSetPayPasswordViewController: LBRegistLoginBaseViewController {
    var setPayPasswordSuccessHandler:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "设置支付密码"
        cellItems = [
            .input(imgName: "passwordIcon", placeHolder: "请输入输入密码"),
            .input(imgName: "passwordIcon", placeHolder: "请再次输入密码"),
            .button(title: "设置支付密码", height: 80),
            
        ]
        textFieldKeyBoradTys=[.password,.password,.unknown]
        
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
        Print(cellContentDict)
        
        guard let password = cellContentDict[IndexPath(row: 0, section: 0)] as? String,password.count > 0 else {
            UIAlertView(title: "提示", message: "密码不能为空,请输入密码!", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        guard let confirmPassword = cellContentDict[IndexPath(row: 0, section: 1)] as? String,confirmPassword.count > 0 else {
            UIAlertView(title: "提示", message: "请再次输入密码!", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        guard password.count == 6 else {
            showAlertView("密码必须6位数", "确定", nil)
            return
        }
        guard password == confirmPassword  else {
            showAlertView("两次输入密码不一致请重新输入密码", "确定", nil)
            return
        }
    
        let parameters:[String:Any] = [
            "mercNum":LBKeychain.get(CURRENT_MERC_ID),
            "actpw":password,
            "okActpw":confirmPassword,
        ]
        
        LBHttpService.LB_Request(.setPayPassword, method: .post, parameters: lb_md5Parameter(parameter: parameters), headers: nil, success: {[weak self] (json) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(json["RSPMSG"].stringValue, "确定", {_ in
                guard let action = strongSelf.setPayPasswordSuccessHandler else{return}
                action()
                strongSelf.navigationController?.popViewController(animated: true)
            })

            }, failure: { [weak self](failItem) in
                guard let strongSelf = self else{return}
                strongSelf.showAlertView(failItem.message, "确定", nil)
        }) { [weak self](_) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)

        }
    }
    

}

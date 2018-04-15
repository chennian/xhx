//
//  LBLoginViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/23.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift

class LBLoginViewController: LBRegistLoginBaseViewController {
    
    var loginSuccessHanlder:(()->Void)?
    fileprivate let disposeBag = DisposeBag()

    fileprivate var textField_text_lenght = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellItems = [
            .input(imgName: "userLogoIcon", placeHolder: "请输入手机号码"),
            .input(imgName: "passwordIcon", placeHolder: "请输入密码"),
            .button(title: "登录", height: 80)
        ]
        textFieldKeyBoradTys=[.phone,.password]
        
        setupFooterUI()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"left_arrow_white")?.withRenderingMode(.alwaysOriginal),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(popViewController))
    }
    
    func popViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,
                                                                   NSFontAttributeName:UIFont.boldSystemFont(ofSize: 15.0)]
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(COLOR_e60013),
                                                               for: .default)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor.white), for: .default)
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
    }
    
    
    
    override func registLoginCell(registLogin cell: LBRegistLoginCell, _ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let indexPath = cell.currentIndexPath else {return true}
        if indexPath.section == 0{
            textField.addTarget(self, action: #selector(textFieldDidEditing(_ :)), for: .editingChanged)
            
        }
        return true
    }
    
    func textFieldDidEditing(_ textField:UITextField){
        
        guard let textField_text = textField.text,textField_text.count > 0 else {return}
        
        let index = textField_text.index(textField_text.startIndex, offsetBy: textField_text.count - 1 )
        
        if textField_text.count > 13 {
            textField.text = textField_text.substring(to:index )
        }
        
        guard let text = textField.text,text.count > 0 else {return}
        
        if text.count > textField_text_lenght{
            if text.count == 4 || text.count == 9{
                let str = NSMutableString(string: text)
                str.insert(" ", at: text.count-1)
                textField.text = str as String
            }
            
            textField_text_lenght = text.count
        }
        
        if text.count < textField_text_lenght{
            
            if text.count == 4 || text.count == 9{
                textField.text = text.substring(to: index)
            }
            
            textField_text_lenght = text.count
            
        }
    }
    
    override func registLoginCell(registLogin cell: LBRegistLoginCell, textFieldDidEndEditing textField: UITextField) {
        super.registLoginCell(registLogin: cell, textFieldDidEndEditing: textField)
        Print(textField.text)
    }
    
    
    override func registLoginCell(registLogin cell: LBRegistLoginCell, commitButtonClick commitButton: UIButton) {
        
        guard let phone = cellContentDict[IndexPath(row: 0, section: 0)] as? String,phone.count > 0 else {
            UIAlertView(title: "提示", message: "登录手机号不能，请输入手机号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        guard let password  = cellContentDict[IndexPath(row: 0, section: 1)] as? String,password.count > 0 else {
            UIAlertView(title: "提示", message: "登录密码不能为空，请输入登录密码", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        LBKeychain.set(phone, key: PHONE_NUMBER)
        LBLoadingView.loading.show(false)
        let phoneNum = phone.replacingOccurrences(of: " ", with: "")
        
        //新登录
        SNRequest(requestType: API.login(phone:phoneNum, password:password),modelType: [ZJLoginModel.self]).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .success(let token):
                if token.count > 0 {
                    
                    LBKeychain.set(token[0].token, key: TOKEN)
                    LBKeychain.set(LOGIN_TRUE, key: ISLOGIN)
                    //                ZJLog(messagr: token[0].timestamp)
                    self.getUserInfo(timeStamp : token[0].timestamp)
                }
                LBLoadingView.loading.dissmiss()
            case .fail(_,let msg):
                LBLoadingView.loading.dissmiss()
                UIAlertView(title: "提示", message: msg!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            default:
                break
            }
        }).disposed(by: disposeBag)
        
//        SNRequest(requestType: API.lomodelType: <#T##[SNSwiftyJSONAble.Protocol]#>)
        
        
        //久登录
//        phoneLoginRequire(phoneNum: phoneNum, password: password, success: {[weak self] (loginItem) in
//            LBKeychain.set(LOGIN_TRUE, key: ISLOGIN)
//            guard let strongSelf = self else {return}
//            guard let action = strongSelf.loginSuccessHanlder else{return}
//            action()
//            LBLoadingView.loading.dissmiss()
//        }) { (errorMsg) in
//            LBLoadingView.loading.dissmiss()
//            UIAlertView(title: "提示", message: errorMsg, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
//        }
        
    }
    
    func getUserInfo(timeStamp : String){
        SNRequest(requestType: API.userInfo(timestamp: timeStamp), modelType: [MyInfoModel.self]).subscribe(onNext: {[unowned self] (result) in
            SZHUDDismiss()
            switch result{
            case .success(let models):
                LBKeychain.set(models[0].phone, key: PHONE)
                print(LBKeychain.get(PHONE))
                LBKeychain.set(models[0].nickName, key: nickName)
                LBKeychain.set(models[0].isMer, key: isMer)
                LBKeychain.set(models[0].isAgent, key: IsAgent)
                LBKeychain.set(models[0].mercId, key: MERCID)
                guard let action = self.loginSuccessHanlder else{return}
                action()
                
            case .fail(let code,let msg):
            SZHUD(msg!, type: .error, callBack: nil)
            default: break
            }
        }).disposed(by: disposeBag)
        
//        SNRequestModel(requestType: API., modelType: <#T##SNSwiftyJSONAble.Protocol#>)
    }
    
    // footerview
    func setupFooterUI(){
        
        let footerView = LBLoginFooterView()
        tableView.tableFooterView = footerView
        footerView.phoeRegistAction = { [weak self] (button) in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.pushViewController(LBRegistViewController(), animated: true)
        }
        footerView.forgotPasswordAction={[weak self] (button) in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.pushViewController(LBForgotPasswordViewController(), animated: true)
        }
        footerView.WeChatLoginAction = {[weak self] (button) in
            guard let strongSelf = self else { return }
            WXManager.shareManager.sendAuthRequestWithController(strongSelf, strongSelf)
            
        }
    }
}
extension LBLoginViewController:WXApiManagerDelegate{
    
    func wxSendAuthSucceed(_ code: String) {}
    
    func wxLoginAuthSucceed(_ code: String) {
        // 授权登录
        wxLoginRequestUnionIDWithCode(code: code, success: {[weak self] (item) in
            guard let strongSelf = self else {return}
            guard item.unionid.count > 0, item.refresh_token.count > 0 else {return}
            // 获取用户信息
            strongSelf.requireWXUserInfoWithResult(item: item)
            
        }) { (failtItem) in
            Print(failtItem)
        }
    }
    
    func wxAuthDenied() {
    }
    
    func wxAuthCancel() {
        
    }
    
    
    
}
extension LBLoginViewController:LBLoginHttpServer{
    
    func requireWXUserInfoWithResult(item: WXLoginInfonModel) {
        
        LBLoadingView.loading.show(true)
        requireWXUserInfoWithResult(item.access_token, WX_APP_ID, success: {[weak self] (wxUserItem) in
            guard let strongSelf = self else {return}
            strongSelf.wxLoginRequire(openId: item.openid, unionId: item.unionid, success: { [weak self] (loginItem) in
                guard let strongSelf = self else {return}
                LBLoadingView.loading.dissmiss()
                if loginItem.detail.phoneNum.count == 11 {
                    guard let action = strongSelf.loginSuccessHanlder else{return}
                    action()
                    LBKeychain.set(LOGIN_TRUE, key: ISLOGIN)
                    return
                }
                
                // 绑定手机号
                let viewController = LBBindPhoneViewController()
                viewController.bindPhoneSuccessHandler = {(phone,password) in
                    strongSelf.phoneLoginRequire(phoneNum: phone, password: password, success: { (item) in
                        guard let action = strongSelf.loginSuccessHanlder else{return}
                        action()
                        LBKeychain.set(LOGIN_TRUE, key: ISLOGIN)
                    }, failure: { (_) in
                        
                    })
                }
                
                strongSelf.navigationController?.pushViewController(viewController, animated: true)
                }, failure: { (failMsg ) in
                    LBLoadingView.loading.dissmiss()
                    strongSelf.showAlertView(failMsg, "确定", nil)
            })
            
            }, failure: { (failtItem) in
                LBLoadingView.loading.dissmiss()
                Print(failtItem)
                
        })
    }
    
}

import SwiftyJSON

class ZJLoginModel : SNSwiftyJSONAble{
    var token : String
    var timestamp : String
    required init?(jsonData: JSON) {
        token = jsonData["token"].stringValue
        timestamp = jsonData["timestamp"].stringValue
//        ZJLog(messagr: jsonData)
    }
}

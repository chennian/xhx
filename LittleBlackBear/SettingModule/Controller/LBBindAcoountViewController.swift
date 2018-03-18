//
//  LBBindAcoountViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/5.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBBindAcoountViewController: UIViewController {


    fileprivate let tableView = UITableView(frame: .zero, style:.grouped)
    fileprivate var cellItem:[bindAccountType] = [bindAccountType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "账号绑定"
        setupUI()
        setupCellItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,
                                                                   NSFontAttributeName:UIFont.boldSystemFont(ofSize: 15.0)]
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(COLOR_e60013), for: .default)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupUI() {
        
        view.addSubview(tableView)
        automaticallyAdjustsScrollViewInsets = false
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|",
                                                           options: NSLayoutFormatOptions.alignAllCenterY,
                                                           metrics: nil,
                                                           views: ["tableView": tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|",
                                                           options: NSLayoutFormatOptions.alignAllCenterX,
                                                           metrics: nil,
                                                           views: ["tableView": tableView]))
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        tableView.register(LBBindAccountTableViewCell.self, forCellReuseIdentifier: "LBBindAccountTableViewCell")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"left_arrow_white")?.withRenderingMode(.alwaysOriginal),style: .plain,target: self, action: #selector(popViewController))
    }
    
    func setupCellItem()  {
        
        let phone = LBKeychain.get(PHONE_NUMBER)
        let wxOpenId = LBKeychain.get(WX_OPEN_ID)
        
        if phone.count == 11,wxOpenId.count == 0 {
            cellItem = [.phone("call_red_icon","手机号",phone),
                        .wechat("logo_wechat", "微信号", "未绑定"),
                        ]
        }
        if phone.count == 0,wxOpenId.count != 0 {
            cellItem = [.phone("call_red_icon","手机号","未绑定"),
                        .wechat("logo_wechat", "微信号", "已绑定"),
            ]
        }
        
        if phone.count == 11,wxOpenId.count > 0 {
            cellItem = [.phone("call_red_icon","手机号",phone),
                        .wechat("logo_wechat", "微信号", "已绑定")
                        ]
        }
        
        if phone.count == 0,wxOpenId.count == 0 {
            cellItem = [.phone("call_red_icon","手机号","未绑定"),
                        .wechat("logo_wechat", "微信号", "未绑定")
            ]
        }
        tableView.reloadData()
    }
    
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }


}
extension LBBindAcoountViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItem.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LBBindAccountTableViewCell = tableView.dequeueReusableCell(withIdentifier:"LBBindAccountTableViewCell" ,
                                                                            for: indexPath) as! LBBindAccountTableViewCell
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0)
        cell.type = cellItem[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch  cellItem[indexPath.row] {
        case .phone(_,_,let text):
            if text == "未绑定"{
                let viewController = LBBindPhoneViewController()
                navigationController?.pushViewController(viewController, animated: true)
            }
          
        case .wechat(_,_,let text):
            if text == "未绑定"{
                WXManager.shareManager.sendAuthRequestWithController(self, self)

            }
        }
    }
    
    
}

extension LBBindAcoountViewController:WXApiManagerDelegate{
    
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
extension LBBindAcoountViewController{
 
    
    func requireWXUserInfoWithResult(item: WXLoginInfonModel) {
        
        requireWXUserInfoWithResult(item.access_token, WX_APP_ID, success: {[weak self] (wxUserItem) in
            guard let strongSelf = self else {return}
            strongSelf.wxLoginRequire(openId: item.openid, unionId: item.unionid, success: { [weak self] (loginItem) in
                LBKeychain.set(LOGIN_TRUE, key: ISLOGIN)
                guard let strongSelf = self else {return}
                if loginItem.detail.phoneNum.count == 11{
                    return
                }
                let viewController = LBBindPhoneViewController()
                strongSelf.navigationController?.pushViewController(viewController, animated: true)
                }, failure: { (failMsg ) in
                    strongSelf.showAlertView(failMsg, "确定", nil)
            })
            
            }, failure: { (failtItem) in
                Print(failtItem)
                
        })
    }
    
    func wxLoginRequire(openId:String,unionId:String,success:@escaping(LBLoginModel<loginDetail>)->Void,failure:@escaping((String)->Void)){
        let parameters:[String:Any] = [
            "openId":openId,
            "unionId":unionId,
            "clientType":"3",//1安卓 2iOS 3微信
            "curVersion":VERSION,
            "appType":"2",
            "deviceId":DEVICEID,
            "lng":LBKeychain.get(longiduteKey),
            "lat":LBKeychain.get(latitudeKey),
            ]
        LBHttpService.LB_Request(.phone_wechat_login, method: .post, parameters:  lb_md5Parameter(parameter: parameters), headers: nil, success: { (json)in success(LBLoginModel(json: json))
        }, failure: ({failure($0.message)}), requestError: ({_ in failure(RESPONSE_FAIL_MSG)}))
    }
    
    func wxLoginRequestUnionIDWithCode(code:String,success:@escaping(WXLoginInfonModel)->Void,failure:@escaping((String)->Void)){
        let parameters:[String:Any] = ["appid":WX_APP_ID,"secret":WX_APP_SECRET,"code":code ,"grant_type":"authorization_code"]
        LBHttpManager.request(LBRequestUrlType.wxLoginURL.rawValue, method: .post, parameters:parameters , headers: nil, success: { (json) in
            success(WXLoginInfonModel(json: json))
        },failure:{error in
            failure(error.localizedDescription)
            
        })
        
    }
    
    func requireWXUserInfoWithResult(_ access_token:String, _ openid:String,success:@escaping(WXUserInfonModel)->Void,failure:@escaping((String)->Void)){
        let parameters = ["access_token":access_token,"openid":openid]
        LBHttpManager.request(LBRequestUrlType.wxInfoUrl.rawValue, method: .post, parameters:parameters , headers: nil, success: { (json) in
            success(WXUserInfonModel(json: json))
        },failure:{error in
            failure(error.localizedDescription)
        })
        
        
    }
    
}







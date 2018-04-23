//
//  LBSettingViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/19.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBSettingViewController: UIViewController {
    
    var loginSuccessHanlder:(()->())?

    fileprivate let tableView = UITableView(frame: .zero, style:.grouped)
    fileprivate var cellItem:[LBSettingCellType] = [LBSettingCellType]()
    fileprivate lazy var userLoginStatus:Bool = LBKeychain.get(ISLOGIN) == LOGIN_TRUE ? true:false
    fileprivate var cacheSize = LBCacheManger.cache.showCacheSize()/(1024*1024)
    fileprivate var isSetPayPassword:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        querPayPassStatus()
        
        setupUI()
        navigationItem.title = "设置"
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,
                                                                   NSFontAttributeName:UIFont.boldSystemFont(ofSize: 15.0)]
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(COLOR_e60013), for: .default)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        setCellItem()
        tableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        LBSettingTableViewCellFactory.registerApplyTableViewCell(tableView)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"left_arrow_white")?.withRenderingMode(.alwaysOriginal),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(popViewController))
    }
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    fileprivate func setCellItem() {
        let userStatus = LBKeychain.get(ISATHUENICATION)
        cellItem = [
            
            .rightLabel("用户昵称",(LBKeychain.get(LLNickName) != "" ? LBKeychain.get(LLNickName):"未设置"), COLOR_9C9C9C),
            .rightLabel("实名认证",(userStatus=="0" ?"已实名":"未实名"), COLOR_9C9C9C),
            .comm("提现卡变更"),
            .bindAcoountImage("账号绑定",["logo_wechat","call_red_icon"]),
            .comm("修改登录密码"),
            .comm(isSetPayPassword==true ?"找回支付密码":"设置支付密码"),
            .comm("修改支付密码"),
            .rightLabel("清除缓存", (cacheSize==0 ?"暂无缓存":"\(cacheSize) M"),COLOR_222222),
            .switch("推送设置", true),
            .rightLabel("版本信息","V \(VERSION)",COLOR_222222),
            .comm("关于公司"),
            .comm("隐私条款"),
            .comm("帮助与反馈"),
            .commitButton((userLoginStatus==true) ?"退出登录":"请登录")
            
        ]
        
        
    }
    
}
extension LBSettingViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellItem.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LBSettingTableViewCellFactory.dequeueReusableCell(withTableView: tableView, cellType: cellItem[indexPath.section])
        cell?.selectionStyle = .none
        cell?.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellItem[indexPath.section] {
        case .commitButton(_):
            return 100
        default:
            return 45
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if userLoginStatus == false {
            switch indexPath.section {
            case 0,1,2,3,4,5,6:
                presentLoginViewController()
            default:
                break
            }
        }
  
        switch cellItem[indexPath.section] {
        case .commitButton(let text):
            
            if text == "退出登录"{
                loginout()
            }
            
            if text == "请登录"{
                presentLoginViewController()
            }
            
        case let .rightLabel(text, rightText, _):
            
            if text == "清除缓存",cacheSize != 0{
                remoeCache()
            }
            if rightText == "未实名"{
                let viewController = LBAuthenicationViewController()
                viewController.authenicationSuccessHandler = {[weak self] in
                    guard let strongSelf = self else{return}
                    strongSelf.setCellItem()
                }
                navigationController?.pushViewController(viewController, animated: true)
            }
            if text == "用户昵称"{
                navigationController?.pushViewController(ZJModifyNickNameVC(), animated: true)
                
            }
            
        case let.comm(text):
            
            
            
            if text == "设置支付密码"{
                let viewController = LBSetPayPasswordViewController()
                viewController.setPayPasswordSuccessHandler = {[weak self] in
                    guard let strongSelf = self else{return}
                    strongSelf.querPayPassStatus()
                    strongSelf.setCellItem()
                }
                navigationController?.pushViewController(viewController, animated: true)
            }
            
            
            
            if text == "修改登录密码"{
                navigationController?.pushViewController(LBModifyLoginPassword(), animated: true)
                
            }
            if text == "用户基本信息"{
                navigationController?.pushViewController(LBUserInfoViewController(), animated: true)
                
            }

            if text == "找回支付密码"{
                navigationController?.pushViewController(LBFindPayPassswordViewController(), animated: true)
                
            }
            
            if text == "修改支付密码"{
                navigationController?.pushViewController(LBModifyPayPasswordViewController(), animated: true)
            }
            if text == "隐私条款"{
                navigationController?.pushViewController(LBPrivatePolicyWebViewController(), animated: true)
            }
            
            if text == "关于公司"{
                navigationController?.pushViewController(LBAbaotCompanyViewController(), animated: true)
            }
            if text == "帮助与反馈"{
                navigationController?.pushViewController(LBOpinionsWebViewController(), animated: true )
            }
       
            if text == "提现卡变更"{
                
                guard  LBKeychain.get(ISATHUENICATION) == "0" else{
                    showAlertView("请先实名认证", "确定",nil)
                    break
                }
                
                navigationController?.pushViewController(LBModifyBankCardViewController(), animated: true)
                return
            }
            
            
        case .bindAcoountImage(let text, _):
            if text == "账号绑定"{
                navigationController?.pushViewController(LBBindAcoountViewController(), animated: true)
            }
            
        default:
            break
        }
    }
    
    
}
extension LBSettingViewController:LBSettingPresenter{
    
    fileprivate func remoeCache(){
        LBCacheManger.cache.clearCache {[weak self] in
            guard let strongSelf = self else{return }
            strongSelf.cacheSize = 0
            strongSelf.setCellItem()
        }
        URLCache.shared.removeAllCachedResponses()

    }

    fileprivate func loginout(){
        let alertController = UIAlertController(title: "提示", message: "是否退出登录?", preferredStyle: .actionSheet)
        let cancle = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let transAccount = UIAlertAction(title: "切换账号", style: .default, handler: { [weak self] (_) in
            guard let strongSelf = self else{return}
            
            LBKeychain.removeKeyChain()
            strongSelf.userLoginStatus = false
            strongSelf.isSetPayPassword = false
            strongSelf.remoeCache()
            strongSelf.presentLoginViewController()
        })
        
        let confirm = UIAlertAction(title: "退出", style: .default, handler:{ [weak self](_) in
            guard let strongSelf = self else{return}
            LBKeychain.removeKeyChain()
            strongSelf.userLoginStatus = false
            strongSelf.isSetPayPassword = false
            strongSelf.remoeCache()
            strongSelf.querPayPassStatus()
            strongSelf.tableView.reloadData()
        })
        
        alertController.addAction(cancle)
        alertController.addAction(confirm)
        alertController.addAction(transAccount)
        present(alertController, animated: true, completion: nil)
        
    }
    
    fileprivate func presentLoginViewController(){
        
        let viewController = LBLoginViewController()
        present(LBNavigationController(rootViewController: viewController), animated: true, completion: nil)
        viewController.loginSuccessHanlder = {[weak self] in
            guard let strongSelf = self else{return}
            viewController.dismiss(animated: true, completion: nil)
            guard let action = strongSelf.loginSuccessHanlder else{return}
            action()
            strongSelf.navigationController?.popToRootViewController(animated: true)
            strongSelf.setCellItem()
        }
        
    }
    
    fileprivate func querPayPassStatus()  {
        query_isSetPayPassword {[weak self]  in
            guard let strongSelf = self else{return}
            strongSelf.isSetPayPassword = true
            strongSelf.setCellItem()
            strongSelf.tableView.reloadData()
        }
    }
}








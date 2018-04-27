//
//  ZJMineViewModel.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 26/4/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class ZJMineViewModel: SNBaseViewModel {

    var modelsArray : [[ZJMineFunctionCellModel]] = []
    
    let reloadPublish = PublishSubject<Void>()
    
    
    func createModels(){
        
//        let cleanCach : ()->() = { _ in
//            ZJLog(messagr: "clean cach ")
//
//        }
        
        

        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"]!
        modelsArray = [[
            ZJMineFunctionCellModel(icon: "my_ticket", name: "我的秒秒券", function: .pushToVc(vc: "ZJMyCouponViewController")),
            ZJMineFunctionCellModel(icon: "my_headline", name: "我的头条", function: .pushToVc(vc: "ZJHeadTopicManageVC")),
            ZJMineFunctionCellModel(icon: "my_autonym", name: "实名认证", function: .pushToVc(vc: "LBAuthenicationViewController")),
            ZJMineFunctionCellModel(icon: "my_password", name: "修改登录密码", function: .pushToVc(vc: "LBModifyLoginPassword")),
            ZJMineFunctionCellModel(icon: "mu_cache", name: "清除缓存", function: .blockFuntion(function: {
                self.remoeCache()
            }))
            ],[
                ZJMineFunctionCellModel(icon: "my_in_regard_to", name: "关于小黑熊", function: .pushToVc(vc: "LBAbaotCompanyViewController")),
                ZJMineFunctionCellModel(icon: "my_versions", name: "版本信息", function: .describtion(text: "v" + String(describing: version))),
                ZJMineFunctionCellModel(icon: "my_privacy", name: "服务条款", function: .pushToVc(vc: "LBPrivatePolicyWebViewController"))
            ]]
    
        if LBKeychain.get(ISLOGIN) == LOGIN_TRUE{
            modelsArray.append([ZJMineFunctionCellModel(icon: "", name: "退出登录", function: .signOut)])
        }
        
        reloadPublish.onNext(())
        
    }
    
    func getUserInfo(){
        
        
        
    }
    
    
}


extension ZJMineViewModel : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return modelsArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelsArray[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch modelsArray[indexPath.section][indexPath.row].function {
        case .signOut:
            let cell : ZJMineSignOutCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        default:
            break
        }
        let cell : ZJMineFunctionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.model = modelsArray[indexPath.section][indexPath.row]
        
        cell.line.isHidden = indexPath.row == modelsArray[indexPath.section].count - 1
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return fit(22)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch modelsArray[indexPath.section][indexPath.row].function {
        case .pushToVc(let vcString):
            if LBKeychain.get(ISLOGIN) != LOGIN_TRUE{
                
                let viewController = LBLoginViewController()
                
                viewController.loginSuccessHanlder = {() in
                    self.createModels()
                    viewController.dismiss(animated: true, completion: nil)
                }
                
                self.jumpSubject.onNext(SNJumpType.present(vc: LBNavigationController(rootViewController:viewController), anmi: true))
                return
            }
            
            let name = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
            guard let cls : AnyClass = NSClassFromString(name + "." + vcString) else {
                ZJLog(messagr: "\(name).\(vcString)类不存在")
                return
            }
            let controller = (cls as! UIViewController.Type).init()
            jumpSubject.onNext(SNJumpType.push(vc: controller, anmi: true))
        case .signOut:
            //退出登录
            self.loginout()
        case .blockFuntion(let function):
            function()
        default:
            break
        }
    }
    
    
    
    
}
extension ZJMineViewModel{
    
    fileprivate func loginout(){
        let alertController = UIAlertController(title: "提示", message: "是否退出登录?", preferredStyle: .actionSheet)
        let cancle = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let transAccount = UIAlertAction(title: "切换账号", style: .default, handler: { [weak self] (_) in
            guard let strongSelf = self else{return}
            
            LBKeychain.removeKeyChain()
//            strongSelf.userLoginStatus = false
//            strongSelf.isSetPayPassword = false
//            strongSelf.remoeCache()
            strongSelf.createModels()
            strongSelf.presentLoginViewController()
        })
        
        let confirm = UIAlertAction(title: "退出", style: .default, handler:{ (_) in
//            guard let strongSelf = self else{return}
            LBKeychain.removeKeyChain()
//            self.reloadPublish.onNext(())
            self.createModels()
        
//            strongSelf.userLoginStatus = false
//            strongSelf.isSetPayPassword = false
//            strongSelf.remoeCache()
//            strongSelf.querPayPassStatus()
//            strongSelf.tableView.reloadData()
        })
        
        alertController.addAction(cancle)
        alertController.addAction(confirm)
        alertController.addAction(transAccount)

        jumpSubject.onNext(SNJumpType.present(vc: alertController, anmi: true))
    }
    fileprivate func presentLoginViewController(){
        
        let viewController = LBLoginViewController()
//        present(, animated: true, completion: nil)
        viewController.loginSuccessHanlder = { () in
//            guard let strongSelf = self else{return}
            viewController.dismiss(animated: true, completion: nil)
//            guard let action = strongSelf.loginSuccessHanlder else{return}
//            action()
//            strongSelf.navigationController?.popToRootViewController(animated: true)
//            strongSelf.setCellItem()
        }
        jumpSubject.onNext(SNJumpType.present(vc: LBNavigationController(rootViewController: viewController), anmi: true))
        
    }
    
    fileprivate func remoeCache(){
        LBCacheManger.cache.clearCache {[weak self] in
//            guard let strongSelf = self else{return }
//            strongSelf.cacheSize = 0
//            strongSelf.setCellItem()
            SZHUD("清除成功", type: .info, callBack: nil)
        }
        URLCache.shared.removeAllCachedResponses()
        
    }
}

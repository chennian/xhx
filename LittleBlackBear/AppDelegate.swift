//
//  AppDelegate.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/10/23.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
import CocoaAsyncSocket
import Kingfisher
import IQKeyboardManagerSwift
import RxSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var _mapManager:BMKMapManager?
    
    let disposebag = DisposeBag()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        configBaidumap()
//        configJupsh(launchOptions: launchOptions)
        getUserInfo()
        PgyManager.shared().start(withAppId: PGYer_ID)
        PgyManager.shared().isFeedbackEnabled = false
        PgyUpdateManager.sharedPgy().start(withAppId: PGYer_ID)
        PgyUpdateManager.sharedPgy().checkUpdate();
        
//[[PgyManager sharedPgyManager] setEnableFeedback:NO];
        
        SZLocationManager.shareUserInfonManager.startUpLocation()
        WXManager.shareManager.registWeChat()
        
        IQKeyboardManager.sharedManager().enable = true
        
        window?.rootViewController = LBTabbarViewController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        Print(url)
        return WXApi.handleOpen(url, delegate: WXManager.shareManager)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        Print(url)
        return WXApi.handleOpen(url, delegate: WXManager.shareManager)
    }
    
    
    // MARK:**************************************RemoteNotifications******************************
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
//        JPUSHService.registerDeviceToken(deviceToken)
//        let registrationID = JPUSHService.registrationID()
//        UserDefaults.standard.set(registrationID, forKey: "registrationID")
//        UserDefaults.standard.set(registrationID, forKey: "deviceToken")
//
//        JPUSHService.setAlias(registrationID, callbackSelector: nil, object: nil)
//        Print("JPUSHService.registrationID=\(JPUSHService.registrationID())")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
//        JPUSHService.handleRemoteNotification(userInfo)
//        completionHandler(.newData)
        
        
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
//        JPUSHService.handleRemoteNotification(userInfo)
        
    }
    
    
    func getUserInfo(){
        SNRequest(requestType: API.userInfo, modelType: [MyInfoModel.self]).subscribe(onNext: { (result) in
            SZHUDDismiss()
            switch result{
            case .success(let models):
                LBKeychain.set(models[0].phone, key: PHONE)
//                print(LBKeychain.get(PHONE))
                LBKeychain.set(models[0].nickName, key: LLNickName)
                LBKeychain.set(models[0].isMer, key: isMer)
                LBKeychain.set(models[0].isAgent, key: IsAgent)
                LBKeychain.set(models[0].mercId, key: MERCID)
                LBKeychain.set(models[0].headImg, key: HeadImg)
                LBKeychain.set(LOGIN_TRUE, key: ISLOGIN)//get(ISLOGIN)  == LOGIN_TRUE
            case .fail(_,_):
                LBKeychain.set(LOGIN_FALSE, key: ISLOGIN)
//                SZHUD(msg!, type: .error, callBack: nil)
                LBKeychain.removeKeyChain()
            default:
                LBKeychain.set(LOGIN_FALSE, key: ISLOGIN)
                LBKeychain.removeKeyChain()
            }
            //headImg
        }).disposed(by: disposebag)
    }
    
    
}
// MARK:config BaiduMapSDK
extension AppDelegate:BMKGeneralDelegate{
    
    func configBaidumap() {
        _mapManager = BMKMapManager()
        let ret = _mapManager?.start(AK, generalDelegate: self)
        if ret == false {
            Print("manager start failed!")
        }
    }
    func onGetNetworkState(iError: Int32) {
        if (0 == iError) {
            Print("联网成功");
        }
        else{
            Print("联网失败，错误代码：Error\(iError)");
        }
    }
    func onGetPermissionState(iError: Int32) {
        if (0 == iError) {
            Print("授权成功");
        }
        else{
            Print("授权失败，错误代码：Error\(iError)");
        }
    }
    
}
/// Jpush
//extension AppDelegate:JPUSHRegisterDelegate{
//    
//    func configJupsh(launchOptions:[UIApplicationLaunchOptionsKey: Any]?) ->Void {
//        Print((launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? NSDictionary))
//        
//        
//        if #available(iOS 10.0, *){
//            let entiity = JPUSHRegisterEntity()
//            entiity.types = Int(UNAuthorizationOptions.alert.rawValue |
//                UNAuthorizationOptions.badge.rawValue |
//                UNAuthorizationOptions.sound.rawValue)
//            JPUSHService.register(forRemoteNotificationConfig: entiity, delegate: self)
//        } else if #available(iOS 8.0, *) {
//            
//            let types = UIUserNotificationType.badge.rawValue |
//                UIUserNotificationType.sound.rawValue |
//                UIUserNotificationType.alert.rawValue
//            JPUSHService.register(forRemoteNotificationTypes: types, categories: nil)
//        }else {
//            let type = UIRemoteNotificationType.badge.rawValue |
//                UIRemoteNotificationType.sound.rawValue |
//                UIRemoteNotificationType.alert.rawValue
//            JPUSHService.register(forRemoteNotificationTypes: type, categories: nil)
//        }
//        
//        JPUSHService.setup(withOption: launchOptions,
//                           appKey: JPushAppKey,
//                           channel: "app store",
//                           apsForProduction: true)
//    }
//    
//    
//    @available(iOS 10.0, *)
//    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
//        let userInfo = notification.request.content.userInfo
//        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
//            JPUSHService.handleRemoteNotification(userInfo)
//        } else {// 本地通知
//            
//        }
//        
//        completionHandler(Int(UNAuthorizationOptions.alert.rawValue |
//            UNAuthorizationOptions.badge.rawValue |
//            UNAuthorizationOptions.sound.rawValue))
//    }
//    
//    @available(iOS 10.0, *)
//    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
//        
//        let userInfo = response.notification.request.content.userInfo
//        
//        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
//            JPUSHService.handleRemoteNotification(userInfo)
//        } else {// 本地通知
//            
//        }
//        
//        completionHandler()
//    }
//    
//}













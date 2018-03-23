//
//  SZHUDTool.swift
//  ShenZhouDaDiXing
//
//  Created by spectator Mr.Z on 2016/12/31.
//  Copyright © 2016年 ZZC WORKSPACE. All rights reserved.
//

import UIKit
import SVProgressHUD

class SZHUDTool: NSObject {

}

extension SZHUDTool {
    
    func defaultSet() {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setDefaultMaskType(.clear)
    }
    
    func touchDis() {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setDefaultMaskType(.gradient)
    }
}

func SZHUDDismiss() {
    if SVProgressHUD.isVisible() {
    SVProgressHUD.dismiss()
    }
}

fileprivate func SZHUDLoading(_ message: String) {
    SZHUDTool().defaultSet()
    SVProgressHUD.show(withStatus: message)
}

fileprivate func SZHUDInfo(_ message: String) {
    SZHUDTool().defaultSet()
    SVProgressHUD.showInfo(withStatus: message)
}

fileprivate func SZHUDSuccess(_ message: String) {
    SZHUDTool().defaultSet()
    SVProgressHUD.showSuccess(withStatus: message)
}

enum SZHUDType {
    case error,info,success,loading
}

func SZHUD(_ message: String, type: SZHUDType, time: TimeInterval = 1, callBack: (() -> ())?) {
    
    switch type {
    case .error:
        SZHUDError(message)
    case .info:
        SZHUDInfo(message)
    case .success:
        SZHUDSuccess(message)
    case .loading:
        SZHUDLoading(message)
    
    }
    
//    if let timeL = time {
    if type != .loading {
//        _ = delay(time, task: {
//            SZHUDDismiss()
//            callBack?()
//        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: {
//            SZHUDDismiss()
            SZHUDDismiss()
            callBack?()
        })
    }
    
//    DispatchQueue.
//    }
    
}

func SZHUD(_ image: UIImage, message: String) {
    SZHUDTool().defaultSet()
    SVProgressHUD.show(image, status: message)
}
fileprivate func SZHUDError(_ message: String) {
    SZHUDTool().defaultSet()
    SVProgressHUD.showError(withStatus: message)
}

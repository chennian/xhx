//
//  DDZBaseViewModel.swift
//  diandianzanumsers
//
//  Created by 楠 on 2017/6/10.
//  Copyright © 2017年 specddz. All rights reserved.
//

import UIKit
import RxSwift

enum SNJumpType {
    case push(vc : UIViewController ,anmi : Bool )
    case pop(anmi : Bool)
    case popToVc(vc : UIViewController ,anmi : Bool )
    case present(vc : UIViewController ,anmi : Bool )
    case dismiss(anmi : Bool)
    case popToRoot(anmi : Bool)
    case custom(index : Int)
    case show(vc : UIViewController ,anmi : Bool)
}

class SNBaseViewModel: NSObject {
    let disposeBag = DisposeBag()
    let jumpSubject = PublishSubject<SNJumpType>()
    
    override init() {
        super.init()
        
        loading()
    }

}

extension SNBaseViewModel {
    
    @objc func loading() {
        
    }
    
    func validToLogin(code: Int?) {
        
        if code == 1006 || code == 1080 {
//            self.jumpSubject.onNext((DDZLoginViewController(), SNJumpType.push))
        }
        
    }
    
//    func needLogin(error: SNNetError) {
//
//        if error == .needLogin {
//
//            let loginSingle = DDZSingleton.shared
//
//            if loginSingle.isCancelLogin {
//
//            } else {
//
//                let vc = DDZLoginViewController()
//                jumpSubject.onNext((vc, .push))
//            }
//        }
//    }
}

//
//  ZJPayErcodeViewModel.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 27/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class ZJPayErcodeViewModel: SNBaseViewModel {
    
    let checkPublish = PublishSubject<(Bool,String)>()
    
    override func loading() {
        checkMerchantExit()
    }

    
    func checkMerchantExit(){
        let mercId = LBKeychain.get(CURRENT_MERC_ID)
        SNRequestString(requestType: API.checkMerchantExit(mer_id: mercId)).subscribe(onNext: { (result) in
            switch  result{
            case .bool(let name):
                //
                self.checkPublish.onNext((true, name))
            case .fail(_ ,let  msg):
                self.checkPublish.onNext((false, ""))
                SZHUD("当前用户还不是商家", type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
}

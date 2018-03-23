//
//  LBCommentPresent.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/20.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

protocol LBCommentPresent{
    func uploadCommentData()
    
}
extension LBCommentPresent where Self:LBCommentViewController{
    func uploadCommentData(){
        
        let mercId = LBKeychain.get(CURRENT_MERC_ID)
        var images:String = ""
        for url in imgUrls {
            if url != imgUrls.last{
                images.append(url+"|")
            }else{
                images.append(url)
            }
            
        }
        let parameters = lb_md5Parameter(parameter: ["mercId":mercId,
                                                     "associationId":orgCode,
                                                     "description":commentText,
                                                     "images":images,
                                                     "evaluationType":"0",
                                                     "grade":startCount])
        LBHttpService.LB_Request(.saveEvaluationInfo, method: .get, parameters: parameters, headers: nil, success: {[weak self] (json) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView("提交成功", "确定", { _ in
                guard let action = strongSelf.pubishCompetionHandler else {return}
                action()
                strongSelf.navigationController?.popViewController(animated: true)
            })
            
        }, failure: {[weak self](failItem) in
            guard let strongSelf =  self else{return}
            strongSelf.showAlertView(failItem.message, "确定",nil)
        }) { [weak self](error) in
            guard let strongSelf =  self else{return}
            strongSelf.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)
        }
    }
}


//
//  LBCommentListPresent.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/28.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

protocol LBCommentListPresent {
    func requireCommentList(pageNum:Int,
                         pageSize:String,
                         associationId:String,
                         success:@escaping((LBCommentListModel<commentImageListModel>)->Void))
}
extension LBCommentListPresent{
    
    func requireCommentList(pageNum:Int,
                         pageSize:String,
                         associationId:String,
                         success:@escaping((LBCommentListModel<commentImageListModel>)->Void)){
        let parameter = lb_md5Parameter(parameter: ["pageNum":pageNum,
                                                    "pageSize":pageSize,
                                                    "associationId":associationId,
                                                    "evaluationType":"0",
                                                    "recommendStatus":"1"
                                                    ])
        LBHttpService.LB_Request(.getEvaluationList,
                                 method: .get,
                                 parameters:parameter,
                                 success: { (json) in
            success(LBCommentListModel<commentImageListModel>(json:json))
        }, failure: { (failItem) in
            Print(failItem)
        }, requestError: { (error) in
            Print(error)
        })
    }
}

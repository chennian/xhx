//
//  BXHttpService.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/17.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
import SwiftyJSON
class LBHttpService{
   static func LB_Request(_ urlType:LBRequestUrlType ,method: HTTP_Method, parameters: [String: Any]? = nil,headers: HTTP_Headers? = nil,success: @escaping (LBJSON) ->Void, failure: @escaping (LBFailModel) ->Void,requestError: @escaping (Error) ->Void){
        let fullUrl:String = product.baseUrl + urlType.rawValue
        guard fullUrl.isURLFormate() == true else {
            Print("----- [----- URL错误!!! -----] ---- \(fullUrl)")
            return
        }
        LBHttpManager.request(fullUrl, method: method, parameters: lb_md5Parameter(parameter: parameters), headers: headers, success: { (json) in
//            Print(parameters)
//            Print(json)
            let model = LBResponseModel(json: json)
            guard model.code == RESPONSE_SUCCESS_CODE else{
                let failModel = LBFailModel(status:false, code: json["RSPCOD"].stringValue,message: json["RSPMSG"].stringValue)
                failure(failModel)
                return
            }
            success(json)
        }, failure: requestError)
        
    }
    
    static func LB_Request1(_ urlType:LBRequestUrlType ,method: HTTP_Method, parameters: [String: Any]? = nil,headers: HTTP_Headers? = nil,success: @escaping (LBJSON) ->Void, failure: @escaping (LBFailModel) ->Void,requestError: @escaping (Error) ->Void){
        let fullUrl:String = product1.baseUrl + urlType.rawValue
        guard fullUrl.isURLFormate() == true else {
            Print("----- [----- URL错误!!! -----] ---- \(fullUrl)")
            return
        }
        LBHttpManager.request(fullUrl, method: method, parameters: lb_md5Parameter(parameter: parameters), headers: headers, success: { (json) in
            Print(parameters)
            Print(json)
            let model = LBResponseModel(json: json)
            guard model.code == RESPONSE_SUCCESS_CODE else{
                let failModel = LBFailModel(status:false, code: json["RSPCOD"].stringValue,message: json["RSPMSG"].stringValue)
                failure(failModel)
                return
            }
            success(json)
        }, failure: requestError)
        
    }
    
    static func LB_Request2(_ urlType:LBRequestUrlType ,method: HTTP_Method, parameters: [String: Any]? = nil,headers: HTTP_Headers? = nil,success: @escaping (LBJSON) ->Void, failure: @escaping (LBFailModel) ->Void,requestError: @escaping (Error) ->Void){
        let fullUrl:String = product2.baseUrl + urlType.rawValue
        guard fullUrl.isURLFormate() == true else {
            Print("----- [----- URL错误!!! -----] ---- \(fullUrl)")
            return
        }
        LBHttpManager.request(fullUrl, method: method, parameters: lb_md5Parameter(parameter: parameters), headers: headers, success: { (json) in
            Print(parameters)
            Print(json)
            let model = LBResponseModel(json: json)
            guard model.code == RESPONSE_SUCCESS_CODE else{
                let failModel = LBFailModel(status:false, code: json["RSPCOD"].stringValue,message: json["RSPMSG"].stringValue)
                failure(failModel)
                return
            }
            success(json)
        }, failure: requestError)
        
    }
    
    static func LB_Request3(_ urlType:LBRequestUrlType ,method: HTTP_Method, parameters: [String: Any]? = nil,headers: HTTP_Headers? = nil,success: @escaping (LBJSON) ->Void, failure: @escaping (LBFailModel) ->Void,requestError: @escaping (Error) ->Void){
        let fullUrl:String = product3.baseUrl + urlType.rawValue
        guard fullUrl.isURLFormate() == true else {
            Print("----- [----- URL错误!!! -----] ---- \(fullUrl)")
            return
        }
        LBHttpManager.request(fullUrl, method: method, parameters:parameters, headers: headers, success: { (json) in
            Print(parameters)
            Print(json)
            let model = LBResponseModel(json: json)
            guard model.code == RESPONSE_SUCCESS_CODE else{
                let failModel = LBFailModel(status:false, code: json["RSPCOD"].stringValue,message: json["RSPMSG"].stringValue)
                failure(failModel)
                return
            }
            success(json)
        }, failure: requestError)
        
    }
    
    
   static func LB_uploadSingleImage(_ urlType:LBRequestUrlType ,_ image:UIImage, _ imgName:String, parameters: [String: Any]?,success: @escaping (LBJSON) ->Void, failure: @escaping (LBFailModel) ->Void,requestError: @escaping (Error) ->Void){
        let fullUrl:String = product.baseUrl + urlType.rawValue
        guard fullUrl.isURLFormate() == true else {
            Print("----- [----- URL错误!!! -----] ---- \(fullUrl)")
            return
        }
	LBHttpManager.uploadSingleImage(fullUrl, image, imgName, parameters as? [String : String], success: { (json) in
            let model = LBResponseModel(json: json)
            guard model.code == RESPONSE_SUCCESS_CODE else{
                let failModel = LBFailModel(status:false, code: json["RSPCOD"].stringValue,message: json["RSPMSG"].stringValue)
                failure(failModel)
                return
            }
            success(json)
        }, failure: requestError)
    }
	
}













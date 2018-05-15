//
//  API.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/6.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import Moya
//import RxMoya
import Alamofire

//var userToken = ""
//var headerFields = ["X-AUTH-TOKEN": userToken]

let testAPIProvider = RxMoyaProvider<API>(stubClosure: MoyaProvider.immediatelyStub)
let BMProvider = RxMoyaProvider<API>()

enum API {
    
    case userInfo
    
    case login(phone:String,password:String)
    
    case forgetPass(mobile:String,code:String,password:String)
    
    case register(mobile:String,code:String,password:String)
    
    case isStatus(recommend_phone:String)

    case insertMerchant(paremeter:[String:Any])
   //fabutou
    case getTuanTuanList(mercId : String,size : Int,page : Int)
    
    case getMiaoMiaoList(mercId : String,size : Int,page : Int)
    //查询头条回复
    case getReplatyList(id : String , size : Int ,page : Int)
    
    //查询头条
    case getHeadTopicList(checkPraiseId : String,mercId : String ,size : String , page : String)
    
    //评论头条
    case replayHeadTopic(headline_id : String,mer_id : String ,comments : String,reply_id : String)
    
    //点赞
    case setLike(mercId : String ,headlineId : String,state : String)
    
    ///头条详情
    case headTopicInfo(id : String , checkPraiseId : String)
    

    case deleteHeadTopic(id : String)
    
    /*
     http://pay.xiaoheixiong.net/public/merInfo?mer_id=M00000062，查询商户是否存在
     */
    /// 查询商家是否存在
    case checkMerchantExit(mer_id : String)
    
    /// 商家账本
    case merchantAccountBook(mer_id : String , type : String)
    
    /// 会员列表
    case getMemberList(mer_id : String)
    
    ///代理商账本
    case serviceAccountBook(mer_id : String)
    
    case modifyNickName(name : String)
 
    case modifyHeadIcon(headUrl : String)
    
    
    case getConpoun(coupon_id: String)
    
    case getConpounList(type : String)
    
    case getPerfectShop(page: String)
    
    case shopDetail(shopId : String)
    
    case goodsList(shopId : String)
    
    case getMiaomiaoList(shopId : String)
    
    case getCommonList(shopId : String)
    
    case publishCommon(shopId : String,description : String,images : String,grade : String)
    

    case getShopByCate(name : String)
}


extension API: JSONMappableTargetType {
    var headers: [String : String]? {
        switch self {
        case .login(let phone,let password):
            return ["X-AUTH-TOKEN":"\(phone):\(password)"]
        case .userInfo,.modifyNickName,.modifyHeadIcon,.getConpoun,.getConpounList,.publishCommon:
            return ["X-AUTH-TOKEN":LBKeychain.get(TOKEN),"X-AUTH-TIMESTAMP":LBKeychain.get(LLTimeStamp)]

        
        default:
            return [
                "Content-Type": "application/x-www-form-urlencoded;charset=utf-8"
            ]
        }
        
        
    }
    
    
    var responseType: SNSwiftyJSONAble.Type {
        return SNNetModel.self
    }
    /*
     api/getcoupon   领取卡卷  参数： coupon_id（卡卷id）
     api/getcouponList     获取卡卷列表       参数    status （  1：使用过 2：未使用  */
    
    var baseURL: URL {
        switch self {
        case .checkMerchantExit:
            return URL(string: "http://pay.xiaoheixiong.net/public/merInfo")!
    case .merchantAccountBook,.getMemberList,.serviceAccountBook,.insertMerchant,.isStatus,.login,.forgetPass,.register,.userInfo,.modifyNickName,.getConpoun,.getMiaoMiaoList,.getPerfectShop,.shopDetail,.goodsList,.getMiaomiaoList,.getCommonList,.publishCommon,.getShopByCate:
            return URL(string: "http://transaction.xiaoheixiong.net")!
//        case .getConpoun:
//            return URL(string: "http://merchant.xiaoheixiong.net/")!
            
//        case .getPerfectShop,.shopDetail,.goodsList,.getMiaomiaoList:
//            return URL(string: "http://192.168.0.3:8014/")!
        default:
            return URL(string: "http://api.xiaoheixiong.net/")!
        }
        
         }
    
    var path: String {
        switch self {
        case .userInfo:
            return "/user/userInfo"
        case .login:
            return "/api/login"
        case .forgetPass:
            return "/api/forgetPass"
        case .register:
            return "/api/register"
        case .isStatus:
            return "/api/selectRecommend"

        case .insertMerchant:
            return "/api/merchantAdd"
        case .getTuanTuanList:
            return "/activity/queryCoupon"
        case .getMiaoMiaoList:
            return "api/getKillList"
        case .getHeadTopicList:
            return "/headline/getHeadLists"
        case .getReplatyList:
            return "/headline/getHeadlineReply"
        case .replayHeadTopic:
            return "/headline/pushHeadlineReply"
        case .setLike:
            return "/headline/updatePraise"
        case .headTopicInfo:
            return "/headline/healineInfo"
        case .merchantAccountBook:
            return "/api/getMyMerchantWalletList"
        case .getMemberList:
            return "api/getFlowList"
        case .serviceAccountBook:
            return "api/getMyWalletList"
        case .deleteHeadTopic:
            return "/headline/delHeadLine"
        case .modifyNickName:
            return "user/updateNickName"
        case .getConpoun:
            return "merchant/getcoupon"
        case .modifyHeadIcon:
            return "user/updateHeadImg"
        case .getConpounList:
            return "merchant/getcouponList"
        case .getPerfectShop:
            return "api/perfectStore"
        case .shopDetail:
            return "api/merchantStoreInfo"
        case .goodsList:
            return "api/storeGoods"
        case .getMiaomiaoList:
            return "api/getKillListByShop"
//        case .checkMerchantExit:
//            return "/public/merInfo"
        case .getCommonList:
            return "api/storeReply"
        case .publishCommon:
            return "user/evaluate"
        case .getShopByCate:
            return "api/cateMerchantStore"
        default:
            return ""
        }
        
        
        
        
        
    }
    

    
    var method: Moya.Method {
        switch self {
        case .checkMerchantExit:
            return .get
        default:
            return .post
        }
        
        
    }
    
   
    
    var sampleData: Data {
        switch self {
        default:
            return "".data(using: .utf8)!
        }
    }
    


    
    var task: Task {
        
        switch self {
        case .register(let mobile,let code,let password):
            let para = ["mobile": mobile,"code":code,"password":password]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .forgetPass(let mobile,let code,let password):
            let para = ["mobile": mobile,"code":code,"password":password]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
            
        case .isStatus(let recommend_phone):
            let para = ["recommend_phone":recommend_phone]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)

        case .insertMerchant(let paremeter):
            return .requestParameters(parameters:paremeter,encoding: URLEncoding.default)
            
        case .getTuanTuanList(let mercId,let size,let page):
            let para = [
                "mercId" : mercId,
                "size": size,
                "page" : page
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .getMiaoMiaoList(let mercId,let size,let page):
            let para = [
                "mercId" : mercId,
                "size": size,
                "page" : page
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .replayHeadTopic(let headline_id,let mer_id,let comments,let reply_id):
            let para = [
                "headline_id" : headline_id,
                "mer_id": mer_id,
                "comments" : comments,
                "reply_id" : reply_id
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .getReplatyList(let id,let size,let page):
            let para = [
                "id" : id,
                "size": size,
                "page" : page
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .setLike(let  mercId  ,let headlineId ,let state):
            let para = [
                "headlineId" : headlineId,
                "mercId": mercId,
                "state" : state
                ] as [String : Any]
            
            
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .getHeadTopicList(let checkPraiseId,let mercId,let size,let page):
            let para = [
                "mercId" : mercId,
                "size": size,
                "page" : page,
                "checkPraiseId" : checkPraiseId
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .headTopicInfo(let id,let checkPraiseId):
            let para = [
                "id" : id,
                "checkPraiseId": checkPraiseId
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .checkMerchantExit(let mer_id):
            let para = [
                "mer_id" : mer_id
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .merchantAccountBook(let mer_id,let type):
            let para = [
                "mer_id" : mer_id,
                "type"  : type
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .getMemberList(let mer_id):
            let para = [
                "mer_id" : mer_id
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .serviceAccountBook(let mer_id):
            let para = [
                "mer_id" : mer_id
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .deleteHeadTopic(let id):
            let para = [
                "id" : id
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .modifyNickName(let name):
            let para = [
                "nickName" : name
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .modifyHeadIcon(let headUrl):
            let para = [
            "headUrl" : headUrl
            ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .getConpoun(let coupon_id):
            let para = [
                "coupon_id" : coupon_id
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .getConpounList(let status ):
            let para = [
                "status " : status
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .getPerfectShop(let page):
            let para = [
                "page" : page
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .shopDetail(let shopId):
            let para = [
                "shopId" : shopId
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .goodsList(let shopId):
            let para = [
                "shopId" : shopId
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .getMiaomiaoList(let shopId):
            let para = [
                "shopId" : shopId
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .getCommonList(let shopId):
            let para = [
                "shopId" : shopId
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .publishCommon(let shopId,let description,let images,let grade):
            let para = [
                "shopId" : shopId,
                "description" : description,
                "images" : images,
                "grade" : grade
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .getShopByCate(let id):
            let para = [
                "cateName" : id,
                "page" : "1"
                ] as [String : Any]
            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        default:
            return Task.requestPlain
        }

        
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}


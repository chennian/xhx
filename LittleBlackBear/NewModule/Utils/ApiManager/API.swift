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
   
}


extension API: JSONMappableTargetType {
    var headers: [String : String]? {
        switch self {
        case .login(let phone,let password):
            return ["X-AUTH-TOKEN":"\(phone):\(password)"]
        case .userInfo:
            return ["X-AUTH-TOKEN":LBKeychain.get(TOKEN)]

        default:
            return [
                "Content-Type": "application/x-www-form-urlencoded;charset=utf-8"
            ]
        }
        
        
    }
    
    
    var responseType: SNSwiftyJSONAble.Type {
        return SNNetModel.self
    }
    
    
    var baseURL: URL {
        switch self {
        case .checkMerchantExit:
            return URL(string: "http://pay.xiaoheixiong.net/public/merInfo")!
    case .merchantAccountBook,.getMemberList,.serviceAccountBook,.insertMerchant,.isStatus,.login,.forgetPass,.register,.userInfo:
            return URL(string: "http://transaction.xiaoheixiong.net")!
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
            return "/activity/queryKill"
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
        
//        case .checkMerchantExit:
//            return "/public/merInfo"
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
        default:
            return Task.requestPlain
        }
//        switch self {
//        case .getForgetPwdPhoneCode(let mobile):
//            let para = [
//                "mobile" : mobile
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .verifyCode(let mobile,let code,let vtype):
//            let para = [
//                "mobile" : mobile,
//                "code" : code,
//                "vtype" : vtype
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .setNewLoginPwd(let mobile,let code,let password):
//            let para = [
//                "mobile" : mobile,
//                "code" : code,
//                "password" : password
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .registerSendSMS(let mobile):
//            let para = [
//                "mobile" : mobile
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .registerUserDoRegister(let vcode,let  mobile ,let  password ,let  referer ):
//            let para = [
//                "mobile" : mobile,
//                "vcode" : vcode,
//                "password" : password,
//                "referer" : referer
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .modifyNickName(let nickname):
//            let para = [
//                "nickname" : nickname
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .modifyHeadIcon(let headpic):
//            let para = [
//                "headpic" : headpic
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .getPayPwdPhoneCode(let mobile):
//            let para = [
//                "mobile" : mobile
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .setPayPwd(let mobile,let password,let code):
//            let para = [
//                "mobile" : mobile,
//                "code" : code,
//                "password" : password
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .addNewAddress(let model):
//            let para = model.makeDic()
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .deleteAddress(let addr_id):
//            let para = [
//                "addr_id" : addr_id
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .setDefaultAddress(let addr_id):
//            let para = [
//                "addr_id" : addr_id
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .editAddress(let model):
//            let para = model.makeDic()
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .getAuthMessage(let mobile):
//            let para = [
//                "mobile" : mobile
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .submitAuthInformation(let model):
//            return .requestParameters(parameters: model.makeDic(type: .auth), encoding: URLEncoding.default)
//        case .moifyAuthInformation(let model):
//            return .requestParameters(parameters: model.makeDic(type: .auth), encoding: URLEncoding.default)
//        case .deleteShoppingCartList(let shopcartId):
//            let para = [
//                "shopcartId" : shopcartId
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .addIntoShoppingCartList(let goods_attr_id,let number,let type):
//            let para = [
//                "goods_attr_id" : goods_attr_id,
//                "number" : number,
//                "type" : type
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .deleteCollection(let goods_id):
//            let para = [
//                "goods_id" : goods_id
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .addIntoCollection(let goods_id):
//            let para = [
//                "goods_id" : goods_id
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .transferReturn(let mobile,let money,let verifySecret):
//            let para = [
//                "mobile" : mobile,
//                "money": money,
//                "verifySecret" : verifySecret
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .uploadOrder(let money,let banknumber,let realname,let pic):
//            let para = [
//                "money" : money,
//                "banknumber": banknumber,
//                "realname" : realname,
//                "pic" : pic
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .goodsDetail(let goods_id):
//            let para = [
//                "goods_id" : goods_id
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .planPageInfo(let activity_id):
//            let para = [
//                "activity_id" : activity_id
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .reinvest(let money,let verifySecret):
//            let para = [
//                "verifySecret" : verifySecret,
//                "money" : money
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .getGoodsListBy(let classId):
//            let para = [
//                "classId" : classId
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .searchGoods(let name):
//            let para = [
//                "name" : name
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .verifySecret(let verifySecret):
//            let para = [
//                "verifySecret" : verifySecret
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .modifyBankCard(let model):
//            return .requestParameters(parameters: model.makeDic(type: .modifyBind), encoding: URLEncoding.default)
//        case .orderList(let type):
//            let para = [
//                "status" : type
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .createOrder(let goods_attr_id,let queryId,let addr_id):
//            let para = [
//                "goods_attr_id" : goods_attr_id,
//                "queryId" : queryId,
//                "addr_id" : addr_id
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .sunmitOrder(let addr_id,let goods_attr_id,let queryId,let type,let pay_method,let use_consumption):
//            let para = [
//                "goods_attr_id" : goods_attr_id,
//                "queryId" : queryId,
//                "addr_id" : addr_id,
//                "type" : type,
//                "pay_method" : pay_method,
//                "use_consumption" : use_consumption
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .orderDetail(let order_sn):
//            let para = [
//                "order_sn" : order_sn
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .submitPlan(let activity_id):
//            let para = [
//                "activity_id" : activity_id
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .getPlanPayInfo(let activity_id,let pay_method):
//            let para = [
//                "activity_id" : activity_id,
//                "pay_method" : pay_method
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .readMessage(let id):
//            let para = [
//                "id" : id
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .certainReceived(let order_sn):
//            let para = [
//                "order_sn" : order_sn
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .cancelOrder(let order_sn):
//            let para = [
//                "order_sn" : order_sn
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .jiyoumeiWIthdraw(let money,let verifySecret):
//            let para = [
//                "money" : money,
//                "verifySecret" : verifySecret
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        case .storeWithdraw(let money,let verifySecret):
//            let para = [
//                "money" : money,
//                "verifySecret" : verifySecret
//            ]
//            return .requestParameters(parameters: para, encoding: URLEncoding.default)
//        default:
//            return Task.requestPlain
//        }
        
        
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}


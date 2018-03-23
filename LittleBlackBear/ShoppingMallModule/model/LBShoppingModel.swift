//
//  LBShoppingModel.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/4.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
import SwiftyJSON
enum shoppingCouponType {
    case second
    case group
}
struct LBShoppingModel:ResponeData {

    let infos:String
    ///标题
    let belongPlateName:String
    let belongPlateId:String
    ///商家分类
    let catas:[LBCatasModel]
    ///轮播图
    let adList:[adlist]
    ///优优商家
    let merInfos:[LBMerInfosModel]
    /// 秒秒
    let merMarkList:[LBMerMarkListModel]
    ///团团
    let groupCouponList:[LBGroupMmerMarkList]
    
    let detail:[LBJSON]
    let pages:Int
    init(json: LBJSON) {
        
        infos = json["detail"]["infos"].stringValue
        belongPlateName = json["detail"].arrayValue[0]["belongPlateName"].stringValue
        belongPlateId = (json["detail"].arrayValue[0]["belongPlateId"].stringValue)
        detail = json["detail"].arrayValue
        pages  = json["detail"].arrayValue[0]["pageInfo"]["pages"].intValue
        merInfos = json["detail"].arrayValue.flatMap{$0["pageInfo"]["list"].arrayValue.map{LBMerInfosModel(json: $0)}}
        catas = json["catas"].arrayValue.map{LBCatasModel(json: $0)}
        adList = json["adlist"].arrayValue.flatMap{adlist(json:$0)}
        merMarkList = json["merMarkList"].arrayValue.flatMap{LBMerMarkListModel(json:$0)}
        groupCouponList = json["groupMmerMarkList"].arrayValue.flatMap{LBGroupMmerMarkList(json:$0)}
    }

}

/// 商家分类
struct LBCatasModel:ResponeData{
    
    let id:String
    let iconBigIos:String
    let iconMidIos:String
    let mercid:String
    let subCataName:String
    let createTime:String
    let updateTime:String
    let createBy:String
    let state:String
    let cataType:String
    let orgcode:String
    let belongPlateId:String
    let belongPlateName:String
    let sort:String
  
    let localName: String
    
    
    
    init(json: LBJSON) {
        id = json["id"].stringValue
        
        iconBigIos = json["iconBigIos"].stringValue
        iconMidIos = json["iconMidIos"].stringValue
        mercid  = json["mercid"].stringValue
        
        subCataName = json["subCataName"].stringValue
        
        createTime = json["createTime"].stringValue
        updateTime = json["updateTime"].stringValue
        createBy = json["createBy"].stringValue
        
        state    = json["state"].stringValue
        cataType = json["cataType"].stringValue
        
        orgcode = json["orgcode"].stringValue
        
        belongPlateId   = json["belongPlateId"].stringValue
        belongPlateName = json["belongPlateName"].stringValue
        sort = json["sort"].stringValue

        if id == "1" {
            localName = "cate"
        } else if id == "2" {
            localName = "shopping"
        } else if id == "3" {
            localName = "service_for_life"
        } else if id == "4" {
            localName = "ktv"
        } else if id == "5" {
            localName = "movie"
        } else if id == "6" {
            localName = "cake"
        } else if id == "7" {
            localName = "travel_around"
        } else if id == "8" {
            localName = "beauty"
        } else {
            localName = "exercise"
        }
    }
}
/// bannar 图
struct adlist:ResponeData{
    
    let imgUrl:String
    let position:String
    let content:String
    let id:String
    let status:String
    let title:String
    let createBy:String
    let adType:String
    let linkUrl:String
    let createTime:String
    init(json: LBJSON) {
        
        imgUrl = json["imgUrl"].stringValue
        position = json["position"].stringValue
        content = json["content"].stringValue
        id = json["id"].stringValue
        status = json["status"].stringValue
        title = json["title"].stringValue
        createBy = json["createBy"].stringValue
        adType = json["adType"].stringValue
        linkUrl = json["linkUrl"].stringValue
        createTime = json["createTime"].stringValue
        
    }
}
/// 优优商家 、专属推荐 list
struct LBMerInfosModel:ResponeData {
    
    let id:String
    let mercId:String
    let orgcode:String
    let remark:String
    
    let state:Int
    let createTime:String
    let updateTime:String
    let createBy:String
    let distance:String
    let merShortName:String
    let perCapitaMoney:String
    let locationLabel:String
    let merTypeLabel:String
    
    let city:String
    let belongPlateId:String
    let belongPlateName:String
    let merLevel:String
    let subCataId:String
    
    let mainImgUrl:String
    let labelName:String
    let merAddress : String
    init(json: LBJSON) {
        id = json["id"].stringValue
        
        mercId  = json["mercId"].stringValue
        orgcode = json["orgcode"].stringValue
        remark  = json["remark"].stringValue
        
        state = json["state"].intValue
        distance = json["distance"].stringValue
        createTime = json["createTime"].stringValue
        updateTime = json["updateTime"].stringValue
        createBy = json["createBy"].stringValue
        
        
        perCapitaMoney = json["perCapitaMoney"].stringValue
        
        locationLabel = json["locationLabel"].stringValue
        merTypeLabel  = json["merTypeLabel"].stringValue
        
        city = json["city"].stringValue
        belongPlateId   = json["belongPlateId"].stringValue
        belongPlateName = json["belongPlateName"].stringValue
        
        merLevel  = json["merLevel"].stringValue
        subCataId = json["subCataId"].stringValue
        
        ///图片地址
        mainImgUrl = json["mainImgUrl"].stringValue
        ///商铺名字
        merShortName   = json["merShortName"].stringValue
        ///标签
        labelName  = json["labelName"].stringValue
        ///地址
        merAddress = json["merAddress"].stringValue
    }
}
///卡券
protocol couponData {
    var id:String {get set}// 卡券id
    var createBy:String {get set}
    var state:String {get set}
    var mercid:String {get set}
    var markExplain:String {get set}
    var minAmount:String {get set}
    var updateTime:String {get set}
    var fullGive:String {get set}
    var disAmount:String {get set}
    var orgcode:String {get set}
    var markNum:String {get set}
    var disRate:String {get set}
    var validEndDate:String {get set}
    var createTime:String {get set}
    var validStartDate:String {get set}
    var markTitle:String {get set}
    var markSubhead:String {get set}
    var useScope:Int {get set}
    var mainImgUrl:String {get set}
    var markType:String {get set}// 0 代金券、1折扣券、2团团
    var merShortName:String {get set}
}
struct ZJHomeMiaoMiaoModel : SNSwiftyJSONAble {
    var id : String
    var name : String
    var price : String
    var endTime : String
    var cardNum : String
    var mainImg : String
    var detailImg : String
    var mercId : String
    var createTime : String
    var state : String
    var isDel : String
    var merAdderess : String
    var merLabel : String
    var phone : String
    var popularity : String
    var shopName : String
    var orgcode : String
    var merAddress : String
    var description : String
    init?(jsonData: JSON) {
        self.id = jsonData["id"].stringValue
        self.name = jsonData["name"].stringValue
        self.price = jsonData["price"].stringValue
        self.endTime = jsonData["endTime"].stringValue
        self.cardNum = jsonData["cardNum"].stringValue
        self.mainImg = jsonData["mainImg"].stringValue
        self.detailImg = jsonData["detailImg"].stringValue
        self.mercId = jsonData["mercId"].stringValue
        self.createTime = jsonData["createTime"].stringValue
        self.state = jsonData["state"].stringValue
        self.isDel = jsonData["isDel"].stringValue
        self.merAdderess = jsonData["merAdderess"].stringValue
        self.merLabel = jsonData["merLabel"].stringValue
        self.phone = jsonData["phone"].stringValue
        self.popularity = jsonData["popularity"].stringValue
        self.shopName = jsonData["shopName"].stringValue
        self.orgcode = jsonData["orgcode"].stringValue
        self.merAddress = jsonData["merAddress"].stringValue
        self.description = jsonData["description"].stringValue
        
    }
    /*
     "id": 6,
     "name": "淑女服装",
     "price": "168",
     "endTime": "2018-03-31",
     "cardNum": "5",
     "mainImg": "https://litterblackbear-public-v1.oss-cn-shenzhen.aliyuncs.com/2018/0319/32334610ba1ed4289bd7bd2b967420b8.jpg",
     "detailImg": "https://litterblackbear-public-v1.oss-cn-shenzhen.aliyuncs.com/2018/0319/83b739b2bba963a872ec2e9d2f0b8f51.jpg",
     "mercId": "M00000106",
     "createTime": "2018-03-19 21:15:54",
     "state": 1,
     "isDel": 0,
     "merAdderess": null,
     "merLabel": null,
     "phone": null,
     "popularity": 22,
     "shopName": "Suli服装",
     "orgcode": "201803100950490",
     "merAddress": "贵州省贵阳市",
     "description": null
     */
}
struct ZJHomeGroupModel : SNSwiftyJSONAble {
    var id : String
    var name : String
    var price : String
    var enterNum : String
    var mainImg : String
    var detailImg : String
    var mercId : String
    var shopName : String
    var orgCode : String
    var createBy : String
    var createTime : String
    var state : String
    var isDel : String
    var merAddress : String
    var merLabel : String
    var phone : String
    var popularity : String
    var description : String
    init?(jsonData: JSON) {
        self.id = jsonData["id"].stringValue
        self.name = jsonData["name"].stringValue
        self.price = jsonData["price"].stringValue
        self.enterNum = jsonData["enterNum"].stringValue
        self.mainImg = jsonData["mainImg"].stringValue
        self.detailImg = jsonData["detailImg"].stringValue
        self.mercId = jsonData["mercId"].stringValue
        self.shopName = jsonData["shopName"].stringValue
        self.orgCode = jsonData["orgCode"].stringValue
        self.createBy = jsonData["createBy"].stringValue
        self.createTime = jsonData["createTime"].stringValue
        self.state = jsonData["state"].stringValue
        self.isDel = jsonData["isDel"].stringValue
        self.merAddress = jsonData["merAddress"].stringValue
        self.merLabel = jsonData["merLabel"].stringValue
        self.phone = jsonData["phone"].stringValue
        self.popularity = jsonData["popularity"].stringValue
        self.description = jsonData["description"].stringValue
    }
    /*
     "id": 4,
     "name": "女神服装店",
     "price": "198",
     "enterNum": 10,
     "mainImg": "https://litterblackbear-public-v1.oss-cn-shenzhen.aliyuncs.com/2018/0319/a8f5d0fe1079ac6fee18d28ea9751aa9.jpg",
     "detailImg": "https://litterblackbear-public-v1.oss-cn-shenzhen.aliyuncs.com/2018/0319/95d22d9605a86e6c4b17741d452eaf49.jpg",
     "mercId": "M00000106",
     "shopName": "Suli服装",
     "orgCode": "201803100950490",
     "createBy": null,
     "createTime": "2018-03-19 21:15:06.0",
     "state": 1,
     "isDel": 0,
     "merAddress": "贵州省贵阳市",
     "merLabel": null,
     "phone": null,
     "popularity": 32,
     "description": "穿了变女神"
     */
}

/// 团团
struct LBGroupMmerMarkList:couponData,ResponeData{

    var id: String
    var createBy: String
    var state: String
    var mercid: String
    
    var markExplain: String
    var minAmount: String
    var updateTime: String
    var fullGive: String
    
    var disAmount: String
    var orgcode: String
    var markNum: String
    var disRate: String
    
    var validEndDate: String
    var createTime: String
    var validStartDate: String
    var markTitle: String
    
    var markSubhead: String
    var useScope: Int
    var mainImgUrl: String
    var markType: String
    
    var merShortName: String
    
    init(json: LBJSON) {
        id = json["id"].stringValue
        createBy = json["createBy"].stringValue
        state = json["state"].stringValue
        mercid = json["mercid"].stringValue
        markExplain = json["markExplain"].stringValue
        minAmount = json["minAmount"].stringValue
        updateTime = json["updateTime"].stringValue
        fullGive = json["fullGive"].stringValue
        disAmount = json["disAmount"].stringValue
        orgcode = json["orgcode"].stringValue
        markNum = json["markNum"].stringValue
        disRate = json["disRate"].stringValue
        validEndDate = json["validEndDate"].stringValue
        createTime = json["createTime"].stringValue
        validStartDate = json["validStartDate"].stringValue
        markTitle = json["markTitle"].stringValue
        markSubhead = json["markSubhead"].stringValue
        useScope = json["useScope"].intValue
        mainImgUrl = json["mainImgUrl"].stringValue
        merShortName = json["merShortName"].stringValue
        
        switch json["markType"].intValue {
        case 0:
            markType = "代金券"
        case 1:
            markType = "折扣券"
        case 2:
            markType = "团购券"
        default:
            markType = ""
        }
    }
    
  
}
/// 秒秒
struct LBMerMarkListModel:couponData,ResponeData{
    
    var id: String
    var createBy: String
    var state: String
    var mercid: String
    
    var markExplain: String
    var minAmount: String
    var updateTime: String
    var fullGive: String
    
    var disAmount: String
    var orgcode: String
    var markNum: String
    var disRate: String
    
    var validEndDate: String
    var createTime: String
    var validStartDate: String
    var markTitle: String
    
    var markSubhead: String
    var useScope: Int
    var mainImgUrl: String
    var markType: String
    
    var merShortName: String

    init(json: LBJSON) {
        
        id = json["id"].stringValue
        createBy = json["createBy"].stringValue
        state = json["state"].stringValue
        mercid = json["mercid"].stringValue
        markExplain = json["markExplain"].stringValue
        minAmount = json["minAmount"].stringValue
        updateTime = json["updateTime"].stringValue
        fullGive = json["fullGive"].stringValue
        disAmount = json["disAmount"].stringValue
        orgcode = json["orgcode"].stringValue
        markNum = json["markNum"].stringValue
        disRate = json["disRate"].stringValue
        validEndDate = json["validEndDate"].stringValue
        createTime = json["createTime"].stringValue
        validStartDate = json["validStartDate"].stringValue
        markTitle = json["markTitle"].stringValue
        markSubhead = json["markSubhead"].stringValue
        useScope = json["useScope"].intValue
        mainImgUrl = json["mainImgUrl"].stringValue
        merShortName = json["merShortName"].stringValue
        
        switch json["markType"].intValue {
        case 0:
            markType = "代金券"
        case 1:
            markType = "折扣券"
        case 2:
            markType = "团购券"
        default:
            markType = ""
        }

    }
    
}

protocol LBShoppingHttpServer{
    func requiredMainIndexData(paramert:[String:Any],compeletionHandler:@escaping((LBShoppingModel)->()), failCompelectionHandler:(()->())?)

}
extension LBShoppingHttpServer{
    
    func requiredMainIndexData(paramert:[String:Any],compeletionHandler:@escaping((LBShoppingModel)->()), failCompelectionHandler:(()->())?){
        
        LBHttpService.LB_Request(.mainIndex, method: .post, parameters: paramert, headers: nil, success: { (json) in
            let model = LBShoppingModel(json: json)
            
            compeletionHandler(model)
        }, failure: { (failItem) in
            failCompelectionHandler!()
        }) { (error) in
            failCompelectionHandler!()
        }
        
    }
}

extension LBShoppingHttpServer where Self:LBShoppingMallViewController{
    
    func requiredMainIndexData(paramert:[String:Any],compeletionHandler:@escaping((LBShoppingModel)->()), failCompelectionHandler:(()->())?){
        
//        LBLoadingView.loading.show(false)
        SZHUD("加载中", type: .loading, callBack: nil)
        
        LBHttpService.LB_Request(.mainIndex, method: .post, parameters: paramert, headers: nil, success: {[weak self] (json) in
            SZHUDDismiss()
            guard let strongSelf = self else {return}
            
            strongSelf.shoppingModel = LBShoppingModel(json: json)
            /* 点击查看更多刷新，优优商家（.mixCell(_)）以分页形式返回数据,
                别的数据全部原样返回
                所以建立一个temp装 已有的.mixCell(_)
             **/
            var tempCellItem:[shoppingCellTye] = []
            strongSelf.cellItem.forEach{
                switch $0{
                case .mixCell(_):
                    tempCellItem.append($0)
                default:break
                }
            }
            
      
            
            guard let model = strongSelf.shoppingModel else{return}
            strongSelf.pages = model.pages
            //除了优优商家数据分页之外，别的板块暂无分页，所以点击查看更多时，避免数据重复，先清空cellItem
            if strongSelf.cellItem.count > 0 {
                strongSelf.cellItem.removeAll()
            }
            // 轮播图
            if model.adList.count > 0{
                strongSelf.cellItem.append(.image(model.adList.map{$0.imgUrl}))
            }
            if model.catas.count > 0 {
                strongSelf.cellItem.append(.merchantClass(model.catas))
            }
            
//           strongSelf.cellItem.append(.space(cellHight : fit(20) ,color : Color(0xe2e2e2)))
//            if strongSelf.zjPostItem.count >= 1{
//                strongSelf.cellItem.append(contentsOf: strongSelf.zjPostItem)
//            }
            strongSelf.cellItem.append(contentsOf: strongSelf.zjPostItem)
       /*
             // 秒秒 卡券
             if model.merMarkList.count > 0{
             strongSelf.cellItem.append(.title("秒秒",""))
             //                model.merMarkList.forEach{
             //                    strongSelf.cellItem.append(.secondCoupons($0))
             //                }
             strongSelf.cellItem.append(.newSecondCoupons(model.merMarkList))
             //                strongSelf.cellItem.append(.button("查看更多","秒秒"))
             }
             strongSelf.cellItem.append(.space)
             // 团团 卡券
             if model.groupCouponList.count > 0{
             strongSelf.cellItem.append(.title("团团",""))
             model.groupCouponList.forEach{
             strongSelf.cellItem.append(.groupCoupons($0))
             }
             //                strongSelf.cellItem.append(.button("查看更多","团团"))
             }
             */
            strongSelf.cellItem.append(.space(cellHight : fit(20) ,color : Color(0xf5f5f5)))
            // 专属推荐、优优商家
            if model.merInfos.count > 0{
                strongSelf.cellItem.append(.title(model.belongPlateName,""))
                model.merInfos.forEach{
                    // append分页数据
                    tempCellItem.append(.mixCell($0))
                }
                // 再把tempCellItem所有数据->cellItem
                tempCellItem.forEach{
                    switch $0{
                    case .mixCell(_):
                        strongSelf.cellItem.append($0)
                    default:break
                    }
                }
                // 清空tempCellItem
                tempCellItem.removeAll()
                //                strongSelf.cellItem.append(.button("查看更多",model.belongPlateName))
            }
            strongSelf.cellItem.append(.space(cellHight : fit(20) ,color : Color(0xf5f5f5)))
            LBLoadingView.loading.dissmiss()
            compeletionHandler(model)
            
        }, failure: { (failItem) in
            SZHUD("请求数据失败", type: .error, callBack: nil)
//            LBLoadingView.loading.dissmiss()
            failCompelectionHandler!()
            
        }) { (error) in
            LBLoadingView.loading.dissmiss()
            failCompelectionHandler!()
        }
        
    }
}

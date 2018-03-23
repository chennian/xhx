//
//  LBShoppingDetaiModel.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/13.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

struct LBHomeMerchantModel:ResponeData{
    let id:String
    let orgcode:String
    let createTime:String
    let updateTime:String
    let state:String
    let remark:String
    let headImgUrl:String
    let merExplain:String
    let merNotice:String
    let merContactTel:String
    let imgList:[imgListModel]
    let address:String
    let merLevel:String
    let labelName:String
    let subCataName:String
    let merShopName:String
    let distance:String
    let lng:Double
    let lat:Double
//    let textH:CGFloat
    let favouriteStatus:Int
    
    let explanH : CGFloat
    let noticeH : CGFloat
    init(json: LBJSON) {
        
        id = json["id"].stringValue
        orgcode = json["orgcode"].stringValue
        createTime = json["createTime"].stringValue
        updateTime = json["updateTime"].stringValue
        state = json["state"].stringValue
        remark = json["remark"].stringValue
        headImgUrl = json["headImgUrl"].stringValue
        merExplain = json["merExplain"].stringValue
        merContactTel = json["merContactTel"].stringValue
//        let i = json["merContactTel"]
//        let i = imgListModel(json:json["merContactTel"])
//        i
        imgList = json["imgList"].arrayValue.flatMap{imgListModel(json:$0)}
        address = json["address"].stringValue
        merLevel  = json["merLevel"].stringValue
        labelName = json["labelName"].stringValue
        subCataName = json["subCataName"].stringValue
        merShopName = json["merShopName"].stringValue
        distance = json["distance"].stringValue
        merNotice = json["merNotice"].stringValue
        lng = json["lng"].doubleValue
        lat = json["lat"].doubleValue
        favouriteStatus = json["favouriteStatus"].intValue
       
//        let size = CGSize(width:KSCREEN_WIDTH-48, height: CGFloat(MAXFLOAT))
//        let h1 = merExplain.boundingRect(with: size,
//                                         options: .usesLineFragmentOrigin,
//                                         attributes: [NSFontAttributeName: FONT_26PX],
//                                         context: nil).size.height+5
        
        explanH = countWidth(text: merExplain, size: CGSize.init(width: fit(670), height: CGFloat.greatestFiniteMagnitude), font: FONT_28PX).height
        noticeH = countWidth(text: merNotice, size: CGSize.init(width: fit(670), height: CGFloat.greatestFiniteMagnitude), font: FONT_28PX).height
//        let h2 = merNotice.boundingRect(with: size,
//                                        options: .usesLineFragmentOrigin,
//                                        attributes: [NSFontAttributeName: FONT_26PX],
//                                        context: nil).size.height+5

        
//        textH = h1>h2 ?h1:h2

        
    }
    
  
    
}
/// 轮播图
struct imgListModel:ResponeData{
    
    let mercId:String
    let imgUrl:String
    let imgType:String
    let id:String
    let updateTime:String
    let orgcode:String
    let createTime:String
    let state:String
    
    init(json: LBJSON) {
		
        mercId = json["mercId"].stringValue
        imgUrl = json["imgUrl"].stringValue
        imgType = json["imgType"].stringValue
        id = json["id"].stringValue
        orgcode = json["orgcode"].stringValue
        createTime = json["createTime"].stringValue
        updateTime = json["updateTime"].stringValue
        state = json["state"].stringValue
    }
}
protocol LBHomeMerchantHttpServer {
    func merIntroQuery(orgCode:String,mercId:String,userId:String,success:@escaping((LBHomeMerchantModel)->Void))
}
extension LBHomeMerchantHttpServer where Self:LBShoppingMallDetailViewController{
    
    func merIntroQuery(orgCode:String,mercId:String,userId:String,success:@escaping((LBHomeMerchantModel)->Void)) {
        LBHttpService.LB_Request(.merIntroduce, method: .post, parameters: lb_md5Parameter(parameter: ["orgCode":orgCode,"mercId":mercId,"userId":userId]), headers: nil, success: { (json) in
            success(LBHomeMerchantModel(json: json["detail"]))
        }, failure: { (failItem) in
            
        }) { (erroro) in
            
        }
    }
}
/*
 {
 "detail": {
 "id": 1,
 "orgcode": "20161202113010569.5516033072907",
 "createTime": 1511844486000,
 "updateTime": 1511844489000,
 "state": 0,
 "remark": null,
 "headImgUrl": null,
 "merExplain": null,
 "merNotice": null,
 "merContactTel": null,
 "imgList": null,
 "address": null,
 "merLevel": null,
 "labelName": null,
 "subCataName": null
 },
 "RSPCOD": "000000",
 "RSPMSG": "成功"
 }
 */

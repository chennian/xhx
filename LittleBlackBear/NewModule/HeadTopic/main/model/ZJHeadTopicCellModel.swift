//
//  ZJHeadTopicCellModel.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 18/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import SwiftyJSON


class ZJHeadTopicModel : SNSwiftyJSONAble{
    var totalPage : String
    var currentPage : String
    var size : String
    var lists : [ZJHeadTopicCellModel]
    
    required init?(jsonData: JSON) {
        self.totalPage = jsonData["totalPage"].stringValue
        self.currentPage = jsonData["currentPage"].stringValue
        self.size = jsonData["size"].stringValue
        self.lists = jsonData["lists"].arrayValue.map({return ZJHeadTopicCellModel.init(jsonData: $0)!})
    }
}

class ZJHeadTopicCellModel: SNSwiftyJSONAble {
    
    var id : String
     // 创建者
     var create_by : String
     // 创建时间
     var create_time : String
     //更新时间
     var update_date : String
     //删除标记
     var del_flag : String
     //商户ID
     var merc_id : String
     //商户名称
     var merc_name : String
     //文本
     var description : String
     //图片
     var images : [String]
     //基础点赞数
     var base_praise : String
     //真实点赞数
     var real_praise : String
     //状态 0正常 1无效 2审核中
     var status : String
     //地址
     var location_desc : String
     //纬度
     var lng : String
     //经度
     var lat : String
     //    头像
     var headImg : String
     //    回复数量
     var replyNum : String
     //转发数量
     var forwardNum : String
    
     var nickName : String
    
    var praise : Bool
 
    required init?(jsonData: JSON) {
        id = jsonData["id"].stringValue
        create_by = jsonData["create_by"].stringValue
        create_time = jsonData["create_time"].stringValue
        update_date = jsonData["update_date"].stringValue
        del_flag = jsonData["del_flag"].stringValue
        merc_id = jsonData["merc_id"].stringValue
        merc_name = jsonData["merc_name"].stringValue
//        description = jsonData["description"].stringValue//.pregReplace(pattern: "[{a-zA-Z0-9}]", with: "")
        images = []
        if NSString.hasEmoji(jsonData["description"].stringValue){
            let str = jsonData["description"].stringValue
            description = NSString.string(toEmoji: str )
        }else{
            description = jsonData["description"].stringValue
        }
        base_praise = jsonData["base_praise"].stringValue
        real_praise = jsonData["real_praise"].stringValue
        status = jsonData["status"].stringValue
        location_desc = jsonData["location_desc"].stringValue
        lat = jsonData["lat"].stringValue
        lng = jsonData["lng"].stringValue
        headImg = jsonData["headImg"].stringValue
        replyNum = jsonData["replyNum"].stringValue
        headImg = jsonData["headImg"].stringValue
        forwardNum = jsonData["forwardNum"].stringValue
        nickName = jsonData["nickName"].stringValue
        
        praise = jsonData["praise"].stringValue == "true"
        
        images = self.anayliseImgs(imgs: jsonData["images"].stringValue)
        
        
        let size = countWidth(text: description, size: CGSize.init(width: fit(710), height: CGFloat.greatestFiniteMagnitude), font: Font(34))//description.coun
        var lineNums : Int = 0
        
        if images.count == 0{
            lineNums = 0
        }else if images.count > 3 && images.count <= 6{
            lineNums = 2
        }else if images.count > 6 && images.count <= 9{
            lineNums = 3
        }
        else{
            lineNums = 1
        }
        
        height = fit(165) + fit(90) + fit(20) + size.height
        if location_desc != ""{
            height += fit(50)
        }
        
        
        
        if lineNums == 2{
            height = (height + fit(228) + fit(228) + fit(12)) + fit(28)
        }else if lineNums == 3{
            height = (height + fit(228) + fit(228) + fit(12) + fit(228) + fit(12)) + fit(28)
        }else if lineNums == 1{
            height = CGFloat(lineNums) * fit(228) + height + fit(28)
        }
        
        
        
    }
    func anayliseImgs(imgs : String) -> [String]{
        if imgs == "" {return []}
        
        var imgStr : [String] = []
        
        var Str = imgs
        
        while Str.contains("|") {
            let rang = (Str as NSString).range(of: "|")
            let img = (Str as NSString).substring(to: rang.location)
            
            imgStr.append(img)
            Str = (Str as NSString).substring(from: rang.location + 1)
        }
        
        imgStr.append(Str)
        
        return imgStr
        
        
    }
    
    var height : CGFloat = 0.0

}

extension String {
    //返回字数
    var count: Int {
        let string_NS = self as NSString
        return string_NS.length
    }
    
    //使用正则表达式替换
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
}

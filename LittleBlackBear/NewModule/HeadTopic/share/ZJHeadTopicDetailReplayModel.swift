//
//  ZJHeadTopicDetailReplayModel.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 22/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import SwiftyJSON


class ZJHeadTopicDetailInfoModel : SNSwiftyJSONAble{
    var headLineInfo : ZJHeadTopicCellModel
    var headlineReplyPOList : [ZJHeadTopicDetailReplayModel]
    var headlineInfoPraiseBOList : [ZJHeadTopicDetailPraiseModel]
    required init?(jsonData: JSON) {
        self.headLineInfo = ZJHeadTopicCellModel.init(jsonData: jsonData["headLineInfo"])!//jsonData["headLineInfo"].stringValue
        self.headlineReplyPOList = jsonData["headlineReplyPOList"].arrayValue.map({return ZJHeadTopicDetailReplayModel.init(jsonData: $0)!})
        self.headlineInfoPraiseBOList = jsonData["headlineInfoPraiseBOList"].arrayValue.map({return ZJHeadTopicDetailPraiseModel.init(jsonData: $0)!})
    }
}

class ZJHeadTopicDetailPraiseModel : SNSwiftyJSONAble {
    var id : String
    var headlineId : String
    var nickName : String
    var headImg : String
    required init?(jsonData: JSON) {
        self.id = jsonData["id"].stringValue
        self.headlineId = jsonData["headlineId"].stringValue
        self.nickName = jsonData["nickName"].stringValue
        self.headImg = jsonData["headImg"].stringValue
    }
}


class ZJHeadTopicDetailReplayModel: SNSwiftyJSONAble {
    /*
     id": 13,
     "headline_id": 280,
     "mer_id": "M00000148",
     "comments": "测试",
     "add_time": "2018-03-22 18:02:34",
     "reply_id": null,
     "headImg": "https://litterblackbear-public-v1.oss-cn-shenzhen.aliyuncs.com/2018/0320/cecb4155f3ea2cb096cd601b9d7a4fab.jpg",
     "headlineReplyVO": null
     */
    
    var id : String
    var headline_id : String
    var mer_id : String
    var comments : String
    var add_time : String
    var reply_id : String
    var headImg : String
    var headlineReplyVO : String
    var nickName : String
    required init?(jsonData: JSON) {
        self.id = jsonData["id"].stringValue
        self.headline_id = jsonData["headline_id"].stringValue
        self.mer_id = jsonData["mer_id"].stringValue
        self.comments = jsonData["comments"].stringValue
        self.add_time = jsonData["add_time"].stringValue
        self.reply_id = jsonData["reply_id"].stringValue
        self.headImg = jsonData["headImg"].stringValue
        self.headlineReplyVO = jsonData["headlineReplyVO"].stringValue
        self.nickName = jsonData["nickName"].stringValue
    }

}

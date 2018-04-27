//
//  LBCommentListModel.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/28.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

struct LBCommentListModel<commentImageListModel>: ResponeData where commentImageListModel:ResponeData{
    
    typealias T = commentImageListModel
    let pageNum:Int
    let pageSize:Int
    let size:String
    let startRow:String
    let endRow:String
    let total:String
    let pages:Int
    let list:[T]
    let firstPage:String
    let prePage:String
    let nextPage:String
    let lastPage:String
    let isFirstPage:String
    let isLastPage:String
    let hasPreviousPage:String
    let hasNextPage:String
    let navigatePages:String
    let navigatepageNums:[LBJSON]
    
    let avg_grade:Float
    let amount:Int
    init(json: LBJSON) {

        avg_grade = json["avg_grade"].floatValue
        amount = json["amount"].intValue
        
        let json:LBJSON = json["detail"]
        pageNum = json["pageNum"].intValue
        pageSize = json["pageSize"].intValue
        size = json["size"].stringValue
        startRow = json["startRow"].stringValue
        endRow = json["endRow"].stringValue
        total = json["total"].stringValue
        pages = json["pages"].intValue
        firstPage = json["firstPage"].stringValue
        prePage = json["prePage"].stringValue
        nextPage = json["nextPage"].stringValue
        lastPage = json["lastPage"].stringValue
        isFirstPage = json["isFirstPage"].stringValue
        isLastPage = json["isLastPage"].stringValue
        hasPreviousPage = json["hasPreviousPage"].stringValue
        hasNextPage = json["hasNextPage"].stringValue
        navigatePages = json["navigatePages"].stringValue
        navigatepageNums = json["navigatepageNums"].arrayValue
        list = json["list"].arrayValue.flatMap{ T(json: $0)}
        
    }
}
struct commentImageListModel:ResponeData {
    
    
    let id:String
    let description:String
    let imageList:[String]
    
    let mercId:String
    let images:String
    let mercName:String
    let mercImg:String
    
    let createDate:String
    let delFlag:String
    let publishTime:String
    let associationId:String

    let updateDate:String
    let createBy:String
    let updateBy:String
    
    let grade:Float
    let evaluationType:String
    
    var cellHeight:CGFloat
    let textH:CGFloat
    
    init(json: LBJSON) {
        
        id = json["id"].stringValue
        description = json["description"].stringValue
        imageList = json["imageList"].arrayValue.flatMap{$0.stringValue}
        
        mercId = json["mercId"].stringValue
        images = json["images"].stringValue
        mercName = json["mercName"].stringValue
        mercImg  = json["mercImg"].stringValue
        
        publishTime = json["publishTime"].stringValue
        grade = json["grade"].floatValue
        evaluationType = json["evaluationType"].stringValue
        associationId  = json["associationId"].stringValue

        createDate = json["createDate"].stringValue
        delFlag = json["delFlag"].stringValue
        
        updateDate = json["updateDate"].stringValue
        
        createBy = json["createBy"].stringValue
        updateBy = json["updateBy"].stringValue
        
        let size = CGSize(width:KSCREEN_WIDTH-28, height: CGFloat(MAXFLOAT))
        textH = description.boundingRect(with: size,
                                         options: .usesLineFragmentOrigin,
                                         attributes: [NSAttributedStringKey.font: FONT_26PX],
                                         context: nil).size.height
        
        let marginY:CGFloat = 10
        let topMargin:CGFloat = 10
        
        let row = (imageList.count > 0) ?CGFloat(Int((imageList.count-1)/3+1)):0
        cellHeight = row*((KSCREEN_WIDTH-40)/3)+(row-1)*marginY+topMargin+textH + 60 + 10

        
    }
    
    
}

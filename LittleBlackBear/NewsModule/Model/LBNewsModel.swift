//
//  LBNewsModel.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/12/14.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

struct LBNewsModel<imageListModel>: ResponeData where imageListModel:ResponeData{
    
    typealias T = imageListModel
    let pageNum:String
    let pageSize:String
    let size:String
    let startRow:String
    let endRow:String
    let total:Int
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
    
    init(json: LBJSON) {
        
        pageNum = json["pageNum"].stringValue
        pageSize = json["pageSize"].stringValue
        size = json["size"].stringValue
        startRow = json["startRow"].stringValue
        endRow = json["endRow"].stringValue
        total = json["total"].intValue
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
struct imageListModel:ResponeData {
    
    var basePraise:String
    var createDate:String
    let delFlag:String
    let startRow:String
    var description:String
    let id:Int
    let imageList:[String]
    let updateDate:String
    let mercId:String
    let images:String
    let mercName:String
    let mercImg:String
    let createBy:String
    let updateBy:String
    let locationDesc:String
    let identityDesc:String
    let publishTime:String
    var realPraise:Int
    
    let cellHeight:CGFloat// = ScreenH
    let textH:CGFloat
	var imageArray:[UIImage]?

    init(json: LBJSON) {
        
        basePraise = json["basePraise"].stringValue
        createDate = json["createDate"].stringValue
        delFlag = json["delFlag"].stringValue
        startRow = json["startRow"].stringValue
        description = json["description"].stringValue
        id = json["id"].intValue
        imageList = json["imageList"].arrayValue.flatMap{$0.stringValue}
        updateDate = json["updateDate"].stringValue
        mercId = json["mercId"].stringValue
        images = json["images"].stringValue
        mercName = json["mercName"].stringValue
        mercImg = json["mercImg"].stringValue
        createBy = json["createBy"].stringValue
        updateBy = json["updateBy"].stringValue
        locationDesc = json["locationDesc"].stringValue
        identityDesc = json["identityDesc"].stringValue
        publishTime = json["publishTime"].stringValue
        createDate = json["createDate"].stringValue
        realPraise = json["realPraise"].intValue
        basePraise = json["basePraise"].stringValue
        description = json["description"].stringValue
		
	
		
		
        let size = CGSize(width:KSCREEN_WIDTH-28, height: CGFloat(MAXFLOAT))
        textH = description.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: FONT_26PX], context: nil).size.height+10
        
        
        let row = (imageList.count > 0) ?CGFloat(Int((imageList.count-1)/3+1)):0
        let marginY:CGFloat = 6
        let topMargin:CGFloat = 10
		
        cellHeight = row*((KSCREEN_WIDTH-40)/3)+(row-1)*marginY+topMargin+textH + 60 + 30

		
	}
    
    
}


protocol LBNewsHttpServer {
    /// news
    func requireNewsList(pageNum:Int,pageSize:String,success:@escaping((LBNewsModel<imageListModel>)->Void))
    /// 点赞
    func praiseAction(mercId:String,id:Int,index:Int)
    /// 领取游戏卡券
    func getGameCoupon(success:@escaping((LBGameModel)->()),fail:@escaping(()->()))
}
extension LBNewsHttpServer where Self:LBNewsViewController{
    
    func requireNewsList(pageNum:Int,pageSize:String,success:@escaping((LBNewsModel<imageListModel>)->Void)){
        LBLoadingView.loading.show(false)
        LBHttpService.LB_Request(.headlineInfo,
								 method: .get,
								 parameters: lb_md5Parameter(parameter: ["pageNum":pageNum,"pageSize":pageSize]),
								 headers: nil,
								 success: {[weak self] (json) in
            guard let strongSelf = self else{return}
            
            success(LBNewsModel<imageListModel>(json:json["detail"]))
			
            LBLoadingView.loading.dissmiss()
            strongSelf.tableView.stopPullRefreshEver()
			strongSelf.tableView.stopPushRefreshEver()
			
        }, failure: { [weak self](failItem) in
            guard let strongSelf  = self else{return}
            strongSelf.tableView.stopPullRefreshEver()
			strongSelf.tableView.stopPushRefreshEver()
            LBLoadingView.loading.dissmiss()
			
		}, requestError: {[weak self] (error) in
                guard let strongSelf  = self else{return}
                strongSelf.tableView.stopPullRefreshEver()
				strongSelf.tableView.stopPushRefreshEver()
                LBLoadingView.loading.dissmiss()
                
        })
    }
    
    func praiseAction(mercId:String,id:Int,index:Int){
        let parameters:[String:Any] = ["mercId":mercId,"id":id]
        LBHttpService.LB_Request(.praiseHeadlineInfo,
								 method: .get,
								 parameters: parameters,
								 success: { [weak self](json) in
            guard let strongSelf = self else{return}
            strongSelf.priseButtonSelectTypes[index] = true
            
            }, failure: {[weak self] (failItem) in
                guard let strongSelf = self else{return}
                strongSelf.showAlertView(failItem.message, "确定", nil)
                strongSelf.priseButtonSelectTypes[index] = false
                
        }) { [weak self](error) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)
            strongSelf.priseButtonSelectTypes[index] = false
            
        }
        
    }
    
    func getGameCoupon(success:@escaping ((LBGameModel)->()),fail:@escaping (()->())){
        
        SZLocationManager.shareUserInfonManager.startUpLocation()
        let lat:String = LBKeychain.get(latitudeKey)
        let lng:String = LBKeychain.get(longiduteKey)
        let mercId:String = LBKeychain.get(CURRENT_MERC_ID)
        let parameters:[String:Any] = ["mercId":mercId,"lat":lat,"lng":lng]
        LBHttpService.LB_Request(.getGameCoupon,
								 method: .post,
								 parameters: lb_md5Parameter(parameter: parameters),
								 success: {(json) in
            success(LBGameModel(json: json["detail"]))
        }, failure: {  (failItem) in
            fail()
        }) { (error) in
            fail()
        }
    }
    
}


extension LBNewsHttpServer where Self:LBMyNewsViewController{
    
    func requireNewsList(pageNum:Int,pageSize:String,success:@escaping((LBNewsModel<imageListModel>)->Void)){
        LBLoadingView.loading.show(false)
        LBHttpService.LB_Request(.headlineInfo,
                                 method: .get,
                                 parameters: lb_md5Parameter(parameter: ["pageNum":pageNum,"pageSize":pageSize,"mercId":LBKeychain.get(CURRENT_MERC_ID)]),
                                 headers: nil,
                                 success: {[weak self] (json) in
                                    guard let strongSelf = self else{return}
                                    
                                    success(LBNewsModel<imageListModel>(json:json["detail"]))
                                    
                                    LBLoadingView.loading.dissmiss()
                                    strongSelf.tableView.stopPullRefreshEver()
                                    strongSelf.tableView.stopPushRefreshEver()
                                    
            }, failure: { [weak self](failItem) in
                guard let strongSelf  = self else{return}
                strongSelf.tableView.stopPullRefreshEver()
                strongSelf.tableView.stopPushRefreshEver()
                LBLoadingView.loading.dissmiss()
                
            }, requestError: {[weak self] (error) in
                guard let strongSelf  = self else{return}
                strongSelf.tableView.stopPullRefreshEver()
                strongSelf.tableView.stopPushRefreshEver()
                LBLoadingView.loading.dissmiss()
                
        })
    }
    
    func praiseAction(mercId:String,id:Int,index:Int){
        let parameters:[String:Any] = ["mercId":mercId,"id":id]
        LBHttpService.LB_Request(.praiseHeadlineInfo,
                                 method: .get,
                                 parameters: parameters,
                                 success: { [weak self](json) in
                                    guard let strongSelf = self else{return}
                                    strongSelf.priseButtonSelectTypes[index] = true
                                    
            }, failure: {[weak self] (failItem) in
                guard let strongSelf = self else{return}
                strongSelf.showAlertView(failItem.message, "确定", nil)
                strongSelf.priseButtonSelectTypes[index] = false
                
        }) { [weak self](error) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)
            strongSelf.priseButtonSelectTypes[index] = false
            
        }
        
    }
    
    func getGameCoupon(success:@escaping ((LBGameModel)->()),fail:@escaping (()->())){
        
        SZLocationManager.shareUserInfonManager.startUpLocation()
        let lat:String = LBKeychain.get(latitudeKey)
        let lng:String = LBKeychain.get(longiduteKey)
        let mercId:String = LBKeychain.get(CURRENT_MERC_ID)
        let parameters:[String:Any] = ["mercId":mercId,"lat":lat,"lng":lng]
        LBHttpService.LB_Request(.getGameCoupon,
                                 method: .post,
                                 parameters: lb_md5Parameter(parameter: parameters),
                                 success: {(json) in
                                    success(LBGameModel(json: json["detail"]))
        }, failure: {  (failItem) in
            fail()
        }) { (error) in
            fail()
        }
    }
    
}

















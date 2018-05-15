//
//  ZJShopDetailViewModel.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift
enum ZJShopDetailModelType {
    case heade(model : ZJShopDetailInfoModel)
    case spcae(height : CGFloat,color : UIColor)
    case groupHead(title : String,subTitle :String,vc : String)
    case miaomiao(modesl:[ZJHomeMiaoMiaoModel])
    case good(model : ZJShopGoodsModel)
    case common(model : ZJReplayModel)
    case descrption(text : String)
}


class ZJShopDetailModel {
    var tyep : ZJShopDetailModelType = ZJShopDetailModelType.spcae(height: fit(20), color: .white) {
        didSet{
            switch tyep {
            case .heade:
                cellHeight = fit(807)
            case .spcae(let height,_):
                cellHeight = height
            case .groupHead:
                cellHeight = fit(80)
            case .miaomiao:
                cellHeight = fit(373)
            case .good:
                cellHeight = fit(225)
            case .common:
                cellHeight = fit(198)
            case .descrption(let text):
                let height = (text as NSString).boundingRect(with: CGSize(width: fit(713), height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : Font(26)], context: nil).height
                cellHeight = height + fit(83 + 51)
            }
        }
    }
    var cellHeight : CGFloat = 0
}

class ZJShopDetailViewModel: SNBaseViewModel {
    var models : [ZJShopDetailModel] = []
    var requestModel : ZJShopDetailRequestModel?{
        didSet{
            creatModels()
        }
    }
     let reloadPublish = PublishSubject<Void>()
    
    
    let naviAlpha = PublishSubject<CGFloat>()
    var shopId : String = ""
    func getData(id : String){
        shopId = id
        SNRequest(requestType: API.shopDetail(shopId: id), modelType: ZJShopDetailRequestModel.self).subscribe(onNext: { (res) in
            switch res{
            case .success(let model):
                self.requestModel = model
            case .fail:
                SZHUD("获取商家信息失败", type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    
    
    func creatModels(){
        
        models.removeAll()
        let headModel = ZJShopDetailModel(); headModel.tyep = .heade(model: requestModel!.info)
        models.append(headModel)
        let spaceModel = ZJShopDetailModel();spaceModel.tyep = .spcae(height: fit(20), color: Color(0xf5f5f5))
        models.append(spaceModel)
        if requestModel!.kills.count != 0{
            
            let miaomiaoHeader = ZJShopDetailModel();miaomiaoHeader.tyep = .groupHead(title: "秒秒商品", subTitle: "更多", vc: "ZJMiaoMiaoListVC")
            models.append(miaomiaoHeader)
            let miaomiao = ZJShopDetailModel();miaomiao.tyep = .miaomiao(modesl: requestModel!.kills)
            models.append(miaomiao)
            models.append(spaceModel)
        }
        if requestModel!.goods.count != 0{
            
            let goodHeader = ZJShopDetailModel();goodHeader.tyep = .groupHead(title: "人气商品", subTitle: "全部", vc: "ZJGoodListViewController")
            models.append(goodHeader)
            requestModel!.goods.forEach { (model) in
                let goodModel = ZJShopDetailModel()
                goodModel.tyep = .good(model: model)
                models.append(goodModel)
            }
            models.append(spaceModel)
        }
        let replayHeader = ZJShopDetailModel();replayHeader.tyep = .groupHead(title: "全部评价(\(requestModel!.info.evaluateCount))", subTitle: "全部", vc: "ZJCommonListVC")
        models.append(replayHeader)
        if requestModel!.reply.count != 0{
            requestModel!.reply.forEach { (model) in
                let replayModel = ZJShopDetailModel()
                replayModel.tyep = .common(model: model)
                models.append(replayModel)
            }
            models.append(spaceModel)
        }
        
        let descriptionModel = ZJShopDetailModel()
        descriptionModel.tyep = .descrption(text: requestModel!.info.shop_introduce)
        models.append(descriptionModel)
        models.append(spaceModel)
        
        reloadPublish.onNext(())
    }
    
    func cellFunction(type : ZJShopDetailFuntionType){
        switch type {
        case .naiv(let lat,let lng):
          break
        case .tele(let phone):
            break
        
        }
    }
 
}
extension  ZJShopDetailViewModel : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch models[indexPath.row].tyep {
        case .heade(let model):
            let cell : ZJShopDetailHeaderCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = model
            cell.funcPub.subscribe(onNext: { (type) in
                self.cellFunction(type: type)
            }).disposed(by: cell.disposeBag)
            return cell
        case .miaomiao(let models):
            let cell : ZJShopDetailKillCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.models = models
            cell.didSelected.subscribe(onNext: { (model) in
                let vc = LBShopDetailsController()
                vc.miaomiaoModel = model
                self.jumpSubject.onNext(SNJumpType.push(vc: vc, anmi: true))
            }).disposed(by: cell.disposeBag)
            return cell
        case .groupHead(let title,let subTitle,let vc):
            let cell : ZJShopDetailGroupTitleCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.set(title: title, subTitle: subTitle, vc: vc)
            cell.clickMoreBtn.subscribe(onNext: { (vcName) in
                self.pushToVC(vcString: vcName)
            }).disposed(by: disposeBag)
            return cell
        case .common(let model):
            let cell : ZJShopDetailCommonCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = model
            return cell
        case .descrption(let text):
            let cell : ZJShopDetailDecriptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.descriptionText = text
            return cell
        case .spcae(_,let color):
            let cell : ZJSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.contentView.backgroundColor = color
            return cell
        case .good(let model):
            let cell : ZJShopDetailGoodsCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = model
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return models[indexPath.row].cellHeight
    }
    func pushToVC(vcString : String){
        let name = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
        guard let cls : AnyClass = NSClassFromString(name + "." + vcString) else {
            ZJLog(messagr: "\(name).\(vcString)类不存在")
            return
        }
//        let controller = (cls as! UIViewController.Type).init()
        
        switch vcString {
        case "ZJGoodListViewController":
            let controller = (cls as! ZJGoodListViewController.Type).init()
            controller.shopId = self.shopId
            jumpSubject.onNext(SNJumpType.push(vc: controller, anmi: true))
        case "ZJMiaoMiaoListVC":
            let controller = (cls as! ZJMiaoMiaoListVC.Type).init()
            controller.shopId = self.shopId
            jumpSubject.onNext(SNJumpType.push(vc: controller, anmi: true))
        case "ZJCommonListVC":
            let controller = (cls as! ZJCommonListVC.Type).init()
            controller.shopId = self.shopId
            jumpSubject.onNext(SNJumpType.push(vc: controller, anmi: true))
        default:
            break
        }
//        jumpSubject.onNext(SNJumpType.push(vc: controller, anmi: true))
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffSet = scrollView.contentOffset.y
        
        let alpha = contentOffSet / fit(503)

        self.naviAlpha.onNext(alpha)
    }
    
}






class ZJShopDetailRequestModel : SNSwiftyJSONAble{
    var info : ZJShopDetailInfoModel
    var goods : [ZJShopGoodsModel]
    var kills : [ZJHomeMiaoMiaoModel]
    var reply : [ZJReplayModel]
    required init?(jsonData: JSON) {
        info = ZJShopDetailInfoModel.init(jsonData: jsonData["info"])!
        goods = jsonData["goods"].arrayValue.map({ (json) -> ZJShopGoodsModel in
            return ZJShopGoodsModel.init(jsonData: json)!
        })
        kills = jsonData["kills"].arrayValue.map({ (json) -> ZJHomeMiaoMiaoModel in
            return ZJHomeMiaoMiaoModel.init(jsonData: json)!
        })
        reply = jsonData["reply"].arrayValue.map({ (json) -> ZJReplayModel in
            return ZJReplayModel.init(jsonData: json)!
        })
    }
}

class ZJReplayModel : SNSwiftyJSONAble{

    
   
    var id : String
    var user_id : String
    var description : String
    var images : [String]
    var grade : String
    var add_time : String
    var nickName : String
    var headImg : String
    required init?(jsonData: JSON) {
        id = jsonData["id"].stringValue
        user_id = jsonData["user_id"].stringValue
        description = jsonData["description"].stringValue
        images = []
        grade = jsonData["grade"].stringValue
        add_time = jsonData["add_time"].stringValue
        nickName = jsonData["nickName"].stringValue
        headImg = jsonData["headImg"].stringValue
        
        if add_time.utf16.count > 10{
            add_time = (add_time as NSString).substring(to: 10)
        }
        images = anayliseImgs(imgs: jsonData["images"].stringValue)
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
}


////
//class ZJKillModel : SNSwiftyJSONAble{
//
//    var latitude : String
//    var longitude : String
//    var merLabel : String
//    var shopName : String
//    var merAddress : String
//    var phone : String
//    var add_time : String
//    var shopId : String
//    var state : String
//    var description : String
//    var detailImg : String
//    var mainImg : String
//    var cardNum : String
//    var terminaltime : String
//    var endTime : String
//    var price : String
//    var id : String
//    var name : String
//    var distance  : String
//    required init?(jsonData: JSON) {
//        name = jsonData["name"].stringValue
//        id = jsonData["id"].stringValue
//        price = jsonData["price"].stringValue
//        latitude = jsonData["latitude"].stringValue
//        longitude = jsonData["longitude"].stringValue
//        merLabel = jsonData["merLabel"].stringValue
//        shopName = jsonData["shopName"].stringValue
//        merAddress = jsonData["merAddress"].stringValue
//        phone = jsonData["phone"].stringValue
//        add_time = jsonData["add_time"].stringValue
//        shopId = jsonData["shopId"].stringValue
//        state = jsonData["state"].stringValue
//        description = jsonData["description"].stringValue
//        detailImg = jsonData["detailImg"].stringValue
//        mainImg = jsonData["mainImg"].stringValue
//        cardNum = jsonData["cardNum"].stringValue
//        terminaltime = jsonData["terminaltime"].stringValue
//        endTime = jsonData["endTime"].stringValue
//
//        let currentLocation = CLLocation(latitude: (LBKeychain.get(latitudeKey) as NSString).doubleValue, longitude: (LBKeychain.get(longiduteKey) as NSString).doubleValue )
//        let targetLocation = CLLocation(latitude: (latitude as NSString).doubleValue, longitude:(longitude as NSString).doubleValue)
//        distance = String(format: "%.2f", currentLocation.distance(from: targetLocation) / 1000.0)
//    }
//}


class ZJShopGoodsModel : SNSwiftyJSONAble{

    var id :String
    var name : String
    var price : String
    var main_img: String
    var sell_num : String
    required init?(jsonData: JSON) {
        id = jsonData["id"].stringValue
        name = jsonData["name"].stringValue
        price = jsonData["price"].stringValue
        main_img = jsonData["main_img"].stringValue
        sell_num = jsonData["sell_num"].stringValue
    }
}

class ZJShopDetailInfoModel :SNSwiftyJSONAble{

    var banner : [String]
    var logo : String
    var shopName : String
    var tab : String
    var latitude : String
    var longitude : String
    var address : String
    var phone : String
    var shop_introduce : String
    var evaluateCount : String
    var distance  : String
    required init?(jsonData: JSON) {
        banner = []
        
        logo = jsonData["logo"].stringValue
        shopName = jsonData["shopName"].stringValue
        tab = jsonData["tab"].stringValue
        latitude = jsonData["latitude"].stringValue
        longitude = jsonData["longitude"].stringValue
        address = jsonData["address"].stringValue
        phone = jsonData["phone"].stringValue
        shop_introduce = jsonData["shop_introduce"].stringValue
        evaluateCount = jsonData["evaluateCount"].stringValue
        
        let currentLocation = CLLocation(latitude: (LBKeychain.get(latitudeKey) as NSString).doubleValue, longitude: (LBKeychain.get(longiduteKey) as NSString).doubleValue )
        let targetLocation = CLLocation(latitude: (latitude as NSString).doubleValue, longitude:(longitude as NSString).doubleValue)
        distance = String(format: "%.2f", currentLocation.distance(from: targetLocation) / 1000.0)
        banner = self.anayliseImgs(imgs: jsonData["banner"].stringValue)
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
}

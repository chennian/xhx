//
//  ZJHeadTopicDetailViewModel.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 18/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
enum ZJHeadTopicDetailCellModelType {
    case deatail(model : ZJHeadTopicCellModel)
    case share
    case like(model : ZJHeadTopicDetailPraiseModel)//
    case common(model : ZJHeadTopicDetailReplayModel)
    case spcae(height : CGFloat,color : UIColor)
}

//class ZJHeadTopicCommonModel  {//SNSwiftyJSONAble
//    var headIcon : String
//    var name : String
//    var content : String
//
//    required init?(jsonData: JSON) {
//        headIcon = jsonData["headIcon"].stringValue
//        name = jsonData["name"].stringValue
//        content = jsonData["content"].stringValue
//    }
//}

class ZJHeadTopicDetailCellModel {
    
    
    var type : ZJHeadTopicDetailCellModelType = .spcae(height : 0.0,color : .white){
        
        didSet{
            switch type {
            case .deatail(let model):
                cellHight = model.height - fit(90)
            case .spcae(let height, _):
                cellHight = height
            case .common:
                cellHight = fit(165)
            case .share,.like:
                cellHight = fit(117)

            }
        }
    }
    var cellHight : CGFloat = 0.0
    
}
class ZJHeadTopicDetailViewModel: SNBaseViewModel {
    
    var id : String = ""
    
    let reloadPublish = PublishSubject<(section : [Int],count : Int)>()

    var topicModel : ZJHeadTopicCellModel?{
        didSet{
            
            let spaceModel = ZJHeadTopicDetailCellModel()
            spaceModel.type = ZJHeadTopicDetailCellModelType.spcae(height: fit(20), color: Color(0xf5f5f5))
            let mainModel = ZJHeadTopicDetailCellModel()
            mainModel.type = ZJHeadTopicDetailCellModelType.deatail(model: topicModel!)
//            models[0] =
            
            models[0] = [mainModel,spaceModel]
   
            self.reloadPublish.onNext(([0,1],1))
//            getData()
        }
    }
    var model : ZJHeadTopicDetailInfoModel?
    
    //展示类型
    var type :  ZJHeadTopicToolBarButtonType = .common{
        didSet{
            if model == nil{
                return
            }
            switch type {
            case .common:
                models[1] = model!.headlineReplyPOList.map({ (model) -> ZJHeadTopicDetailCellModel in
                    let mod = ZJHeadTopicDetailCellModel()
                    mod.type = .common(model: model)
                    return mod
                })
            case .like:
                ZJLog(messagr: model!.headlineInfoPraiseBOList.count)
                models[1] = model!.headlineInfoPraiseBOList.map({ (model) -> ZJHeadTopicDetailCellModel in
                    let mod = ZJHeadTopicDetailCellModel()
                    mod.type = .like(model: model)
                    return mod
                })
            default:
                models[1] = []
            }
            reloadPublish.onNext(([1],models[1].count))
        }
    }
    
//    var commonModels : [ZJHeadTopicDetailReplayModel] = []
    func getData(id : String,type : ZJHeadTopicToolBarButtonType = .common) {
        
        self.id = id
//
        
        
        SNRequest(requestType: API.headTopicInfo(id: id, checkPraiseId: LBKeychain.get(CURRENT_MERC_ID)), modelType: ZJHeadTopicDetailInfoModel.self).subscribe(onNext: { (result) in
            switch result{
            case .success(let model):
                self.model = model
                
                self.topicModel = model.headLineInfo
                self.type = type
            case .fail(_,let msg):
                SZHUD(msg ?? "获取头条详情失败", type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
        
//        SNRequest(requestType: API.getReplatyList(id: topicModel!.id, size: 10, page: 0), modelType: [ZJHeadTopicDetailReplayModel.self]).subscribe(onNext: { (result) in
//            switch result{
//            case .success(let models):
//                self.models[1] = models.map({ (mod) -> ZJHeadTopicDetailCellModel in
//                    let model = ZJHeadTopicDetailCellModel()
//                    model.type = .common(model : mod)
//                    return model
//                    })
//                self.reloadPublish.onNext((section: [1], count: models.count))
//            default:
//                break
//            }
//        }).disposed(by: disposeBag)
    }
    func setLike(id : String,btn : UIButton){
        
        ZJLog(messagr: id)
        ZJLog(messagr: LBKeychain.get(CURRENT_MERC_ID))
        SNRequestBool(requestType: API.setLike(mercId: LBKeychain.get(CURRENT_MERC_ID), headlineId: id, state: btn.isSelected ? "1" : "0")).subscribe(onNext: {[unowned self] (reseult) in
            switch reseult{
            case .bool(_):
//                break\
                self.getData(id: self.id,type : .like)
//                if btn.isSelected{
//
//                    let count = (self.topicModel!.real_praise as NSString).integerValue + 1
//                    self.topicModel?.real_praise = "\(count)"
//                }else{
//                    let count = (self.topicModel!.real_praise as NSString).integerValue - 1
//                    self.topicModel?.real_praise = "\(count)"
////                    self.model?.headlineInfoPraiseBOList
//                }
////                self.type = .common
//                self.reloadPublish.onNext((section: [0,1], count: 0))
//                btn.setTitle(String(format: "%2d", (btn.currentTitle! as NSString).intValue + 1), for: .normal)
            case .fail(let code , let msg):
                btn.isSelected = !btn.isSelected
                ZJLog(messagr: code)
                SZHUD(msg ?? "请求失败", type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
        
    }
    
    func replay(content : String){
        
//        let s = NSString.addingPercentEncoding(<#T##NSString#>)//stringByAddingPercentEncodingWithAllowedCharac//NSString.stringContainsEmoji(content)
        
//        let vc = (content as NSString).addingPercentEncoding(withAllowedCharacters:  NSCharacterSet.urlQueryAllowed)//.stringByAddingPercentEscapesUsingEncodin
//        let ste = content.utf8CString
//        let ste = NSString(utf8String: content.utf8CString)
//        NSString.stringContainsEmoji(content)
        SNRequestBool(requestType: API.replayHeadTopic(headline_id: topicModel!.id, mer_id: topicModel!.merc_id, comments: content, reply_id: "")).subscribe(onNext: { (result) in
            switch result{
            case .bool(_):
//            c    break

//                let commonCount = (self.topicModel!.replyNum as NSString).intValue + 1
//                self.topicModel!.replyNum = "\(commonCount)"
//                self.reloadPublish.onNext((section: [0,1], count: 0))
                let model = ZJHeadTopicDetailReplayModel()
                model.comments = content
                self.model!.headlineReplyPOList.append(model)
                self.type = .common
                self.reloadPublish.onNext((section: [0,1], count: 0))
//                self.getData(id: <#T##String#>)
                SZHUD("评论成功", type: .info, callBack: nil)
                
            default:
                SZHUD("请求错误", type: .error, callBack: nil)
//                ZJLog(messagr: "回复失败")
            }
        }).disposed(by: disposeBag)
    }
    
    
    var models : [[ZJHeadTopicDetailCellModel]] = [[],[]]
}


extension ZJHeadTopicDetailViewModel : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch models[indexPath.section][indexPath.row].type{
        case .spcae(_,let color):
            let cell : ZJSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.backgroundColor = color
            return cell
        case .deatail(let model):
            let cell : ZJHeadTopicMainContentCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = model
            cell.clickPub.subscribe(onNext: { (index,imgs) in
                let preview = ZJSinglePhotoPreviewVC()
                
                preview.selectImages = imgs
                //            preview.sourceDelegate = self
                preview.currentPage = index
                //
                self.jumpSubject.onNext(SNJumpType.show(vc: preview, anmi: true))
            }).disposed(by: cell.disposeBag)
            return cell
//            return cell
        case .common(let model):
            let cell : ZJHeadTopicCommonCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = model//model!.headlineReplyPOList[indexPath.row]
            return cell
        case .like(let model):
            let cell : ZJHeadTopicShareCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = model//model!.headlineInfoPraiseBOList[indexPath.row]
            return cell
        default :
            let cell  = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0{ return 1}
        return models[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            return UIView()
        }
        let header = ZJHeadTopicToolHeader()
        if model != nil{
            header.setContent(share: "0", commom: "\(model!.headlineReplyPOList.count)", like: "\(model!.headlineInfoPraiseBOList.count)")
            header.showType = self.type
        }
        header.btnClick.subscribe(onNext: {[unowned self] (type) in
//            switch type{
//                case .common
//            }
            self.type = type
        }).disposed(by: disposeBag)
        return header//models[section].count
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0.0001
        }
        return fit(88)//models[section].count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return models[indexPath.section][indexPath.row].cellHight
    }
}

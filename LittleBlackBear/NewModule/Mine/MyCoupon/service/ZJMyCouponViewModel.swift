//
//  ZJMyCouponViewModel.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 26/4/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

import SwiftyJSON
class ZJMyCouponViewModel: SNBaseViewModel {

    let reloadPublish = PublishSubject<(ZJMyCouponType ,Int)>()
    
//    var models : [ZJCouponCellModel] = []
    func getData(){
//        let model0 = ZJCouponCellModel()
//        model0.va = true
//        let model1 = ZJCouponCellModel()
//        model1.va = false
//        models = [model0,model0,model1,model1,model1]
    }
    var currentTableType : ZJMyCouponType = .unused
    var models : [[ZJCouponCellModel]] =  [[],[],[]]
    func tryToGetInfo(type : ZJMyCouponType,force : Bool = false){
        currentTableType = type
        

    /*
         */
//        SNRequest(requestType: API.getConpounList(type: String(format: "%d", type.rawValue)), modelType: [ZJCouponCellModel.self]).subscribe(onNext: { (resutl) in
//            switch resutl{
//            case .success(let modesl):
//                switch type{
//                case .used:
//
//                    self.models[1] = modesl
//                case .dayOff:
//                    self.models[2] = modesl
//                case .unused:
//                    self.models[0] = modesl
//                }
//            case .fail(_,let msg):
//                SZHUD(msg ?? "请求失败", type: .error, callBack: nil)
//            default:
//                break
//            }
//        }).disposed(by: disposeBag)
        
        /*
         Alamofire.request("http://transaction.xiaoheixiong.net/user/updateHeadImg", method: .post, parameters: ["headUrl" : url], headers: ["X-AUTH-TOKEN":LBKeychain.get(TOKEN),"X-AUTH-TIMESTAMP":LBKeychain.get(LLTimeStamp)]).responseJSON { (res) in
         
         }
         */
        
        let para =  ["status" : String(format: "%d", type.rawValue)]
//
//        ZJLog(messagr: para)
        let requese = Alamofire.request("http://transaction.xiaoheixiong.net/merchant/getcouponList", method: .post, parameters:para, headers: ["X-AUTH-TOKEN":LBKeychain.get(TOKEN),"X-AUTH-TIMESTAMP":LBKeychain.get(LLTimeStamp)])
        
        requese.responseJSON { (res) in
            guard let jsonData = try? JSON(data: res.data!) else{
                return
            }
//            jso
//            ZJLog(messagr: json)
            let jsonCode = jsonData[MOYA_RESULT_CODE]
            let jsonObj = jsonData[MOYA_RESULT_DATA]
//            let jsonMsg = jsonData[MOYA_RESULT_MSG]
//            ZJLog(messagr: jsonData)
            let mappedArray = jsonObj
            
            //错误处理
            guard jsonCode.stringValue != "" && ["000000"].contains(jsonCode.stringValue) else {//jsonCode.int == 000000
                SZHUD("获取数据失败", type: .error, callBack: nil)
                return
            }
            
            let mappedObjectsArray = mappedArray.arrayValue.map({return ZJCouponCellModel(jsonData: $0)!}).filter({ (model) -> Bool in
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                guard let date = formatter.date(from: model.terminaltime) else{
                    return false
                }
                switch type{
                case .dayOff:
                    return date < Date()
                case .unused:
                    return date > Date()
                case .used:
                    return true
                }
                
            })//.flatMap { ZJCouponCellModel(jsonData: $0) }
            
//            ZJLog(messagr: mappedArray)
            switch type{
            case .used:
                
                self.models[1] = mappedObjectsArray
            case .dayOff:
                self.models[2] = mappedObjectsArray
            case .unused:
                self.models[0] = mappedObjectsArray
            }
            
            self.reloadPublish.onNext((type, mappedObjectsArray.count))

        }
    
    }
    
    /*
     let jsonData = try JSON(data: res.data)
     //        let mappedArray = JSON(jsonObject)
     SNLog(jsonData)
     let jsonCode = jsonData[MOYA_RESULT_CODE]
     let jsonObj = jsonData[MOYA_RESULT_DATA]
     let jsonMsg = jsonData[MOYA_RESULT_MSG]
     
     let mappedArray = jsonObj
     */
}


extension ZJMyCouponViewModel : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ZJCouponCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
//        cell.model = models[(tableView as! ZJMyCouponTableview).type.rawValue][indexPath.row]
        switch currentTableType    {
        case .used:
            cell.model =  models[1][indexPath.row]
        case .unused:
            cell.model =  models[0][indexPath.row]
        case .dayOff:
            cell.model =  models[2][indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return models[(tableView as! ZJMyCouponTableview).type.rawValue].count
        
        
        switch currentTableType    {
        case .used:
            return models[1].count
        case .unused:
            return models[0].count
        case .dayOff:
            return models[2].count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(262)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.section][indexPath.row]
        let vc = ZJCouponDetailVC()
        vc.model = model
        jumpSubject.onNext(SNJumpType.push(vc: vc, anmi: true))
    }
}

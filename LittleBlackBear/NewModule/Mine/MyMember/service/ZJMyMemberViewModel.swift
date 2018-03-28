//
//  ZJMyMemberViewModel.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 29/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift

class ZJMyMemberJsonModel : SNSwiftyJSONAble{
    var weichat : [ZJMyMemberModel]
    var alipay : [ZJMyMemberModel]
    var unionpay : [ZJMyMemberModel]
    var all : [ZJMyMemberModel] = []
    required init?(jsonData: JSON) {
        weichat = jsonData["weichat"].arrayValue.map({return ZJMyMemberModel.init(jsonData: $0)!})
        alipay = jsonData["alipay"].arrayValue.map({return ZJMyMemberModel.init(jsonData: $0)!})
        unionpay = jsonData["unionpay"].arrayValue.map({return ZJMyMemberModel.init(jsonData: $0)!})
        all.append(contentsOf: weichat)
        all.append(contentsOf: alipay)
        all.append(contentsOf: unionpay)
    }
}
class ZJMyMemberModel : SNSwiftyJSONAble {
    var userid : String
    var id : String
    var create_time : String
    var username : String
    var detail : String
    
    required init?(jsonData: JSON) {
        userid = jsonData["userid"].stringValue
        id = jsonData["id"].stringValue
        create_time = jsonData["create_time"].stringValue
        username = jsonData["username"].stringValue
        detail = jsonData["detail"].stringValue
    }
}
class ZJMyMemberViewModel: SNBaseViewModel {
    var models : [ZJMyMemberModel] = []
    var reloadDataPub = PublishSubject<Int>()
    func getData(){
        SNRequest(requestType: API.getMemberList(mer_id: LBKeychain.get(CURRENT_MERC_ID)), modelType: ZJMyMemberJsonModel.self).subscribe(onNext: { (result) in
            switch result{
            case .success(let models):
                self.models = models.all
                self.reloadDataPub.onNext(models.all.count)
            case .fail:
                SZHUD("获取收益失败", type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }

}
extension ZJMyMemberViewModel : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ZJMyMemberCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.model = models[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(195)
    }
}

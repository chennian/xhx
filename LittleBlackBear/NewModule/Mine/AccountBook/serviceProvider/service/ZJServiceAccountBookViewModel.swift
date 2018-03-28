//
//  ZJServiceAccountBookViewModel.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 29/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift
class ZJServiceAccountBookViewModel: SNBaseViewModel {

    var reloadDataPub = PublishSubject<(Int,String)>()
    var model : ZJServiceAccountJsonModel?{
        didSet{
            self.reloadDataPub.onNext((model!.list.count,model!.total))
        }
    }
    
    func getData(){
        SNRequest(requestType: API.serviceAccountBook(mer_id: LBKeychain.get(CURRENT_MERC_ID)), modelType: ZJServiceAccountJsonModel.self).subscribe(onNext: { (result) in
            switch result{
            case .success(let model):
                self.model = model
                
            case .fail:
                SZHUD("获取收益失败", type: .error, callBack: nil)
            default:
                return
            }
        }).disposed(by: disposeBag)
    }
}

extension ZJServiceAccountBookViewModel : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ZJMerchantAccountBookCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.model = model!.list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model == nil ? 0 : model!.list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(154)
    }
}

class ZJServiceAccountJsonModel : SNSwiftyJSONAble{
    var total : String
    var list : [ZJMerchantAccoutBookModel]
    required init?(jsonData: JSON) {
        total = jsonData["total"].stringValue
        list = jsonData["list"].arrayValue.map({return ZJMerchantAccoutBookModel(jsonData: $0)!})
    }
}
//class ZJServiceAccountCellModel : SNSwiftyJSONAble{
//    var pass_pay : String
//    var merchant_money : String
//    var pay_id : String
//    var add_time : String
//    var payTotal : String
//    var name : String
//
//    required init?(jsonData: JSON) {
//        pass_pay = jsonData["pass_pay"].stringValue
//        merchant_money = jsonData["merchant_money"].stringValue
//        pay_id = jsonData["pay_id"].stringValue
//        add_time = jsonData["add_time"].stringValue
//        payTotal = jsonData["payTotal"].stringValue
//        name = jsonData["name"].stringValue
//    }
//
//}


//
//  ZJMerchantAccoutBookViewModel.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 28/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class ZJMerchantAccoutBookViewModel: SNBaseViewModel {
    
    var model : ZJMerchantAccoutBookJsonModel?
    var reloadData = PublishSubject<(count : Int, huokuan : String, daoliu : String)>()
    
    

    func getData(type : String){
//        SNRequest(requestType: <#T##API#>, modelType: <#T##SNSwiftyJSONAble.Protocol#>)//LBKeychain.get(CURRENT_MERC_ID)
        SNRequest(requestType: API.merchantAccountBook(mer_id: LBKeychain.get(CURRENT_MERC_ID), type: type),modelType: ZJMerchantAccoutBookJsonModel.self).subscribe(onNext: { (result) in
            switch result{
            case .success(let model):
                self.model = model
                self.reloadData.onNext((count: model.list.count, huokuan: model.merchantTotal, daoliu: model.flowmeterTotal))
            case .fail(_,let _):
                SZHUD("获取收益失败", type: .error, callBack: nil)
            default :
                break
            }
        }).disposed(by: disposeBag)
    }

}


extension ZJMerchantAccoutBookViewModel : UITableViewDelegate,UITableViewDataSource{
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

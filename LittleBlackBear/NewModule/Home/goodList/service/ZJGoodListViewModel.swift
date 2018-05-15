//
//  ZJGoodListViewModel.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 11/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift
class ZJShopGoodListRequestModel  :SNSwiftyJSONAble{
    var cate : String
    var goods : [ZJShopGoodsModel]
    required init?(jsonData: JSON) {
        cate = jsonData["cate"].stringValue
        goods = jsonData["goods"].arrayValue.map({ (json) -> ZJShopGoodsModel in
            return ZJShopGoodsModel.init(jsonData: json)!
        })
    }
}



class ZJGoodListViewModel: SNBaseViewModel {
    
    let reloadPub = PublishSubject<[String]>()
    
    func requestData(shopId : String){
        SNRequest(requestType: API.goodsList(shopId: shopId), modelType: [ZJShopGoodListRequestModel.self]).subscribe(onNext: { (res) in
            switch res{
            case .success(let models):
                self.mapModel(modes: models)
            case .fail:
                SZHUD("获取商品列表失败", type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    
    var cateModel : [String] = []
    var goodModel : [[ZJShopGoodsModel]] = []
    func mapModel(modes : [ZJShopGoodListRequestModel]){
        cateModel.removeAll()
        goodModel.removeAll()
        modes.forEach { (model) in
            cateModel.append(model.cate)
            goodModel.append(model.goods)
        }
        self.reloadPub.onNext(cateModel)
        
        
    }

}

extension ZJGoodListViewModel : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ZJShopDetailGoodsCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.model = goodModel[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goodModel[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return cateModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(203)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return fit(73)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headr = ZJGoodListSectionHeader()
        headr.title.text = cateModel[section]
        return headr
    }
}

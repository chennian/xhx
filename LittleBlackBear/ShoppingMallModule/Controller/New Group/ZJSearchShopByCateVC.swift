//
//  ZJSearchShopByCateVC.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 15/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJSearchShopByCateVC: SNBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    var cate : String = ""{
        didSet{
            requestDtat()
        }
    }
    
    let tableview = SNBaseTableView().then({
        $0.register(ZJHomeMerchantCell.self)
    })
    
    
    var models : [ZJperfectShopModel] = []
    func requestDtat(){
        SNRequest(requestType: API.getShopByCate(name: cate), modelType: [ZJperfectShopModel.self]).subscribe(onNext: { (res) in
            switch res{
            case .success(let models):
                self.models = models
                self.tableview.zj_reloadData(count: models.count)
            case .fail:
                SZHUD("查询失败", type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    
    override func setupView() {
        title = cate
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
    }

}

extension ZJSearchShopByCateVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ZJHomeMerchantCell = tableview.dequeueReusableCell(forIndexPath: indexPath)
        cell.model = models[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(495)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        let vc = ZJShopDetailVC()
        vc.shopid = model.shop_id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

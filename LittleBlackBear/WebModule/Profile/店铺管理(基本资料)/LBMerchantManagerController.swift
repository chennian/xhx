//
//  LBMerchantManagerController.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/4/3.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBMerchantManagerController: UIViewController {
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(LBMerchantTextFileCell.self)
        $0.register(LBMerchantMainImgCellTableViewCell.self)
        $0.register(LBMerchantDetailImgCell.self)
        $0.register(LBMerchantAddressCell.self)
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        
        self.title = "店铺管理"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LBMerchantManagerController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:LBMerchantTextFileCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 1{
            let cell:LBMerchantMainImgCellTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else if indexPath.row == 2{
            let cell:LBMerchantDetailImgCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else{
            let cell:LBMerchantAddressCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        if indexPath.row == 0 {
            return fit(950)
        }else if indexPath.row == 1{
            return fit(300)
        }else if indexPath.row == 2{
            return fit(300)
        }else{
            return fit(90)
        }
    }
}

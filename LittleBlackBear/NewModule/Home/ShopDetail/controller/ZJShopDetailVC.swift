//
//  ZJShopDetailVC.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJShopDetailVC: SNBaseViewController {

    

    var shopid : String = ""
    
    let tableview = SNBaseTableView().then({
        $0.register(ZJShopDetailHeaderCell.self)
        $0.register(ZJShopDetailGroupTitleCell.self)
        $0.register(ZJShopDetailGoodsCell.self)
        $0.register(ZJShopDetailCommonCell.self)
        $0.register(ZJShopDetailDecriptionCell.self)
        $0.register(ZJShopDetailKillCell.self)
        $0.register(ZJSpaceCell.self)
    
    })
    
    let viewmodel = ZJShopDetailViewModel()
    
    var alpha : CGFloat = 0.0
    override func setupView() {
        view.addSubview(tableview)
        tableview.delegate = viewmodel
        tableview.dataSource = viewmodel
        tableview.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(-LL_StatusBarAndNavigationBarHeight)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(createImageBy(color: UIColor.init(white: 1.0, alpha: alpha)), for: .default)
        viewmodel.getData(id: "1")
        
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(createImageBy(color: .white), for: .default)
        navigationController?.navigationBar.isTranslucent = false
    }
    override func bindEvent() {
        viewmodel.reloadPublish.subscribe(onNext: { () in
            self.tableview.reloadData()
        }).disposed(by: disposeBag)
        viewmodel.naviAlpha.subscribe(onNext: { (alpha) in
            self.navigationController?.navigationBar.setBackgroundImage(createImageBy(color: UIColor.init(white: 1.0, alpha: alpha)), for: .default)
//            if
            self.alpha = alpha
//            self.navigationController?.navigationBar.isTranslucent = alpha < 1.0
        }).disposed(by: disposeBag)
        
        viewmodel.jumpSubject.subscribe(onNext: { (type) in
            switch type{
            case.push(let vc,let anmi):
                self.navigationController?.pushViewController(vc, animated: anmi)
                
            default:
                break
            }
        }).disposed(by: disposeBag)
        
        
        
    }
    
    
}

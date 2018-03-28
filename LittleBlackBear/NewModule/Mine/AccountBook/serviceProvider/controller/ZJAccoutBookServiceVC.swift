//
//  ZJAccoutBookServiceVC.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 29/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJAccoutBookServiceVC: SNBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    let backButton = UIButton().then({
        $0.setTitle("返回", for: .normal)
        $0.titleLabel?.font = Font(30)
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.setImage(UIImage(named:"map_return1"), for: .normal)
        $0.setTextImageInsert(margin: fit(10))
    })
    let header = ZJServiceAccountHeaderView()
    
    let viewmodel = ZJServiceAccountBookViewModel()
    let tableview = SNBaseTableView().then({
        $0.register(ZJMerchantAccountBookCell.self)
    })

    override func setupView() {
        title = "收益"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        tableview.delegate = viewmodel
        tableview.dataSource = viewmodel
        viewmodel.getData()
        view.addSubview(header)
        view.addSubview(tableview)
        header.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.snEqualTo(220)
            
        }
        tableview.snp.makeConstraints { (make) in
            make.top.snEqualTo(header.snp.bottom).snOffset(20)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    override func bindEvent() {
        viewmodel.reloadDataPub.subscribe(onNext: { (count,total) in
            self.header.count.text = total == "" ? "0.00" : total
            self.tableview.zj_reloadData(count: count)
        }).disposed(by: disposeBag)
        backButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }

}

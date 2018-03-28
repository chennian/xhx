//
//  ZJMyMemberVC.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 29/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJMyMemberVC: SNBaseViewController {

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
    let viewmodel = ZJMyMemberViewModel()
    let tableview = SNBaseTableView().then({
        $0.register(ZJMyMemberCell.self)
    })
    
    override func setupView() {
        title = "我的会员"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        tableview.delegate = viewmodel
        tableview.dataSource = viewmodel
        viewmodel.getData()
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    override func bindEvent() {
        viewmodel.reloadDataPub.subscribe(onNext: { (count) in
            self.tableview.zj_reloadData(count: count)
        }).disposed(by: disposeBag)
        backButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    


}

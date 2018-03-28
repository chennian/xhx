//
//  ZJMerchantAccountBookVC.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 28/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJMerchantAccountBookVC: SNBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let viewModel = ZJMerchantAccoutBookViewModel()

    let headeView = ZJMerchantAccountBookHeadView()
    
    let tableview = SNBaseTableView().then({
        $0.register(ZJMerchantAccountBookCell.self)
    })
    let backButton = UIButton().then({
        $0.setTitle("返回", for: .normal)
        $0.titleLabel?.font = Font(30)
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.setImage(UIImage(named:"map_return1"), for: .normal)
        $0.setTextImageInsert(margin: fit(10))
    })
    override func setupView() {
        title = "收益"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        view.backgroundColor = Color(0xf5f5f5)
        tableview.delegate = viewModel
        tableview.dataSource = viewModel
        viewModel.getData(type: "1")
        view.addSubview(headeView)
        view.addSubview(tableview)
        
        headeView.snp.makeConstraints { (make) in
            make.width.snEqualToSuperview()
            make.left.snEqualToSuperview()
            make.top.snEqualTo(17)
            make.height.snEqualTo(152)
        }
        tableview.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.top.snEqualTo(headeView.snp.bottom).snOffset(18)
            make.bottom.equalToSuperview()
        }
    }
  

    override func bindEvent() {
        viewModel.reloadData.subscribe(onNext: {[unowned self] (count ,huokuan ,daoliu) in
            self.headeView.setContnt(text1: huokuan, text2: daoliu)
            self.tableview.zj_reloadData(count: count)
        }).disposed(by: disposeBag)
        headeView.searchType.subscribe(onNext: { (type) in
            self.viewModel.getData(type: type)
        }).disposed(by: disposeBag)
        backButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
}

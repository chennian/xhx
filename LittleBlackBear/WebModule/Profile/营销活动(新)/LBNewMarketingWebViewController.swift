//
//  LBNewMarketingWebViewController.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/17.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBNewMarketingWebViewController: UIViewController {
    
    fileprivate let tableView:UITableView = UITableView().then{
//        $0.backgroundColor = color_bg_gray_f5
        $0.backgroundColor = UIColor.green
//        $0.register(LBNewMarketHead.self)
        $0.register(LBNewMarketCellTableViewCell.self)
//        $0.register(ZJSpaceCell.self)
        $0.separatorStyle = .none
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        loadData()
        setupUI()
    }

    func setupUI() {
        
        self.title = "营销活动"
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
    func  loadData(){
        let paramert:[String:String] = ["":"","":""]
        LBHttpService.LB_Request(.activity, method: .post, parameters: lb_md5Parameter(parameter: paramert), headers: nil, success: {[weak self] (json) in

            print(json)
            }, failure: { (failItem) in
        }) { (error) in
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        loadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}

extension LBNewMarketingWebViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LBNewMarketCellTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //判断类型 heard 100  内容500
        return fit(500)
    }
    
}

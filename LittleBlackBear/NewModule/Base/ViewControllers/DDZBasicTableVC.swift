//
//  DDZBasicTableVC.swift
//  geoTest
//
//  Created by zhijian chen on 2017/4/7.
//  Copyright © 2017年 zhijian chen. All rights reserved.
//

import UIKit

class DDZBasicTableVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        background.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        tableView.separatorStyle = .none
        tableView.bounces = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    lazy var background : DDZNodataView = {
        let obj = DDZNodataView.view()
        obj.isHidden = true
        return obj
    }()


    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    

}

class DDZNodataView : UIView{
    class func view()->DDZNodataView{
        let view = DDZNodataView()
        view.setUp()
        view.setUI()
        return view
    
    }
    
    func setNewOffset(height : CGFloat){
        imgView.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(height)
            make.centerX.equalToSuperview()
        }
        tip_Lab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imgView.snp.bottom).offset(fit(30))
        }
    }
    
    private func setUp(){
        backgroundColor = UIColor.white
    }
    private func setUI(){
        addSubview(imgView)
        addSubview(tip_Lab)
        imgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(fit(230))
            make.centerX.equalToSuperview()
        }
        tip_Lab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imgView.snp.bottom).offset(fit(30))
        }
    }
    private lazy var imgView : UIImageView = {
        let obj = UIImageView(image: UIImage(named: "blank"))
        return obj
    }()
    
    private lazy var tip_Lab : UILabel = {
        let obj = UILabel()
        obj.text = "暂无数据 休息一下"
        obj.textColor = Color(0x878787)
        obj.font = UIFont.systemFont(ofSize: fit(30))
        return obj
    }()
}

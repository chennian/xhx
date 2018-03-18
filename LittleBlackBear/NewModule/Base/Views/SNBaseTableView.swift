//
//  ZPHBaseTableView.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/17.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
//import DZNEmptyDataSet

class SNBaseTableView: UITableView {
    
    func zj_reloadData(count : Int){
        self.reloadData()
        noData(show: count == 0)
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        SNLog("table create with style")
        
        defautlConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 空数据图
    fileprivate var noDataView = SNBaseNoDataView()
    
    var noDataViewImageName = "" 
    var noDataViewDesc = ""
    
    fileprivate var showNoDataView = false {
        didSet {
            if showNoDataView {
                self.bringSubview(toFront: noDataView)
                noDataView.isHidden = false
            } else {
                self.insertSubview(noDataView, at: 0)
                noDataView.isHidden = true
            }
        }
    }
}


extension SNBaseTableView {
    
    func defautlConfig() {
        separatorStyle = .none
        estimatedRowHeight = 100
        //        bounces = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backgroundColor = color_bg_gray
        //        emptyDataSetSource = self
        //        emptyDataSetDelegate = self
        
        
        addSubview(noDataView)
        
        self.noDataViewImageName = "shopping_empty"
        self.noDataViewDesc = "暂无数据"
        
        
        noDataView.snp.makeConstraints { (make) in
            make.left.snEqualToSuperview()
            make.top.snEqualToSuperview()
            make.width.snEqualToSuperview()
            make.height.snEqualToSuperview()
        }
        
        showNoDataView = false
    }
    
    
    func noData(show: Bool) {
        
        noDataView.descL.text = noDataViewDesc
        noDataView.imgV.image = Image(noDataViewImageName)
        self.showNoDataView = show
    }
}



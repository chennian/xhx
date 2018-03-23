//
//  LBMercInfoImageTableViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/13.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit



class LBMercInfoImageTableViewCell:UITableViewCell{
    
	var imageUrls:[imgListModel] = []{
		didSet{
			guard imageUrls.count > 0 else{return}
			headerView.imageUrls = imageUrls
		}
	}
	var presentVC:UIViewController?{
		didSet{
			guard let vc = presentVC else { return  }
			headerView.presentVC = vc
		}
		
	}
	
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	private let headerView = LBShopDetailHeaderView()
    func setupUI() {
        contentView.addSubview(headerView)


    }


    
}



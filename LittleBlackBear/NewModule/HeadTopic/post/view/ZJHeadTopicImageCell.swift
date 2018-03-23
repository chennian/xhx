//
//  ZJHeadTopicImageCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 19/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJHeadTopicImageCell: UICollectionViewCell {
    
    let imgV = UIImageView().then{
        $0.contentMode = .scaleAspectFill
    }
//    let deleBtn = UIButton()
    
    let addIMg = UIImageView().then{
        $0.image = UIImage(named : "barter_add")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpVIew()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpVIew(){
//        contentView.layer.borderWidth = fit(2)
//        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.addSubview(addIMg)
        addIMg.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        contentView.addSubview(imgV)
        contentView.clipsToBounds = true
        imgV.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
    }
}

//
//  LBCityCollectionViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/6.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit


class LBCityCollectionViewCell: UICollectionViewCell {

    var titleLabel_text:String = ""{
        didSet{
            guard titleLabel_text.count > 0 else {return}
            titleLabel.text = titleLabel_text
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel = UILabel()
    
    func configContentView() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = FONT_28PX
        titleLabel.backgroundColor = UIColor.white
        titleLabel.layer.cornerRadius = 5
        titleLabel.layer.masksToBounds = true
        titleLabel.textAlignment = .center
        
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .top, .equal,contentView,.top))
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .left,.equal,contentView,.left,10))
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .bottom,.equal,contentView,.bottom))
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .right,.equal,contentView,.right,-10))

    }
}

//
//  LBMerchantIntroduceCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/13.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBMerchantIntroduceCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private let titleLabel  = UILabel()
   private let subTitle = UILabel()
   private let accessoryBtn = UIButton()
    
   private func setupUI(){
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitle)
        contentView.addSubview(accessoryBtn)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        accessoryBtn.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = FONT_30PX
        titleLabel.textColor = COLOR_222222
        
        subTitle.font = FONT_30PX
        subTitle.textColor = COLOR_999999
    
        accessoryBtn.backgroundColor = UIColor.white
        accessoryBtn.titleLabel?.font = FONT_28PX
        accessoryBtn.setTitleColor(COLOR_999999, for: .normal)
        accessoryBtn.setImage(UIImage(named:"blackrightAccessoryIcon"), for: .normal)
        accessoryBtn.setTitle("查看详情", for: .normal)
        
        let imgW = accessoryBtn.imageView?.image?.size.width
        let lbW  = accessoryBtn.titleLabel?.text?.getSize(15).width
        accessoryBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imgW!, 0, imgW!)
        accessoryBtn.imageEdgeInsets = UIEdgeInsetsMake(0, lbW!, 0, -lbW!-20)
        
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .left, .equal,contentView,.left,20))
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .top, .equal,contentView,.top,20))
        
        contentView.addConstraint(BXLayoutConstraintMake(subTitle, .top, .equal,titleLabel,.bottom,14))
        contentView.addConstraint(BXLayoutConstraintMake(subTitle, .left, .equal,contentView,.left,20))
        
        contentView.addConstraint(BXLayoutConstraintMake(accessoryBtn, .right, .equal,contentView,.right,-20))
        contentView.addConstraint(BXLayoutConstraintMake(accessoryBtn, .centerY, .equal,contentView,.centerY))
        
    }

}

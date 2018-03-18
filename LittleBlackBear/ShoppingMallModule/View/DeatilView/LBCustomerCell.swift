//
//  LBCustomerCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/13.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBCustomerCell: UITableViewCell {

    
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
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(text:String,model:LBHomeMerchantModel,key:String){
        setupUI()
        titleLabel.text = text
        if key == "merExplain" {
            subTitle.text = model.merExplain
        }else{
            subTitle.text = model.merNotice
        }
    }
    
   private let titleLabel  = UILabel()
   private let subTitle = UILabel()
    
   private func setupUI(){
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitle)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = FONT_30PX
        titleLabel.textColor = COLOR_222222
    
        subTitle.font = FONT_28PX
        subTitle.textColor = COLOR_999999
        subTitle.numberOfLines = 0

        
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .left, .equal,contentView,.left,20))
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .top, .equal,contentView,.top,20))
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .height, .equal,nil,.height,20))
        
        contentView.addConstraint(BXLayoutConstraintMake(subTitle, .top, .equal,titleLabel,.bottom,14))
        contentView.addConstraint(BXLayoutConstraintMake(subTitle, .left, .equal,contentView,.left,20))
        
  
        
    }
}

//
//  LBShowGameCouponCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/23.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBShowGameCouponCell: UITableViewCell {
    
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
    
    private let headerView  = UIView()
    private let line  = UIView()
    private let iconImgView = UIImageView()
    private let label = UILabel()
    private let gameImgView = UIImageView()
    
    private func setupUI(){
        
        contentView.addSubview(headerView)
        headerView.addSubview(iconImgView)
        headerView.addSubview(label)
        headerView.addSubview(line)
        
        contentView.addSubview(gameImgView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        iconImgView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false
        gameImgView.translatesAutoresizingMaskIntoConstraints = false
        
        iconImgView.image = UIImage(named:"treasureBox_userIcon")
        
        label.text = "小黑熊砸宝箱"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = COLOR_222222
        
        line.backgroundColor = COLOR_dadada
        
        gameImgView.image = UIImage(named:"treasure_box_Img")
        
        contentView.addConstraint(BXLayoutConstraintMake(headerView, .left, .equal,contentView,.left))
        contentView.addConstraint(BXLayoutConstraintMake(headerView, .top , .equal,contentView,.top))
        contentView.addConstraint(BXLayoutConstraintMake(headerView, .right, .equal,contentView,.right))
        contentView.addConstraint(BXLayoutConstraintMake(headerView, .height, .equal,nil,.height,50))
        
        headerView.addConstraint(BXLayoutConstraintMake(iconImgView, .centerY, .equal,headerView,.centerY))
        headerView.addConstraint(BXLayoutConstraintMake(iconImgView, .left, .equal,headerView,.left,10))
        headerView.addConstraint(BXLayoutConstraintMake(iconImgView, .width, .equal,nil,.width ,33))
        headerView.addConstraint(BXLayoutConstraintMake(iconImgView, .height, .equal,nil,.height,33))
        
        headerView.addConstraint(BXLayoutConstraintMake(label, .left,.equal,iconImgView,.right,5))
        headerView.addConstraint(BXLayoutConstraintMake(label, .centerY, .equal,headerView,.centerY))
        
        headerView.addConstraint(BXLayoutConstraintMake(line, .left, .equal,headerView,.left))
        headerView.addConstraint(BXLayoutConstraintMake(line, .right,.equal,headerView,.right))
        headerView.addConstraint(BXLayoutConstraintMake(line, .bottom, .equal,headerView,.bottom))
        headerView.addConstraint(BXLayoutConstraintMake(line , .height, .equal,nil,.height,0.5))
        
        contentView.addConstraint(BXLayoutConstraintMake(gameImgView, .top, .equal,headerView,.bottom,10))
        contentView.addConstraint(BXLayoutConstraintMake(gameImgView, .centerX, .equal,contentView,.centerX))
        contentView.addConstraint(BXLayoutConstraintMake(gameImgView, .height, .equal,nil,.height,189*AUTOSIZE_X))
        contentView.addConstraint(BXLayoutConstraintMake(gameImgView, .width, .equal,nil,.width,355*AUTOSIZE_Y))
        
        
    }
    
}

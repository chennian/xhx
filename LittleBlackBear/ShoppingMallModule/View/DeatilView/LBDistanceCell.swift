//
//  LBDistanceCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/13.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBDistanceCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var model:LBHomeMerchantModel?{
        didSet{
            guard let item = model else {return}
            button.setTitle(item.address, for: .normal)
            label.text = "距离您" + item.distance
            setupUI()
        }
    }
    
   private let button = UIButton()
   private let label = UILabel()
   private let accessoryBtn = UIButton()
    
   private func setupUI(){
        
        contentView.addSubview(button)
        contentView.addSubview(label)
        contentView.addSubview(accessoryBtn)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        accessoryBtn.translatesAutoresizingMaskIntoConstraints = false
        
        button.titleLabel?.font = FONT_30PX
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button.setImage(UIImage(named:"locationMark"), for: .normal)
        button.setTitleColor(COLOR_999999, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.isUserInteractionEnabled = false 
        
        label.font = FONT_28PX
        label.textColor = COLOR_999999

        accessoryBtn.backgroundColor = UIColor.white
        accessoryBtn.titleLabel?.font = FONT_28PX
        accessoryBtn.setTitleColor(COLOR_999999, for: .normal)
        accessoryBtn.setImage(UIImage(named:"blackrightAccessoryIcon"), for: .normal)
        accessoryBtn.setTitle("查看地图", for: .normal)

        
        let imgW = accessoryBtn.imageView?.image?.size.width
        let lbW  = accessoryBtn.titleLabel?.text?.getSize(15).width
        accessoryBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imgW!, 0, imgW!)
        accessoryBtn.imageEdgeInsets = UIEdgeInsetsMake(0, lbW!, 0, -lbW!-20)
        
        contentView.addConstraint(BXLayoutConstraintMake(button, .left, .equal,contentView,.left,20))
        contentView.addConstraint(BXLayoutConstraintMake(button, .top, .equal,contentView,.top,20))
        contentView.addConstraint(BXLayoutConstraintMake(button, .right, .equal,accessoryBtn,.left))
        
        contentView.addConstraint(BXLayoutConstraintMake(label, .bottom, .equal,contentView,.bottom,-10))
        contentView.addConstraint(BXLayoutConstraintMake(label, .left, .equal,button,.left))
        
        contentView.addConstraint(BXLayoutConstraintMake(accessoryBtn, .right, .equal,contentView,.right,-20))
        contentView.addConstraint(BXLayoutConstraintMake(accessoryBtn, .centerY, .equal,contentView,.centerY))
        contentView.addConstraint(BXLayoutConstraintMake(accessoryBtn, .width, .equal,nil,.width,100))
    
    }

}

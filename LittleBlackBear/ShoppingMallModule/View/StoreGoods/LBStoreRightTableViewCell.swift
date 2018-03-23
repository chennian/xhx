//
//  LBStroeDetailTableViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBStoreRightTableViewCell: UITableViewCell {
    var imgUrl:String = ""{
        didSet{
            guard imgUrl.isURLFormate() == true else{return}
            mainImgView.kf.setImage(with: URL(string:imgUrl))
        }
    }
    var name:String = ""{
        didSet{
            nameLabel.text = name
        }
    }
    var price:String = ""{
        didSet{
            priceLabel.text =  "￥" + price + "元"
        }
    }
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
        self.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0)
        setupUI()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainImgView  = UIImageView()
    private let nameLabel  = UILabel()
    private let priceLabel = UILabel()
    
    private func setupUI() {
        
        contentView.addSubview(mainImgView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        
        mainImgView.translatesAutoresizingMaskIntoConstraints = false
        mainImgView.contentMode = .scaleAspectFill
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        nameLabel.font = FONT_30PX
        priceLabel.font = FONT_30PX
        
        nameLabel.textColor = COLOR_222222
        priceLabel.textColor = COLOR_e60013
        
        contentView.addConstraint(BXLayoutConstraintMake(mainImgView, .left, .equal,contentView,.left,15))
        contentView.addConstraint(BXLayoutConstraintMake(mainImgView, .centerY, .equal,contentView,.centerY))
        contentView.addConstraint(BXLayoutConstraintMake(mainImgView, .width, .equal,nil,.width,75))
        contentView.addConstraint(BXLayoutConstraintMake(mainImgView, .height, .equal,nil,.height,75))
        
        contentView.addConstraint(BXLayoutConstraintMake(nameLabel, .top, .equal,mainImgView,.top))
        contentView.addConstraint(BXLayoutConstraintMake(nameLabel, .left, .equal,mainImgView,.right,12))
        
        contentView.addConstraint(BXLayoutConstraintMake(priceLabel, .left, .equal,mainImgView,.right,12))
        contentView.addConstraint(BXLayoutConstraintMake(priceLabel, .bottom, .equal,mainImgView,.bottom))
        
        
        
    }
}

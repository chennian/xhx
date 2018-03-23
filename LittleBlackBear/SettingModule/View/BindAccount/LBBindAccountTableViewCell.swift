//
//  LBBindAccountTableViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/5.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
enum bindAccountType {
    case phone(String,String,String)
    case wechat(String,String,String)
    
}
class LBBindAccountTableViewCell: UITableViewCell {

    var imageName:String = ""{
        didSet{
            guard imageName.count > 0 else { return }
            imgView.image = UIImage(named:imageName)
        }
    }
    
    var title_text:String = ""{
        didSet{
            guard title_text.count > 0 else { return }
            titleLabel.text = title_text
        }
    }
    
    var rightLabelText:String = ""{
        didSet{
            guard rightLabelText.count > 0 else { return }
            rightLabel.text = rightLabelText

        }
    }
    
    var type:bindAccountType = .phone("","",""){
        didSet{
            switch type {
            case let .phone(imageName, title_text, rightLabelText):
                imgView.image = UIImage(named:imageName)
                titleLabel.text = title_text
                rightLabel.text = rightLabelText
            case let .wechat(imageName, title_text, rightLabelText):
                imgView.image = UIImage(named:imageName)
                titleLabel.text = title_text
                rightLabel.text = rightLabelText
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryView = UIImageView(image: #imageLiteral(resourceName: "redAccessoryIcon"))
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private let imgView = UIImageView()
   private let titleLabel = UILabel()
   private let rightLabel = UILabel()
    
    private func setupUI(){
        
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightLabel)
        
        imgView.translatesAutoresizingMaskIntoConstraints    = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = FONT_28PX
        titleLabel.textColor = COLOR_222222
        
        rightLabel.font = FONT_28PX
        rightLabel.textColor = COLOR_999999
        
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .centerY, .equal,contentView,.centerY))
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .left, .equal,contentView,.left,20))
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .width, .equal,nil,.width,30))
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .height, .equal,nil,.height,30))
        
        
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .centerY, .equal,contentView,.centerY))
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .left, .equal,imgView,.right,10))
        
        contentView.addConstraint(BXLayoutConstraintMake(rightLabel, .centerY, .equal,contentView,.centerY))
        contentView.addConstraint(BXLayoutConstraintMake(rightLabel, .right, .equal,contentView,.right,-10))
    
    }
}

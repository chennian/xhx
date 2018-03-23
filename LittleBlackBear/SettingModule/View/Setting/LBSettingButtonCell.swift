//
//  LBSettingButtonCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/19.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBSettingButtonCell: UITableViewCell {
    
    var cellType:LBSettingCellType = .commitButton(""){
        didSet{
            switch cellType {
            case let .commitButton(tile):
                button.setTitle(tile, for: .normal)
                button.layer.cornerRadius = 5
                button.layer.masksToBounds = true 
            default:
                break
            }
        }
    }
    
    var title:String=""{
        didSet{
            guard title.count > 0 else{return}
            button.setTitle(title, for: .normal)
            button.layer.cornerRadius = 5
            button.layer.masksToBounds = true
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
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let button = UIButton()
    private func setupUI() {
        contentView.backgroundColor = UIColor.white
        button.backgroundColor = COLOR_e60013
        button.setTitleColor(UIColor.white, for: .normal)
        contentView.addSubview(button)
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false

        contentView.addConstraint(BXLayoutConstraintMake(button, .centerX, .equal,contentView,.centerX))
        contentView.addConstraint(BXLayoutConstraintMake(button, .centerY, .equal,contentView,.centerY))
        contentView.addConstraint(BXLayoutConstraintMake(button, .width, .equal,nil,.width,200*AUTOSIZE_X))
        contentView.addConstraint(BXLayoutConstraintMake(button, .height, .equal,nil,.height,45))
        
    }
    
}

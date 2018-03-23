//
//  LBSettingCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/19.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBSettingCell: UITableViewCell {
    
    var cellType:LBSettingCellType = .commitButton(""){
        didSet{
            switch cellType {
            case let .rightLabel(text0,text1,color):
                leftLabel.text = text0
                rightLabel.text = text1
                rightLabel.textColor = color
                showView(views: leftLabel,rightLabel)
            case let .bindAcoountImage(text,strings):
                leftLabel.text = text
                showView(views: leftLabel)
				setupBindAcountImage(strings)
            case let .comm(text):
                leftLabel.text = text
                showView(views: leftLabel)
            default:
                break
            }
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
        accessoryView = UIImageView(image: #imageLiteral(resourceName: "redAccessoryIcon"))
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let leftLabel  = UILabel()
    private let rightLabel = UILabel()
    private func setupUI(){
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leftLabel.textColor = COLOR_222222
        leftLabel.font = FONT_28PX
        
        rightLabel.font = FONT_28PX
        rightLabel.textColor = COLOR_222222
        
        contentView.addConstraint(BXLayoutConstraintMake(leftLabel, .left, .equal,contentView,.left,16))
        contentView.addConstraint(BXLayoutConstraintMake(leftLabel, .centerY, .equal,contentView,.centerY))
        
        contentView.addConstraint(BXLayoutConstraintMake(rightLabel, .centerY, .equal,contentView,.centerY))
        contentView.addConstraint(BXLayoutConstraintMake(rightLabel, .right, .equal,contentView,.right,-16))
        
    }
    
    private func showView(views:UIView...){
        for view in contentView.subviews {
            if  views.contains(view){
                view.isHidden = false
            }else{
                view.isHidden = true
            }
        }
    }
    
    private func setupBindAcountImage(_ list:[String])  {
        
        var imgeviews = [UIImageView]()
        for imgName in list {
            let imgView = UIImageView()
            imgView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(imgView)
            
            var levelIconImgViewToItem = contentView
            if let toItem = imgeviews.last{
                levelIconImgViewToItem = toItem
            }
            imgView.image = UIImage(named:imgName)
            imgeviews.append(imgView)
            contentView.addConstraint(BXLayoutConstraintMake(imgView, .right, .equal,levelIconImgViewToItem,.right,-31))
            contentView.addConstraint(BXLayoutConstraintMake(imgView, .centerY,  .equal,contentView,.centerY))
            contentView.addConstraint(BXLayoutConstraintMake(imgView, .width, .equal,nil,.width,25))
            contentView.addConstraint(BXLayoutConstraintMake(imgView, .height, .equal,nil,.height,25))
        }
    }
}










//
//  LBAppraiseCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/13.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBAppraiseCell: UITableViewCell {
    
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
    var model:LBCommentListModel<commentImageListModel>?{
        didSet{
            guard let item = model else { return}
            startView.startCount = Int(item.avg_grade+0.5)
            titleLabel.text = "\(item.avg_grade)分/\(item.amount)条评价"
            setupUI()

        }
    }
    
    private let titleLabel  = UILabel()
    private let levelImgView = UIImageView()
    private let accessoryBtn = UIButton()
    private let startView  = LBStartLevelView()
    
    func setupUI(){
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(levelImgView)
        contentView.addSubview(accessoryBtn)
        contentView.addSubview(startView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        levelImgView.translatesAutoresizingMaskIntoConstraints = false
        accessoryBtn.translatesAutoresizingMaskIntoConstraints = false
        startView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = FONT_30PX
        titleLabel.textColor = COLOR_222222
        
        
        startView.spacing = 6
        startView.isUserInteractionEnabled = false
        
        accessoryBtn.backgroundColor = UIColor.white
        accessoryBtn.titleLabel?.font = FONT_28PX
        accessoryBtn.setTitleColor(COLOR_999999, for: .normal)
        accessoryBtn.setImage(UIImage(named:"blackrightAccessoryIcon"), for: .normal)
        accessoryBtn.setTitle("评价", for: .normal)
        
        let imgW = accessoryBtn.imageView?.image?.size.width
        let lbW  = accessoryBtn.titleLabel?.text?.getSize(15).width
        accessoryBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imgW!, 0, imgW!)
        accessoryBtn.imageEdgeInsets = UIEdgeInsetsMake(0, lbW!, 0, -lbW!-20)
    
        
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .left, .equal,contentView,.left,20))
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .top, .equal,contentView,.top,20))
        
        contentView.addConstraint(BXLayoutConstraintMake(levelImgView, .top, .equal,titleLabel,.bottom,14))
        contentView.addConstraint(BXLayoutConstraintMake(levelImgView, .left, .equal,contentView,.left,20))
        
        contentView.addConstraint(BXLayoutConstraintMake(accessoryBtn, .right, .equal,contentView,.right,-20))
        contentView.addConstraint(BXLayoutConstraintMake(accessoryBtn, .centerY, .equal,contentView,.centerY))
        
        addConstraint(BXLayoutConstraintMake(startView, .left, .equal,titleLabel,.left))
        addConstraint(BXLayoutConstraintMake(startView, .top, .equal,titleLabel,.bottom,10))
        addConstraint(BXLayoutConstraintMake(startView, .width, .equal,nil,.width,120*AUTOSIZE_X))
        addConstraint(BXLayoutConstraintMake(startView, .height, .equal,nil,.height,30))
        
        
        
    }
}

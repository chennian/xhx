//
//  LBShoppingDetaillCollectionViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/16.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBShoppingDetaillCollectionViewCell: UICollectionViewCell {
    
    
    var imgUrl:String = ""{
        didSet{
            guard imgUrl.isURLFormate() else {return}
            imgView.kf.setImage(with: URL(string:imgUrl))
        }
    }
    var imgName:String = ""{
        didSet{
            guard imgName.count > 0 else {return}
            imgView.image = UIImage(named:imgName)
        }
    }
    
    var title_text:String = ""{
        didSet{
            guard title_text.count > 0 else{return}
            titleLabel.text = title_text
        }
    }
    
    var subTitle_text:String = ""{
        didSet{
            guard subTitle_text.count > 0 else{return}
            subTitleLabel.text = subTitle_text
        }
    }
    
    private let imgView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        subTitleLabel.text = "dfafjalf;kj"
        titleLabel.text = "dfafjalf;kj"
        imgView.backgroundColor = UIColor.arc4randomColor()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = FONT_30PX
        titleLabel.textColor = COLOR_222222
        
        subTitleLabel.font = FONT_30PX
        subTitleLabel.textColor = COLOR_9C9C9C
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .centerX, .equal,contentView,.centerX))
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .top, .equal,contentView,.top))
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .width, .equal,nil,.width,100))
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .height, .equal,nil,.height,75))
        
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel,.left, .equal,imgView,.left))
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel,.top, .equal,imgView,.bottom,12))
        
        contentView.addConstraint(BXLayoutConstraintMake(subTitleLabel,.left, .equal,titleLabel,.left))
        contentView.addConstraint(BXLayoutConstraintMake(subTitleLabel,.top, .equal,titleLabel,.bottom,10))
       
    }
}

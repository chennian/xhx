//
//  LBShoppingCollectionViewCell.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/9.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
class LBShoppingHeaderCollectionViewCell: UICollectionViewCell {
	
	var image:UIImage = UIImage(){
		didSet{
			guard image.size.height > 0 else {return}
			imageView.image = image
		}
	}
	var imageName:String = ""{
		didSet{
			guard imageName.count > 0 else {return}
			imageView.image = UIImage(named: imageName)
		}
	}
	var imageUrl:String = ""{
		didSet{
            Print(imageUrl)
			guard imageUrl.count > 0 && imageUrl.isURLFormate() == true else {return}
			imageView.kf.setImage(with: URL(string: imageUrl))
		}
	}
	var titleLabel_text:String = ""{
		didSet{
			guard titleLabel_text.count > 0 else {return}
            Print(titleLabel_text)
			titleLabel.text = titleLabel_text
		}
	}
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configContentView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private let imageView  = UIImageView()
	private let titleLabel = UILabel()
	
	func configContentView() {
        
		contentView.addSubview(imageView)
		contentView.addSubview(titleLabel)
		
		imageView.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
		titleLabel.font = FONT_28PX
		titleLabel.textAlignment = .center
        
        contentView.addConstraint(BXLayoutConstraintMake(imageView, .top,  .equal,contentView,.top))
        contentView.addConstraint(BXLayoutConstraintMake(imageView, .centerX, .equal,contentView,.centerX))
        contentView.addConstraint(BXLayoutConstraintMake(imageView, .width,.equal,nil,.width,52.5))
        contentView.addConstraint(BXLayoutConstraintMake(imageView, .height,.equal,nil,.height,43.5))
        
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .centerX,.equal,imageView,.centerX))
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .top,.equal,imageView,.bottom,10))
        
//        contentView.addConstraint(BXLayoutConstraintMake(imageView, .centerX,  .equal,contentView,.centerX))
//        contentView.addConstraint(BXLayoutConstraintMake(imageView, .centerY, .equal,contentView,.centerY))
//        contentView.addConstraint(BXLayoutConstraintMake(imageView, .width,.equal,contentView,.width,52.5*AUTOSIZE_X))
//        contentView.addConstraint(BXLayoutConstraintMake(imageView, .height,.equal,contentView, .height,43.5*AUTOSIZE_Y))
//
//        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .centerX,.equal,contentView,.centerX))
//        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .bottom,.equal,contentView,.bottom))
      

	}
	
	
}





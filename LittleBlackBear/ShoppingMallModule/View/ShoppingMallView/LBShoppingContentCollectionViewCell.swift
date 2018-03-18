//
//  LBShoppingContentCollectionViewCell.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/9.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBShoppingContentCollectionViewCell: UICollectionViewCell {
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
			guard imageUrl.count > 0 && imageUrl.isURLFormate() == true else {return}
			imageView.kf.setImage(with: URL(string: imageUrl))
		}
	}
	var titleLabel_text:String = ""{
		didSet{
			guard titleLabel_text.count > 0 else {return}
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
		titleLabel.layer.cornerRadius = 15
		titleLabel.layer.masksToBounds = true
		
		contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .height,.equal,nil,.height,30))
		contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .top, .equal,contentView,.top,10))
		contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .left,.equal,contentView,.left,10))
		
		contentView.addConstraint(BXLayoutConstraintMake(imageView, .left, .equal,titleLabel,.left))
		contentView.addConstraint(BXLayoutConstraintMake(imageView, .top, .equal,titleLabel,.bottom,10))
		contentView.addConstraint(BXLayoutConstraintMake(imageView, .right, .equal,contentView,.right,-10))
		contentView.addConstraint(BXLayoutConstraintMake(imageView, .bottom, .equal,contentView,.bottom,-10))

		
	}
}

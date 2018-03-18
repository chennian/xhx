//
//  LBImageCollectionViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/13.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBImageCollectionViewCell: UICollectionViewCell {
    
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

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageView  = UIImageView()
    private func configContentView() {
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        contentView.addConstraint(BXLayoutConstraintMake(imageView, .top,  .equal,contentView,.top))
        contentView.addConstraint(BXLayoutConstraintMake(imageView, .left, .equal,contentView,.left))
        contentView.addConstraint(BXLayoutConstraintMake(imageView, .right,.equal,contentView,.right))
        contentView.addConstraint(BXLayoutConstraintMake(imageView, .bottom,.equal,contentView,.bottom))
        
  
        
    }
    
}

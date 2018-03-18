//
//  LBNewsImageViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/5.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBNewsImageViewCell: UICollectionViewCell {
    var image:UIImage{
        set{
            guard newValue.size.height > 0 else {return}
            imageView.image = newValue
        }
        get{
            return self.imageView.image ?? UIImage()
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
//            imageView.kf.setImage(with:  URL(string: imageUrl)) {[weak self] (image, _, _, _) in
//                guard let strongSelf = self else{return}
//                guard image != nil , image!.size.height > 0 else{return}
//                let size = CGSize(width:(KSCREEN_WIDTH-2*6-20)/3, height: (KSCREEN_WIDTH-40)/3)
//                guard let image = UIImage.thumbnailWithImageWithoutScale(image!, size: size) else { return}
//                strongSelf.imageView.image = image
//            }
          
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
    
    func configContentView() {
        
        contentView.subviews.forEach{$0.removeFromSuperview()}
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(BXLayoutConstraintMake(imageView, .top,  .equal,contentView,.top))
        contentView.addConstraint(BXLayoutConstraintMake(imageView, .left, .equal,contentView,.left))
        contentView.addConstraint(BXLayoutConstraintMake(imageView, .right,.equal,contentView,.right))
        contentView.addConstraint(BXLayoutConstraintMake(imageView, .bottom,.equal,contentView,.bottom))
        
    }

    
    
}

//
//  LBMerchantApplyTypeViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBMerchantApplyTypeViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageName: String = "" {
        didSet{
            guard imageName.count > 0 else {
                return
            }
            _iamgeView.image = UIImage(named:imageName)
        }
    
    }
    private let _iamgeView: UIImageView = {
        let imageView  = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private func configUI() {
        contentView.addSubview(_iamgeView)
        contentView.addConstraint(BXLayoutConstraintMake(_iamgeView, .centerX, .equal,contentView,.centerX))
        contentView.addConstraint(BXLayoutConstraintMake(_iamgeView, .top, .equal,contentView,.top,42*AUTOSIZE_Y))
        contentView.addConstraint(BXLayoutConstraintMake(_iamgeView, .width, .equal,nil,.width,345*AUTOSIZE_X))
        contentView.addConstraint(BXLayoutConstraintMake(_iamgeView, .height, .equal,nil,.height,225*AUTOSIZE_Y))
    }
    
}

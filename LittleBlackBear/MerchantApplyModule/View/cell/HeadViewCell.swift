//
//  HeadViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class HeadViewCell: UIView {
    
    open var title: String = "222" {
        didSet {
            label.text = title
        }
    }
    
    
    fileprivate let label: UILabel = {
        let label = UILabel()
        label.font = FONT_28PX
        label.textColor = COLOR_1478b8
        return label
    }()
    fileprivate let separatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "xx.png")
        return imageView
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        self.title = title
        label.text = title
        
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(label)
        addSubview(separatorImageView)
        // label
        ({
            label.translatesAutoresizingMaskIntoConstraints = false
            let leftConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 25.0)
            let rightConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -25.0)
            let centerYConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
            self.addConstraints([leftConstraint, rightConstraint, centerYConstraint])
            }())
        
        // separatorImageView
        ({
            separatorImageView.translatesAutoresizingMaskIntoConstraints = false
            let leftConstraint = NSLayoutConstraint(item: separatorImageView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 15.0)
            let rightConstraint = NSLayoutConstraint(item: separatorImageView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -15.0)
            let bottomConstraint = NSLayoutConstraint(item: separatorImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0)
            let heightConstraint = NSLayoutConstraint(item: separatorImageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 1.0)
            self.addConstraints([leftConstraint, rightConstraint, bottomConstraint])
            separatorImageView.addConstraint(heightConstraint)
            }())
    }

}



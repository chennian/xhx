//
//  ImageTableViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

enum ImageTableViewCellType {
    case images(images: [UIImage?])
    case titleImages(title: String, images: [UIImage?])
}

class ImageTableViewCell: LBMerchantApplyTableViewCell, ApplyTableViewCellProtocol {
	
	static var indentifier: String = "ImageTableViewCell"
	
    override var images: [UIImage?] {
        didSet {
            guard imageViews.count >= images.count else {
                return
            }
            for (step, image) in images.enumerated() {
                imageViews[step].image = image
            }
        }
    }
    fileprivate var title: String?
    fileprivate var imageViews = [UIImageView]()
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FONT_28PX
        label.textColor = COLOR_666666
        return label
    }()
    
    fileprivate let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    
    
    
    var myType: ImageTableViewCellType = .images(images: [UIImage]()) {
        didSet {
            self.cellType = ApplyTableViewCellType.image(myType)
            for view in mycontentView.subviews {
                view.removeFromSuperview()
            }
            imageViews.removeAll()
            
            switch myType {
            case let .images(images: images):
                separatorView.isHidden = true
                mycontentViewTopConstraint?.constant = 0
                self.images = images
                self.title = nil
				setupUI()
            case let .titleImages(title, images):
                separatorView.isHidden = false
                mycontentViewTopConstraint?.constant = 5
                self.title = title
                self.images = images
				setupUI()

            }
        }
    }

    
    func setupUI() {
        
        guard let title = title else {
            setupConstraint(of: images, firstToItem: mycontentView, firstC: 25)
           return
        }
        ({
            contentView.addSubview(separatorView)
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addConstraint(NSLayoutConstraint(item: separatorView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0.0))
            contentView.addConstraint(NSLayoutConstraint(item: separatorView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 0.0))
            contentView.addConstraint(NSLayoutConstraint(item: separatorView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: 0.0))
            separatorView.addConstraint(NSLayoutConstraint(item: separatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 5.0))
            }())
        

        titleLabel.text = title
        mycontentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        mycontentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: mycontentView, attribute: .top, multiplier: 1.0, constant: 11.0))
        mycontentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: mycontentView, attribute: .left, multiplier: 1.0, constant: 0.0))
        setupConstraint(of: images, firstToItem: titleLabel, firstC: 13)
        
    }
    
    func setupConstraint(of images: [UIImage?], firstToItem: UIView, firstC: CGFloat) {
        for image in images {
            let imageView = UIImageView(image: image)
            imageView.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(imageBtnClick(ges:)))
            imageView.addGestureRecognizer(tapGes)
            imageView.tag = imageViews.count
            mycontentView.addSubview(imageView)
            var toItem = firstToItem
            var c: CGFloat = firstC
            var toAttribute: NSLayoutAttribute = .bottom
            if let lastImageView = imageViews.last {
                toItem = lastImageView
                c = 22
            }
            if toItem == mycontentView {
                toAttribute = .top
            }
            
            imageViews.append(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            guard let size = image?.size else {
                return
            }
            mycontentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: mycontentView, attribute: .width, multiplier: 1.0, constant: 0.0))
            mycontentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: mycontentView, attribute: .width, multiplier: size.height / size.width, constant: 0.0))
            mycontentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: toAttribute, multiplier: 1.0, constant: c))
//              mycontentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: mycontentView, attribute: .bottom, multiplier: 1.0, constant: -10  ))
            mycontentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: mycontentView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
            
        }

    }
    
    func imageBtnClick(ges: UITapGestureRecognizer) {
        delegate?.imageCell?(self, imageButtonClick: ges.view as! UIImageView)
    }
}

//
//  SegmentedHeadView.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class SegmentedHeadView: ApplyHeadView {
    
    fileprivate let segmentedViewHeight: CGFloat = 50.0
    
override  var headViewHeight: CGFloat {
        return segmentedViewHeight + topViewHeight
    }
    
    fileprivate var images = [String]()

    init(_ topImage: String, _ images: [String]) {
        self.images = images
        super.init(topImage: topImage)
        backgroundColor = UIColor.white
        let segmentedImageView = SegmentedImageView(segmentedImageStrs: images) { [weak self] (index) in
            self?.delegate?.didSelect?(self!, index: index)
        }
        addSubview(segmentedImageView)
        segmentedImageView.translatesAutoresizingMaskIntoConstraints = false

        // 15 5
        let topConstraint = NSLayoutConstraint(item: segmentedImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: topView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 15.0)
        let centerXConstraint = NSLayoutConstraint(item: segmentedImageView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0)
        self.addConstraints([topConstraint, centerXConstraint])

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

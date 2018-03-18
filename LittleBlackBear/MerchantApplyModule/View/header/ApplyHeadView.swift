//
//  ApplyHeadView.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

enum ApplyHeadViewStyle {
    case none(topImage: String)
    case custom(topImage: String, titles: [String])
    case segmented(topImage: String, images: [String])
}

protocol ApplyHeadViewProtocol {
    var headViewHeight: CGFloat { get }
}

protocol ApplyHeadViewDelegate: SegmentedHeadViewDelegate {
    
}

// sub
@objc protocol SegmentedHeadViewDelegate: NSObjectProtocol {
    @objc optional func didSelect(_ segmentedHeadView: SegmentedHeadView, index: Int)
}

class ApplyHeadView: UIView, ApplyHeadViewProtocol {
    var headViewHeight: CGFloat {
        return topViewHeight
    }

    weak open var delegate: ApplyHeadViewDelegate?
    
    let topViewHeight: CGFloat = 100.0 + 64.0
    let topView: UIImageView = {
        let topView = UIImageView()
        return topView
    }()
    fileprivate let topImageView: UIImageView = {
        let topView = UIImageView()
        return topView
    }()
    
    init(topImage: String) {
        super.init(frame: .zero)
        topImageView.image = UIImage(named: topImage)
        topView.image = UIImage(named: "bj")
        addSubview(topView)
        topView.addSubview(topImageView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[topView]-0-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["topView": topView]))
        topView.addConstraint(NSLayoutConstraint(item: topView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: topViewHeight))
        addConstraint(NSLayoutConstraint(item: topView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))
        
        topView.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .centerX, relatedBy: .equal, toItem: topView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        topView.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .bottom, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1.0, constant: -25.0))

    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

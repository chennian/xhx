//
//  CustomHeadView.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//
import UIKit



class CustomHeadView: ApplyHeadView {
    
    fileprivate var headViewCells = [HeadViewCell]()
    
    fileprivate let cellHeight: CGFloat = 50.0
    
    fileprivate var titles = [String]()
    
    fileprivate let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = COLOR_efefef
        return view
    }()
    
    override var headViewHeight: CGFloat {
        return cellHeight * titles.count.f + 17.f + topViewHeight + 5.f
    }
    
    
    init(_ topImage: String, _ titles: [String]) {
        super.init(topImage: topImage)
        backgroundColor = UIColor.white
        self.titles = titles
        for title in titles {
            let headViewCell = HeadViewCell(title: title)
            addSubview(headViewCell)
            headViewCells.append(headViewCell)
            setupConstraint(of: headViewCell)
        }
        addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addConstraint(NSLayoutConstraint(item: bottomView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 5.0))
        guard let lastCell = headViewCells.last else {
            return
        }
        
        addConstraint(NSLayoutConstraint(item: bottomView, attribute: .top, relatedBy: .equal, toItem: lastCell, attribute: .bottom, multiplier: 1.0, constant: 17.f))
            addConstraint(NSLayoutConstraint(item: bottomView, attribute: .left, relatedBy: .equal, toItem: lastCell, attribute: .left, multiplier: 1.0, constant: 0.0))

                addConstraint(NSLayoutConstraint(item: bottomView, attribute: .right, relatedBy: .equal, toItem: lastCell, attribute: .right, multiplier: 1.0, constant: 0.0))

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension CustomHeadView {
    fileprivate func setupConstraint(of headViewCell: HeadViewCell) {
        ({
            headViewCell.translatesAutoresizingMaskIntoConstraints = false
            let leftConstraint = NSLayoutConstraint(item: headViewCell, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0)
            let rightConstraint = NSLayoutConstraint(item: headViewCell, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0)
            let topConstraint = NSLayoutConstraint(item: headViewCell, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: topView, attribute: .bottom, multiplier: 1.0, constant: (headViewCells.count - 1).f * cellHeight)
            let heightConstraint = NSLayoutConstraint(item: headViewCell, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: cellHeight)
            headViewCell.addConstraint(heightConstraint)
            self.addConstraints([leftConstraint, rightConstraint, topConstraint])
            }())
    }
}

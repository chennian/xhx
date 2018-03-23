//
//  ApplyHeadViewFactory.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/31.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ApplyHeadViewFactory  {
    class func applyHeadView(tableView: UITableView, style: ApplyHeadViewStyle) -> ApplyHeadView? {
        var height: CGFloat = 0.0
        switch style {
        case let .none(topImage: topImage):
            let applyHeadView = ApplyHeadView(topImage: topImage)
            height = applyHeadView.headViewHeight
            tableView.tableHeaderView = applyHeadView
        case let .custom(topImage, titles):
            let customView = CustomHeadView(topImage, titles)
            height = customView.headViewHeight
            tableView.tableHeaderView = customView
        case let .segmented(topImage, images):
            let segmentedView = SegmentedHeadView(topImage, images)
            height = segmentedView.headViewHeight
            tableView.tableHeaderView = segmentedView
        }
        guard let headView = tableView.tableHeaderView else {
            return nil
        }
        
        headView.translatesAutoresizingMaskIntoConstraints = false
        tableView.addConstraint(NSLayoutConstraint(item: headView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: tableView, attribute: .top, multiplier: 1.0, constant: 0.0))
        headView.addConstraint(NSLayoutConstraint(item: headView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width))
        headView.addConstraint(NSLayoutConstraint(item: headView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: height))
        headView.setNeedsLayout()
        headView.layoutIfNeeded()
        return headView as? ApplyHeadView
    }
}

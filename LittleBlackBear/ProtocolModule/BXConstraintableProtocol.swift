//
// BXConstraintableProtocol.swift
//  BXFractionLink
//
//  Created by 蘇崢 on 2017/7/18.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

protocol Constraintable: class {
	var customConstraints: [NSLayoutConstraint] { get set }
	var visualConstraints: [String] { get }
	var constraintsViews: [String:UIView] { get }
	func updateConstraint()
}
extension Constraintable where Self:UIView{

	func updateConstraint() {
		if customConstraints.count > 0 {
			removeConstraints(customConstraints)
		}
		for visualConstraint in visualConstraints {
			let constraints = NSLayoutConstraint.constraints(withVisualFormat: visualConstraint, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: constraintsViews)
			for constait in constraints {
				customConstraints.append(constait)
			}
		}
		addConstraints(customConstraints)
		if #available(iOS 9.0, *) {
			self.updateFocusIfNeeded()
		} else {
			self.updateConstraints()
		}
	}
}
extension Constraintable where Self: UITableViewCell{
	
	
	func updateConstraint() {
		if customConstraints.count > 0 {
			contentView.removeConstraints(customConstraints)
		}
		for visualConstraint in visualConstraints {
			let constraints = NSLayoutConstraint.constraints(withVisualFormat: visualConstraint, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: constraintsViews)
			for constait in constraints {
				customConstraints.append(constait)
			}
		}
		contentView.addConstraints(customConstraints)
		if #available(iOS 9.0, *) {
			self.updateFocusIfNeeded()
		} else {
			self.updateConstraints()
		}
	}
}
extension Constraintable where Self: UICollectionViewCell{
	
	func updateConstraint() {
		
		if customConstraints.count > 0 {
			contentView.removeConstraints(customConstraints)
		}
		for visualConstraint in visualConstraints {
			let constraints = NSLayoutConstraint.constraints(withVisualFormat: visualConstraint, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: constraintsViews)
			for constait in constraints {
				customConstraints.append(constait)
			}
		}
		contentView.addConstraints(customConstraints)
		if #available(iOS 9.0, *) {
			self.updateFocusIfNeeded()
		} else {
			self.updateConstraints()
		}
	}
}
@inline(__always)
internal func BXLayoutConstraintMake(_ item: AnyObject, _ attr1: NSLayoutAttribute, _ related: NSLayoutRelation, _ toItem: AnyObject? = nil, _ attr2: NSLayoutAttribute = .notAnAttribute, _ constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriority.init(1000), multiplier: CGFloat = 1, output: UnsafeMutablePointer<NSLayoutConstraint?>? = nil) -> NSLayoutConstraint {
	
	let c = NSLayoutConstraint(item:item, attribute:attr1, relatedBy:related, toItem:toItem, attribute:attr2, multiplier:multiplier, constant:constant)
	c.priority = priority
	if output != nil {
		output?.pointee = c
	}
	
	return c
}

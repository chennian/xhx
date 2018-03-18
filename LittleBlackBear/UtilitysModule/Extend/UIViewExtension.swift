//
//  UIViewExtension.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/10/25.
//  Copyright © 2017年 蘇崢. All rights reserved.
//
import UIKit
extension UIView {
	
	public var x: CGFloat{
		get{
			return self.frame.origin.x
		}
		set{
			var r = self.frame
			r.origin.x = newValue
			self.frame = r
		}
	}
	
	public var y: CGFloat{
		get{
			return self.frame.origin.y
		}
		set{
			var r = self.frame
			r.origin.y = newValue
			self.frame = r
		}
	}
	public var rightX: CGFloat{
		get{
			return self.x + self.width
		}
		set{
			var r = self.frame
			r.origin.x = newValue - frame.size.width
			self.frame = r
		}
	}
	public var bottomY: CGFloat{
		get{
			return self.y + self.height
		}
		set{
			var r = self.frame
			r.origin.y = newValue - frame.size.height
			self.frame = r
		}
	}
	
	public var centerX : CGFloat{
		get{
			return self.center.x
		}
		set{
			self.center = CGPoint(x: newValue, y: self.center.y)
		}
	}
	
	public var centerY : CGFloat{
		get{
			return self.center.y
		}
		set{
			self.center = CGPoint(x: self.center.x, y: newValue)
		}
	}
	
	public var width: CGFloat{
		get{
			return self.frame.size.width
		}
		set{
			var r = self.frame
			r.size.width = newValue
			self.frame = r
		}
	}
	public var height: CGFloat{
		get{
			return self.frame.size.height
		}
		set{
			var r = self.frame
			r.size.height = newValue
			self.frame = r
		}
	}
	
	
	public var origin: CGPoint{
		get{
			return self.frame.origin
		}
		set{
			self.x = newValue.x
			self.y = newValue.y
		}
	}
	
	public var size: CGSize{
		get{
			return self.frame.size
		}
		set{
			self.width = newValue.width
			self.height = newValue.height
		}
	}
	public var topValue: CGFloat {
		get {
			return self.frame.origin.y
		}
		set {
			var frame = self.frame
			frame.origin.y = y
			self.frame = frame
		}
	}
	
	func screenViewYValue() -> CGFloat {
		var y:CGFloat = 0
		var supView: UIView = self
		while let view = supView.superview {
			y += view.frame.origin.y
			if let scrollView = view as? UIScrollView {
				y -= scrollView.contentOffset.y
			}
			supView = view
		}
		return y
	}

}

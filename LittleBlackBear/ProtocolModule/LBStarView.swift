//
//  LBStarView.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/9.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
protocol  LBStarViewDelegate{
	
	func starView(_ radius:Float,_ fillColor:UIColor)->UIImage
 
}
class LBStarView: UIView {
	
	let defaultAngle = -Double.pi/2
	
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		let centerPoint:CGFloat	= rect.size.width * 0.5
		let radius = rect.size.width * 0.5
		let context:CGContext  =
			UIGraphicsGetCurrentContext()!
		let startPath = CGMutablePath()
		let angles = NSMutableArray()
		for i in 0..<10{
			let nextAngle = Double(i) / 10.0 * (Double.pi*2)
			angles.addObjects(from: [defaultAngle+nextAngle])
		}
		
		for i  in 0..<angles.count {
			
			let angle:CGFloat = CGFloat(angles[i] as! Double )
			let r:CGFloat = i%2 == 0 ? radius:centerPoint*0.4
			let x:CGFloat = centerPoint + r * cos(angle)
			let y:CGFloat = centerPoint + r * sin(angle)
			if (i == 0) {
				startPath.move(to: CGPoint(x: x, y: y))
			} else {
				startPath.addLine(to: CGPoint(x: x, y: y))
			}
		}
		startPath.closeSubpath()
		context.addPath(startPath)
		context.setStrokeColor(COLOR_e6e6e6.cgColor)
        context.setFillColor(COLOR_e60013.cgColor)

		context.strokePath()
//        context.addPath(startPath)
		context.clip()
		context.fill(self.frame)
    
	}
}

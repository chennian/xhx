//
//  LBlineView.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/11.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBlineView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        context?.setLineCap(.round)
        context?.setLineWidth(3.0)
        context?.setStrokeColor(COLOR_e6e6e6.cgColor)
        context?.setFillColor(COLOR_ffffff.cgColor)
        context?.beginPath()
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.setLineDash(phase: 0, lengths: [10,10])
        context?.addLine(to: CGPoint(x: KSCREEN_WIDTH, y: 0))
        context?.strokePath()
        context?.closePath()
        
    }
   

}

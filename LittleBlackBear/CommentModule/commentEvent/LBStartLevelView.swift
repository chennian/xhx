//
//  LBStartLevelView.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/20.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBStartLevelView: UIView {
    
    var selectCompletHandler:((Int)->Void)?
    var startCount = 0{
        didSet{
            if startCount>5 {
                startCount = 5
            }
            index = startCount
            setNeedsDisplay()
        }
    }
    var spacing:CGFloat = 0{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    fileprivate  var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = COLOR_ffffff
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let norImage = #imageLiteral(resourceName: "home_star2")//UIImage()
        let selImage = #imageLiteral(resourceName: "home_star1")//UIImage(named: "home_star1")
        
        let context:CGContext = UIGraphicsGetCurrentContext()!
        let defaultMargin = spacing == 0 ?6:spacing

        for i in 0..<5 {
            let image = (i<index) ? selImage:norImage
            let x = i==0 ? spacing:CGFloat(i)*(defaultMargin+fit(25))+defaultMargin
            let rect = CGRect(x: x, y: 0, width: fit(25), height: 15*AUTOSIZE_Y)
            drawImage(context: context, image: image.cgImage , rect: rect)
        }
    }
    
    private func drawImage(context:CGContext,image:CGImage?,rect:CGRect){
        if image == nil {return}
        context.saveGState()
        context.translateBy(x: rect.origin.x, y: rect.origin.y)
        context.translateBy(x: 0, y: rect.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: -rect.origin.x, y: -rect.origin.y)
        context.draw(image!, in: rect)
        context.restoreGState()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            let point = touch.location(in: self)
            index = Int(point.x/(self.width/5)+1)
            if index == 6{
                index -= 1
            }

            startCount = index
            setNeedsDisplay()
        }
        guard let action = selectCompletHandler else { return  }
        action(index)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
}



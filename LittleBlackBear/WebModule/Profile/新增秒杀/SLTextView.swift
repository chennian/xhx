 //
//  SLTextView.swift
//  TextViewSwiftDemo
//
//  Created by snowlu on 2017/6/30.
//  Copyright © 2017年 ZhunKuaiTechnology. All rights reserved.
//

import UIKit

class SLTextView: UITextView {

    
   @IBInspectable   public var placeholder:NSString?
    
   @IBInspectable public var placeholderColor:UIColor? = UIColor.black
    
   @IBInspectable public var  placeholderFont:UIFont?
    
    override  var text: String! {
    
        get{
            return  super.text
        }
        
        set{
        
            super.text = newValue
            self.setNeedsDisplay()
        }
    }
    
    override var font: UIFont?{
        
        get {
            
            return  super.font
        }
        set{
            super.font = newValue
            
            self.setNeedsDisplay()
        }
        
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        
      super.init(frame: frame, textContainer: textContainer)
    
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: .UITextViewTextDidChange, object: self)
        
        
    }
    @objc func textDidChange(){
      self.delegate?.textViewDidChange!(self)
       self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        guard !self.hasText else {
           
    
            return
        }
       let attrs = NSMutableDictionary.init()
        
        attrs.setValue(self.font, forKey: NSAttributedStringKey.font.rawValue)

        attrs.setValue(self.placeholderColor, forKey: NSAttributedStringKey.foregroundColor.rawValue)
        
        let x:CGFloat  = 8.0
        
        let  y:CGFloat  = 8.0
        
        let widht  = rect.size.width - 2 * x
        
        let height  = rect.size.height  - 2 * y
        
        let tempRect = CGRect.init(x: x, y: y, width:widht, height: height)
        
//        self.placeholder?.draw(in: tempRect, withAttributes:attrs as? [String : Any])
    
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}


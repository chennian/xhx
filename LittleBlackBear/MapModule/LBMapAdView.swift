//
//  LBMapAdView.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/25.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBMapAdView: UIView {
    
    var url:String = ""{
        didSet{
            guard url.isURLFormate() == true else {
                return
            }
            imageView.kf.setImage(with:URL(string:url), placeholder: nil, options: nil, progressBlock: nil) {[weak self] (image, _, _, _) in
                guard let strongSelf = self else {return}
                guard let size  = image?.size else {return}
                if size.width > KSCREEN_WIDTH/2,size.height > KSCREEN_HEIGHT/2{
                    strongSelf.setupUI(CGSize(width: size.width/3, height: size.height/3))

                }else{
                    strongSelf.setupUI(size)

                }
            }
        }
    }
    var showNextView:(()->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dissAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageView = UIImageView()
    private func setupUI(_ size:CGSize){
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(BXLayoutConstraintMake(imageView, .centerX, .equal,self,.centerX))
        addConstraint(BXLayoutConstraintMake(imageView, .centerY, .equal,self,.centerY))
        addConstraint(BXLayoutConstraintMake(imageView, .height, .equal,nil,.height,size.height))
        addConstraint(BXLayoutConstraintMake(imageView, .width, .equal,nil,.width,size.width))

       Print(imageView)
        
    }
    func dissAction(){
        guard let action = showNextView else { return }
        action()
        self.removeFromSuperview()

    }
}

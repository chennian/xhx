//
//  LBGameBoxView.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/23.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBGameBoxView: UIView {
    
    var shakeAnimationCompletionHandler:((UIImageView)->())?
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupUI()
        self.backgroundColor = UIColor.rgb(0, 0,0, alpha: 0.5)
        self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT)
        closeBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        boxImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openBoxAction(_ :))))
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.1
        scaleAnimation.duration = 0.75
        scaleAnimation.toValue = 1.0
        boxImgView.layer.add(scaleAnimation, forKey: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let boxImgView = UIImageView()
    private let closeBtn = UIButton()

    
    func setupUI(){
        
        addSubview(boxImgView)
        addSubview(closeBtn)
        
        boxImgView.translatesAutoresizingMaskIntoConstraints = false
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        
        boxImgView.isUserInteractionEnabled = true
        
        boxImgView.image = UIImage(named:"open_treasureBox_img")
        closeBtn.setImage(UIImage(named:"x"), for: .normal)
        
        addConstraint(BXLayoutConstraintMake(boxImgView,.centerX, .equal,self,.centerX))
        addConstraint(BXLayoutConstraintMake(boxImgView,.centerY, .equal,self,.centerY))
        addConstraint(BXLayoutConstraintMake(boxImgView, .width,.equal,nil,.width,270))
        addConstraint(BXLayoutConstraintMake(boxImgView, .height,.equal,nil,.height,175))
        
        addConstraint(BXLayoutConstraintMake(closeBtn, .left,.equal,boxImgView,.right))
        addConstraint(BXLayoutConstraintMake(closeBtn, .bottom, .equal,boxImgView,.top))
        addConstraint(BXLayoutConstraintMake(closeBtn, .width, .equal,nil,.width,45))
        addConstraint(BXLayoutConstraintMake(closeBtn, .height, .equal,nil,.height,45))

    }
    
    func closeAction()  {
        self.removeFromSuperview()
    }
    
    func openBoxAction(_ tap:UITapGestureRecognizer){
        
        let shakeAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        shakeAnimation.fromValue = -10
        shakeAnimation.toValue = 10
        shakeAnimation.speed = 2
        shakeAnimation.repeatCount = 5
        shakeAnimation.autoreverses = true
        shakeAnimation.delegate = self
        boxImgView.layer.add(shakeAnimation, forKey: "shakeAnimation")
        
    }
    
}

extension LBGameBoxView:CAAnimationDelegate{
    
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let action = shakeAnimationCompletionHandler else { return }
        action(boxImgView)

    }
}




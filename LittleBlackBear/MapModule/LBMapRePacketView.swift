//
//  LBMapRePacketView.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/21.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBMapRePacketView: UIView {
    
    var cickOpenRedPacketAction:(()->Void)?
    var animationCompletionHandler:((UIImageView)->())?
    var removeFromSuperviewAction:(()->())?
    var moneyValue:String = ""{
        didSet{
            guard moneyValue.count > 0 else {
                moneyLabel.isHidden = true
                return
            }
            moneyLabel.isHidden = false
            moneyLabel.text = moneyValue + "元"
            configMoneyLabel(string: moneyLabel.text!)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = UIColor.rgb(0, 0, 0, alpha: 0.7)
        self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT)
        
        redPacketImgView.image = UIImage(named:"redPacket_backGroud")
        openRedPacketBtn.setBackgroundImage(UIImage(named:"redPacket_open"), for: .normal)
        openRedPacketBtn.addTarget(self, action: #selector(openRedPacketAction(_:)), for: .touchUpInside)

        redPacketImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(superviewRemoveFromSuperview)))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let redPacketImgView = UIImageView()
    fileprivate let openRedPacketBtn = UIButton()
    fileprivate let redPacketGoldImgView = UIImageView()
    fileprivate let moneyLabel = UILabel()
    
    private func setupUI()  {
        
        addSubview(redPacketImgView)
        redPacketImgView.addSubview(openRedPacketBtn)
        addSubview(moneyLabel)
        
        redPacketImgView.isUserInteractionEnabled = true
        
        redPacketImgView.translatesAutoresizingMaskIntoConstraints = false
        openRedPacketBtn.translatesAutoresizingMaskIntoConstraints = false
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        moneyLabel.isHidden = true
        moneyLabel.textColor = COLOR_ffffff
        moneyLabel.font = FONT_50PX
        
        // redPacketImgView
        ({
            addConstraint(BXLayoutConstraintMake(redPacketImgView, .centerX, .equal,self,.centerX))
            addConstraint(BXLayoutConstraintMake(redPacketImgView, .centerY, .equal,self,.centerY))
            addConstraint(BXLayoutConstraintMake(redPacketImgView, .width, .equal,nil,.width,375*AUTOSIZE_X))
            addConstraint(BXLayoutConstraintMake(redPacketImgView, .height, .equal,nil,.height,500*AUTOSIZE_X))
            }())
        // openRedPacketBtn
        ({
            redPacketImgView.addConstraint(BXLayoutConstraintMake(openRedPacketBtn, .bottom, .equal,redPacketImgView,.top,291*AUTOSIZE_Y))
            redPacketImgView.addConstraint(BXLayoutConstraintMake(openRedPacketBtn, .centerX, .equal,redPacketImgView,.centerX))
            redPacketImgView.addConstraint(BXLayoutConstraintMake(openRedPacketBtn, .width, .equal,nil,.width,82.5*AUTOSIZE_X))
            redPacketImgView.addConstraint(BXLayoutConstraintMake(openRedPacketBtn, .height, .equal,nil,.height,110*AUTOSIZE_Y))
            
            }())
        
        // moneyLabel
        ({
            
            addConstraint(BXLayoutConstraintMake(moneyLabel, .centerX, .equal,self,.centerX))
            addConstraint(BXLayoutConstraintMake(moneyLabel, .bottom, .equal,redPacketImgView,.bottom,-77*AUTOSIZE_Y))
            
            }())
        
        
    }
    
    private func configMoneyLabel(string:String) {
        
        let attribute = NSMutableAttributedString(string: string)
//        let attributeDict:[String:Any] = [NSAttributedStringKey.font.rawValue:FONT_100PX,
//                                          NSAttributedStringKey.kern.rawValue:2]
        attribute.addAttributes([NSAttributedStringKey.font:FONT_100PX,
                                 NSAttributedStringKey.kern:2], range: NSRange(location: 0, length: string.count-1))
    
        moneyLabel.attributedText = attribute
        
    }
    
    func setupRedPacketGoldImgView(){
        
        addSubview(redPacketGoldImgView)
        redPacketGoldImgView.translatesAutoresizingMaskIntoConstraints = false
        redPacketGoldImgView.image = #imageLiteral(resourceName: "redPacket_gold")
        
        // addConstraint
        ({
            addConstraint(BXLayoutConstraintMake(redPacketGoldImgView, .centerX, .equal,self,.centerX))
            addConstraint(BXLayoutConstraintMake(redPacketGoldImgView, .centerY, .equal,self,.centerY))
            addConstraint(BXLayoutConstraintMake(redPacketGoldImgView, .width, .equal,nil,.width,375*AUTOSIZE_X))
            addConstraint(BXLayoutConstraintMake(redPacketGoldImgView, .height, .equal,nil,.height,500*AUTOSIZE_X))
            
            
            }())
        
        // animation
        ({
            let animation  = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 0.1
            animation.toValue = 1.0
            animation.delegate = self
            redPacketGoldImgView.layer.add(animation, forKey: nil)
            
            }())
    }
    
    func openRedPacketAction(_ btn:UIButton)  {
        guard let action = cickOpenRedPacketAction else { return  }
        action()
        openRedPacketAnimation(btn)
        
    }
    
    private func openRedPacketAnimation(_ view:UIView) {
        let animation = CAKeyframeAnimation()
        
        animation.values = [
            NSValue(caTransform3D: CATransform3DMakeRotation(0, 0, 0.5, 0)),
            NSValue(caTransform3D: CATransform3DMakeRotation(3.13, 0, 0.5, 0)),
            NSValue(caTransform3D: CATransform3DMakeRotation(6.26, 0, 0.5, 0))
        ]
        animation.isCumulative = true
        animation.duration = 1
        animation.repeatCount = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.delegate = self
        view.layer.zPosition = 50
        view.layer.add(animation, forKey: "transform")
        
    }
    func superviewRemoveFromSuperview()  {
        guard let action = removeFromSuperviewAction else { return  }
        action()
    }

    
    
}
extension LBMapRePacketView:CAAnimationDelegate{
    
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        guard flag == true else { return}
        
        if anim.isKind(of: CAKeyframeAnimation.self) {
            
            redPacketImgView.image = UIImage(named:"open_redPacket_backGroud")
            setupRedPacketGoldImgView()
            openRedPacketBtn.removeFromSuperview()
            
        }else{
            guard let action = animationCompletionHandler else{return}
            action(redPacketImgView)
        }
    }
}









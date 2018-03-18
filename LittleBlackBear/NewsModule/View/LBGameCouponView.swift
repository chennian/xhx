//
//  LBGameCouponView.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/24.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBGameCouponView: UIView {
    
    var showGameCouponDetail:(()->())?
    var showShopDeatil:(()->())?
    var model:LBGameModel?{
        didSet{
            guard model != nil else{return}
            
            shopNameLabel.text = model!.merName
            
            if model!.logo.isURLFormate(){
                shopIconImgView.kf.setImage(with: URL(string:model!.logo))
            }
            
            couponTitleLabel.text = model!.markTitle
            couponSubTitleLabel.text = model!.markSubhead
            explainLabel.text = model!.markSubhead
            markImgView.image = UIImage(named:model!.markType=="3" ?"replace_gold_coupon":"treasureBox_disCount_coupon")

        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setData()
        configAnimation()
        self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT)
        closeBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
//        shopBtn.addTarget(self, action: #selector(clickShopBtn(_ :)), for: .touchUpInside)
        couponBtn.addTarget(self, action: #selector(clickCouponBtn(_ :)), for: .touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let boxBackImgView = UIImageView()
    private let titleLabel = UILabel()
    
    private let couponBtn = UIButton()
    private let shopBtn = UIButton()
    
    private let couponDetailImgView = UIImageView()
    private let shopNameLabel = UILabel()
    private let shopIconImgView = UIImageView()
    
    private let couponTitleLabel = UILabel()
    private let couponSubTitleLabel = UILabel()
    private let explainLabel = UILabel()
    
    private let closeBtn = UIButton()
    
    private let markImgView = UIImageView()
    
    private func setupUI(){
        
        addSubview(boxBackImgView)
        addSubview(titleLabel)
        addSubview(couponBtn)
        addSubview(shopBtn)
        
        addSubview(couponDetailImgView)
        addSubview(shopNameLabel)
        addSubview(shopIconImgView)
        
        addSubview(couponTitleLabel)
        addSubview(couponSubTitleLabel)
        addSubview(explainLabel)
        
        addSubview(closeBtn)
        
        addSubview(markImgView)
        
        
        boxBackImgView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        couponBtn.translatesAutoresizingMaskIntoConstraints = false
        shopBtn.translatesAutoresizingMaskIntoConstraints = false
        
        couponDetailImgView.translatesAutoresizingMaskIntoConstraints = false
        shopNameLabel.translatesAutoresizingMaskIntoConstraints = false
        shopIconImgView.translatesAutoresizingMaskIntoConstraints = false
        
        couponTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        couponSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        explainLabel.translatesAutoresizingMaskIntoConstraints = false
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        
        markImgView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(BXLayoutConstraintMake(boxBackImgView, .centerX, .equal,self,.centerX))
        addConstraint(BXLayoutConstraintMake(boxBackImgView, .centerY, .equal,self,.centerY))
        addConstraint(BXLayoutConstraintMake(boxBackImgView, .width, .equal,nil,.width,300*AUTOSIZE_X))
        addConstraint(BXLayoutConstraintMake(boxBackImgView, .height, .equal,nil,.height,360*AUTOSIZE_Y))
        
        addConstraint(BXLayoutConstraintMake(titleLabel, .centerX, .equal,self,.centerX))
        addConstraint(BXLayoutConstraintMake(titleLabel, .top, .equal,boxBackImgView,.top,20))
        
        addConstraint(BXLayoutConstraintMake(closeBtn, .centerX, .equal,boxBackImgView,.right))
        addConstraint(BXLayoutConstraintMake(closeBtn, .centerY, .equal,boxBackImgView,.top))
        
        
        addConstraint(BXLayoutConstraintMake(shopBtn, .centerX, .equal,self,.centerX))
        addConstraint(BXLayoutConstraintMake(shopBtn, .bottom, .equal,boxBackImgView,.bottom,-25))
        
        addConstraint(BXLayoutConstraintMake(couponBtn, .centerX, .equal,self,.centerX))
        addConstraint(BXLayoutConstraintMake(couponBtn, .bottom, .equal,shopBtn,.top,-19))
        
        addConstraint(BXLayoutConstraintMake(couponDetailImgView, .centerX, .equal,self,.centerX))
        addConstraint(BXLayoutConstraintMake(couponDetailImgView, .top, .equal,boxBackImgView,.top ,50*AUTOSIZE_Y))
        addConstraint(BXLayoutConstraintMake(couponDetailImgView, .width,.equal,nil,.width,254*AUTOSIZE_X))
        addConstraint(BXLayoutConstraintMake(couponDetailImgView, .height, .equal,nil,.height,177*AUTOSIZE_Y))
        
        addConstraint(BXLayoutConstraintMake(shopNameLabel, .left, .equal,couponDetailImgView,.left,22*AUTOSIZE_X))
        addConstraint(BXLayoutConstraintMake(shopNameLabel, .top, .equal,couponDetailImgView,.top,25*AUTOSIZE_Y))
        
        addConstraint(BXLayoutConstraintMake(markImgView, .right, .equal,couponDetailImgView,.right))
        addConstraint(BXLayoutConstraintMake(markImgView, .top, .equal,couponDetailImgView,.top))
        addConstraint(BXLayoutConstraintMake(markImgView, .width, .equal,nil,.width,74*AUTOSIZE_X))
        addConstraint(BXLayoutConstraintMake(markImgView, .height, .equal,nil,.height ,74*AUTOSIZE_Y))
        
        addConstraint(BXLayoutConstraintMake(shopIconImgView, .left, .equal,couponDetailImgView,.left,22*AUTOSIZE_X))
        addConstraint(BXLayoutConstraintMake(shopIconImgView, .top, .equal,couponDetailImgView,.top,52*AUTOSIZE_Y))
        addConstraint(BXLayoutConstraintMake(shopIconImgView, .width, .equal,nil,.width,60*AUTOSIZE_X))
        addConstraint(BXLayoutConstraintMake(shopIconImgView, .height,.equal,nil,.height,60*AUTOSIZE_Y))
        
        addConstraint(BXLayoutConstraintMake(couponTitleLabel,.left, .equal,shopIconImgView,.right,22*AUTOSIZE_X))
        addConstraint(BXLayoutConstraintMake(couponTitleLabel, .top, .equal,shopIconImgView,.top))
        
        addConstraint(BXLayoutConstraintMake(couponSubTitleLabel,.top,.equal,couponTitleLabel,.bottom,5))
        addConstraint(BXLayoutConstraintMake(couponSubTitleLabel, .left, .equal,couponTitleLabel,.left))
        
        addConstraint(BXLayoutConstraintMake(explainLabel, .left, .equal,couponSubTitleLabel,.left))
        addConstraint(BXLayoutConstraintMake(explainLabel, .top, .equal,couponSubTitleLabel,.bottom,5))
        
        
    }
    
    func setData(){
        
        boxBackImgView.image = UIImage(named:"treasure_box_coupon_bgImg")
        couponDetailImgView.image = UIImage(named:"treasure_box_couponInfo_bgImg")
        
        closeBtn.setImage(UIImage(named:"x"), for: .normal)
//        shopBtn.setImage(UIImage(named:"lookUp_shop_img"), for: .normal)
        couponBtn.setImage(UIImage(named:"lookUp_coupon_detail"), for: .normal)
        
        titleLabel.font = FONT_28PX
        titleLabel.textColor = COLOR_ffffff
        
        shopIconImgView.layer.cornerRadius = 30*AUTOSIZE_X
        shopIconImgView.layer.masksToBounds = true
        shopIconImgView.backgroundColor = UIColor.arc4randomColor()
        
        couponTitleLabel.font = FONT_30PX
        couponTitleLabel.textColor = COLOR_222222
        
        couponSubTitleLabel.font = FONT_30PX
        couponSubTitleLabel.textColor = COLOR_999999
        
        explainLabel.font = FONT_30PX
        explainLabel.textColor = COLOR_999999
        
        
    }
    
    func configAnimation() {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.01
        scaleAnimation.toValue = 1.0
        self.layer.add(scaleAnimation, forKey: nil)
    }
    
    func closeAction()  {
        self.removeFromSuperview()
    }
    
    func clickShopBtn(_ button:UIButton){
        guard let action = showShopDeatil  else { return  }
        action()
    }
    
    func clickCouponBtn(_ button:UIButton){
        guard let action = showGameCouponDetail else { return  }
        action()
    }
    
}









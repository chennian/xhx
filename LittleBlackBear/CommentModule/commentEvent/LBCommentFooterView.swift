//
//  LBCommentFooterView.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/12/19.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBCommentFooterView: UIView {
    
    var images:[UIImage] = []{
        didSet{
            guard images.count > 0  else{return}
            setupImageViews(images: images)
        }
    }
    var addImageAction:((UIButton)->Void)?
    private let titleLabel = UILabel()
    private let addImageBtn = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 10, width:KSCREEN_WIDTH, height: 120)
        backgroundColor = COLOR_ffffff
        setupUI()
        addImageBtn.addTarget(self, action: #selector(addImageBtn(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI()  {
        
        addSubview(titleLabel)
        addSubview(addImageBtn)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addImageBtn.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "上传图片:最多5张"
        titleLabel.font = FONT_30PX
        titleLabel.textColor = COLOR_999999
        let attribute = NSMutableAttributedString(string: titleLabel.text!)
        attribute.addAttribute(NSForegroundColorAttributeName,
                               value:COLOR_222222 ,
                               range:NSRange(location: 0, length: 4))
        titleLabel.attributedText = attribute

        addImageBtn.setBackgroundImage(UIImage(named:"+"), for: .normal)
        
        addConstraint(BXLayoutConstraintMake(titleLabel, .top ,.equal,self,.top,18))
        addConstraint(BXLayoutConstraintMake(titleLabel, .left, .equal,self,.left,16))
        
        addConstraint(BXLayoutConstraintMake(addImageBtn, .top, .equal,titleLabel,.bottom,22))
        addConstraint(BXLayoutConstraintMake(addImageBtn, .left, .equal,titleLabel,.left))
        addConstraint(BXLayoutConstraintMake(addImageBtn, .width, .equal,nil,.width,50))
        addConstraint(BXLayoutConstraintMake(addImageBtn, .height, .equal,nil,.height,50))

        
    }
    private func setupImageViews(images:[UIImage]) {
        var imageViews = [UIImageView]()
        imageViews.removeAll()
        subviews.filter{$0.isKind(of: UIImageView.self)}.forEach{$0.removeFromSuperview()}
        for image in images {
            var toItem:UIView = addImageBtn
            
            let imgView = UIImageView()
            imgView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imgView)
            imgView.image = image
            if let nextItme = imageViews.last{
                toItem = nextItme
            }
            imageViews.append(imgView)
            addConstraint(BXLayoutConstraintMake(imgView, .left, .equal,toItem,.right,10))
            addConstraint(BXLayoutConstraintMake(imgView, .top, .equal,addImageBtn,.top))
            addConstraint(BXLayoutConstraintMake(imgView, .width, .equal,nil,.width,50))
            addConstraint(BXLayoutConstraintMake(imgView, .height, .equal,nil,.height,50))
            
        }
    }
    // MARK: event
    func addImageBtn(_ btn:UIButton) {
        guard let action = addImageAction else { return }
        action(btn)
    }
    
}









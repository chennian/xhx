//
//  LBCommentHeaderView.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/12/19.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBCommentHeaderView: UIView {
    
    var selectCompletHandler:((Int)->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 60)
        backgroundColor = COLOR_ffffff
        setupUI()
      
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let label = UILabel()
    private let startView  = LBStartLevelView()
    func setupUI()  {
        
        addSubview(label)
        addSubview(startView)
        label.translatesAutoresizingMaskIntoConstraints = false
        startView.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "评价 :"
        label.textColor = COLOR_222222
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        startView.spacing = 6
        startView.startCount = 0
        startView.selectCompletHandler = {[weak self] (count) in
            guard let strongSelf = self else { return }
            guard let action = strongSelf.selectCompletHandler else { return}
            action(count)
            Print("评分\(count)星")
        }
        
        addConstraint(BXLayoutConstraintMake(label, .left, .equal,self,.left,16))
        addConstraint(BXLayoutConstraintMake(label, .centerY, .equal,self,.centerY))

        addConstraint(BXLayoutConstraintMake(startView, .left, .equal,label,.right,10))
        addConstraint(BXLayoutConstraintMake(startView, .centerY, .equal,self,.centerY))
        addConstraint(BXLayoutConstraintMake(startView, .width, .equal,nil,.width,120*AUTOSIZE_X))
        addConstraint(BXLayoutConstraintMake(startView, .height, .equal,nil,.height,30))
    }
  
}







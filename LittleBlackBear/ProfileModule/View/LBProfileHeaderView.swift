//
//  LBProfileHeaderView.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/5.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBProfileHeaderView: UIView {
    
    var uploadIconImageAction:((_ imageView:UIImageView)->())?
    
    var isRefreshData:Bool?{
        didSet{
            
            guard isRefreshData == true else {return}
            ismerc = LBKeychain.get(isMer)
            isAgent = LBKeychain.get(IsAgent)
            userName  = LBKeychain.get(nickName)
            headerUrl = LBKeychain.get(USER_ICON_URL)
            level = LBKeychain.get(AGENT_LEVEL)
            setupUI()
            setupData()
            
        }
    }
    
    private var ismerc = ""
    private var isAgent = ""
    private var userName  = ""
//    private var headerUrl = ""
    public var headerUrl = ""
    private var level = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 110)
        backgroundColor = UIColor.white
        iconImageView.isUserInteractionEnabled = true
        iconImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectorImageAction)))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let iconImageView  = UIImageView()
    private let nameLabel = UILabel()
    private let levelLabel = UILabel()
    
    private func setupUI()  {
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.layer.cornerRadius = 30
        iconImageView.layer.masksToBounds = true
        
        
        nameLabel.font = FONT_28PX
        nameLabel.textColor = COLOR_222222
        
        levelLabel.font = FONT_26PX
        levelLabel.textColor = UIColor.white
        levelLabel.backgroundColor = COLOR_e60013
        
        addSubview(iconImageView)
        addSubview(nameLabel)
        addSubview(levelLabel)
        
        addConstraint(BXLayoutConstraintMake(iconImageView, .left, .equal,self,.left,30))
        addConstraint(BXLayoutConstraintMake(iconImageView, .centerY, .equal,self,.centerY))
        addConstraint(BXLayoutConstraintMake(iconImageView, .width, .equal,nil,.width,60))
        addConstraint(BXLayoutConstraintMake(iconImageView, .height,.equal,nil,.height,60))
        
        addConstraint(BXLayoutConstraintMake(nameLabel, .centerY, .equal,iconImageView,.centerY))
        addConstraint(BXLayoutConstraintMake(nameLabel, .left, .equal,iconImageView,.right,10))
        
        addConstraint(BXLayoutConstraintMake(levelLabel, .left, .equal,nameLabel,.right,10))
        addConstraint(BXLayoutConstraintMake(levelLabel, .centerY, .equal,nameLabel,.centerY))
        
        guard ismerc == "1" else {return}
        
        var levels = ["alipay","WeChat"]
        if ismerc == "1",isAgent == "0" {
            levels.append("merchantIcon")
        }
        if ismerc == "1",isAgent != "0" {
            levels.append("merchantIcon")
            levels.append("standForIcon")
        }
        
        // levelIconImgView
        ({
            var imgeviews = [UIImageView]()
            for imgName in levels {
                let statusImgView = UIImageView()
                statusImgView.translatesAutoresizingMaskIntoConstraints = false
                addSubview(statusImgView)
                
                var statusImgViewToItem:UIView = levelLabel
                if let toItem = imgeviews.last{
                    statusImgViewToItem = toItem
                }
                statusImgView.image = UIImage(named:imgName)
                imgeviews.append(statusImgView)
                addConstraint(BXLayoutConstraintMake(statusImgView, .left, .equal,statusImgViewToItem,.right,10))
                addConstraint(BXLayoutConstraintMake(statusImgView, .centerY,  .equal,levelLabel,.centerY))
                addConstraint(BXLayoutConstraintMake(statusImgView, .width, .equal,nil,.width,22*AUTOSIZE_X))
                addConstraint(BXLayoutConstraintMake(statusImgView, .height, .equal,nil,.height,22*AUTOSIZE_Y))
                
            }
            }())
    }
    
    private func setupData(){
        
        if headerUrl.isURLFormate() {
            iconImageView.kf.setImage(with: URL(string:headerUrl))
        }else{
            iconImageView.image = UIImage(named:"userIcon")
        }
        
        nameLabel.text = userName
        
        if ismerc == "0"{
            levelLabel.text = " 普通用户 "
        }
        
        if ismerc == "1",isAgent == "0" {
            levelLabel.text = " 商户 "
        }
        
        if  ismerc == "1",isAgent != "0" {
            switch isAgent {
            case "1":
                levelLabel.text = " 服务商 "
            case "2":
                levelLabel.text = " 运营商 "
            case "3":
                levelLabel.text = " 子公司 "
            default:
                break
            }
        }
    }
    
    func selectorImageAction()  {
        guard let action = uploadIconImageAction else { return  }
        action(iconImageView)
        
    }
    
}











//
//  LBAddGroupCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/17.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBAddGroupCell:SNBaseTableViewCell  {
    
    private let titleLable = UILabel().then{
        $0.text = "标题"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var titleTextField = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder = "请输入卡卷标题"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)

    }
    
    private let priceLable = UILabel().then{
        $0.text = "价格"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var priceTextField = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder = "请输入价格"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    private let numLable = UILabel().then{
        $0.text = "人数"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    var numTextField = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder = "请输入成团人数"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    private let activityLable = UILabel().then{
        $0.text = "活动展示图"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var activityImge = UIImageView().then{
        $0.backgroundColor = UIColor.red
    }
    
    private let showLable = UILabel().then{
        $0.text = "详情展示图"
    }
    var showImge1 = UIImageView().then{
        $0.backgroundColor = UIColor.red
    }
    var showImge2 = UIImageView().then{
        $0.backgroundColor = UIColor.red
    }
    var showImge3 = UIImageView().then{
        $0.backgroundColor = UIColor.red
    }
    private let descriptionLabel = UILabel().then{
        $0.text = "卡劵描述"
    }
    var descriptionText = UITextView().then{
        $0.layer.borderWidth = fit(1)
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    var submitButton = UIButton().then{
        $0.setTitle("提交", for: UIControlState.normal)
        $0.setTitleColor(UIColor.red, for: .normal)
    }
    
    override func setupView() {
        
        contentView.addSubview(titleLable)
        contentView.addSubview(titleTextField)
        contentView.addSubview(priceLable)
        contentView.addSubview(priceTextField)
        contentView.addSubview(numLable)
        contentView.addSubview(numTextField)
        contentView.addSubview(activityLable)
        contentView.addSubview(activityImge)
        contentView.addSubview(showLable)
        contentView.addSubview(showImge1)
        contentView.addSubview(showImge2)
        contentView.addSubview(showImge3)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(descriptionText)
        contentView.addSubview(submitButton)
        
        titleLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.equalToSuperview().snOffset(20)
            make.width.equalTo(fit(120))
        }
        
        titleTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(titleLable.snp.right).offset(10)
            make.centerY.equalTo(titleLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
        priceLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.snEqualTo(titleLable.snp.bottom).offset(20)
            make.width.equalTo(fit(120))
            
        }
        priceTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(priceLable.snp.right).offset(10)
            make.centerY.equalTo(priceLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
        numLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.snEqualTo(priceTextField.snp.bottom).offset(20)
            make.width.equalTo(fit(120))
            
        }
        
        numTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(numLable.snp.right).offset(10)
            make.centerY.equalTo(numLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
        activityLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.snEqualTo(numLable.snp.bottom).offset(20)
            make.width.equalTo(fit(160))
        }

        activityImge.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.snEqualTo(activityLable.snp.bottom).offset(10)
            make.width.snEqualTo(180)
            make.height.snEqualTo(220)
        }
        showLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.snEqualTo(activityImge.snp.bottom).offset(20)
            make.width.equalTo(fit(160))
        }
        showImge1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.snEqualTo(showLable.snp.bottom).offset(10)
            make.width.snEqualTo(180)
            make.height.snEqualTo(180)
        }
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.snEqualTo(showImge1.snp.bottom).offset(20)
            make.width.equalTo(fit(160))
        }
        descriptionText.snp.makeConstraints { (make) in
            make.left.snEqualToSuperview().offset(20)
            make.right.snEqualToSuperview().offset(-20)
            make.top.equalTo(descriptionLabel.snp.bottom).snOffset(10)
            make.height.snEqualTo(200)
        }
        submitButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.snEqualTo(descriptionText.snp.bottom).offset(10)
            make.width.snEqualTo(140)
            make.height.snEqualTo(50)
        }
    }
}


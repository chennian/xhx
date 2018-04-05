//
//  LBMerchantAppleFieldCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/4/4.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBMerchantAppleFieldCell: SNBaseTableViewCell {
    private let line1 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private let line2 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private let line3 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private let line4 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private let line5 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    private let line6 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }

    var merhead = UILabel().then{
        $0.text = "店铺名称"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    
    var titleTextField = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder = "请输入店铺名称"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    
    private let priceLable = UILabel().then{
        $0.text = "商家简称"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    
    var priceTextField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "小黑熊网络"
        
    }
    
    private let countLable = UILabel().then{
        $0.text = "负责人姓名"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    
    var countTextField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "李正榜"
    }
    
    private let numLable = UILabel().then{
        $0.text = "店铺手机号"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    var numTextField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "13730880500"
    }
    private let idCard = UILabel().then{
        $0.text = "身份证号"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    var idCardTextField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "42011720029392328273728"
    }
    
    private let email = UILabel().then{
        $0.text = "邮箱地址"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    var emailTextField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "617355623@qq.com"
    }
    
    override func setupView() {
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        contentView.addSubview(line3)
        contentView.addSubview(line4)
        contentView.addSubview(line5)
        contentView.addSubview(line6)

        
        
        contentView.addSubview(merhead)
        contentView.addSubview(titleTextField)
        contentView.addSubview(priceLable)
        contentView.addSubview(priceTextField)
        contentView.addSubview(numLable)
        contentView.addSubview(numTextField)
        contentView.addSubview(countLable)
        contentView.addSubview(countTextField)
        contentView.addSubview(idCard)
        contentView.addSubview(idCardTextField)
        contentView.addSubview(email)
        contentView.addSubview(emailTextField)

        
        line1.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalToSuperview().snOffset(90)
        }
        line2.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line1.snp.bottom).snOffset(90)
        }
        line3.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line2.snp.bottom).snOffset(90)
        }
        line4.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line3.snp.bottom).snOffset(90)
        }
        line5.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line4.snp.bottom).snOffset(90)
        }
        line6.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line5.snp.bottom).snOffset(90)
        }
        merhead.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(35)
            make.width.equalTo(fit(150))
        }
        
        titleTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(merhead.snp.right).offset(10)
            make.centerY.equalTo(merhead.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
        priceLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line1.snp.bottom).snOffset(32)
            make.width.equalTo(fit(150))
        }
        priceTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(priceLable.snp.right).offset(10)
            make.centerY.equalTo(priceLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
        countLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.snEqualTo(line2.snp.bottom).snOffset(32)
            make.width.equalTo(fit(150))
            
        }
        countTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(countLable.snp.right).offset(10)
            make.centerY.equalTo(countLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        numLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.snEqualTo(line3.snp.bottom).snOffset(32)
            make.width.equalTo(fit(150))
            
        }

        numTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(numLable.snp.right).offset(10)
            make.centerY.equalTo(numLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        idCard.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.snEqualTo(line4.snp.bottom).snOffset(32)
            make.width.equalTo(fit(150))
            
        }
        
        idCardTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(idCard.snp.right).offset(10)
            make.centerY.equalTo(idCard.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        email.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.snEqualTo(line5.snp.bottom).snOffset(32)
            make.width.equalTo(fit(150))
            
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(email.snp.right).offset(10)
            make.centerY.equalTo(email.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }

    }
}

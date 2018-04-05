//
//  LBMerchantTextFileCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/4/3.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import APJTextPickerView

class LBMerchantTextFileCell: SNBaseTableViewCell {
    
    fileprivate var type = ["美食", "丽人", "生活服务", "KTV", "酒店", "休闲娱乐","电影", "运动", "购物", "亲子", "家居", "摄影","保健", "丽人", "医疗", "游泳馆", "周边游", "蛋糕","汽车", "学习培训", "酒吧"]
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
    private let line7 = UIView().then{
        $0.backgroundColor = Color(0xe8e8e8)
    }
    var merhead = UILabel().then{
        $0.text = "商家头像"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    
    var titleTextField = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder = "请输入卡卷标题"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    
    private let priceLable = UILabel().then{
        $0.text = "商家名称"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    
    var priceTextField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "四川小黑熊网络科技有限责任公司"
        
    }
    
    private let countLable = UILabel().then{
        $0.text = "商家简称"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    
    var countTextField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "小黑熊网络"
    }
    

    
    private let numLable = UILabel().then{
        $0.text = "商家电话"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    var numTextField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "13730880500"
        
    }
    
    private let merDescription = UILabel().then{
        $0.text = "商家介绍"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    var merTextView = SLTextView().then{
        $0.layer.style = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "商家介绍"
        $0.placeholderColor = Color(0xcbcbcb)
    }
    
    private let merNotice = UILabel().then{
        $0.text = "顾客须知"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    var merNoticeTextView = SLTextView().then{
        $0.layer.style = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "顾客须知"
        $0.placeholderColor = Color(0xcbcbcb)
        
    }
    
    private let merLable = UILabel().then{
        $0.text = "商家标签"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    var merLableTextField = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "共享万千商家流量"
        
    }
    
    private let merType = UILabel().then{
        $0.text = "商家类型"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }

    var merTypeTextField = APJTextPickerView().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请选择秒商家类型"
        $0.type = .strings
    }
    override func setupView() {
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        contentView.addSubview(line3)
        contentView.addSubview(line4)
        contentView.addSubview(line5)
        contentView.addSubview(line6)
        contentView.addSubview(line7)


        contentView.addSubview(merhead)
        contentView.addSubview(titleTextField)
        contentView.addSubview(priceLable)
        contentView.addSubview(priceTextField)
        contentView.addSubview(numLable)
        contentView.addSubview(numTextField)
        contentView.addSubview(countLable)
        contentView.addSubview(countTextField)
        contentView.addSubview(merDescription)
        contentView.addSubview(merTextView)
        contentView.addSubview(merNotice)
        contentView.addSubview(merNoticeTextView)
        contentView.addSubview(merLable)
        contentView.addSubview(merLableTextField)
        contentView.addSubview(merType)
        contentView.addSubview(merTypeTextField)


        
        merTypeTextField.pickerDelegate = self
        merTypeTextField.dataSource = self
        
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
            make.top.equalTo(line4.snp.bottom).snOffset(200)
        }
        line6.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line5.snp.bottom).snOffset(200)
        }
        line7.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalTo(line6.snp.bottom).snOffset(90)
        }
        
        merhead.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(35)
            make.width.equalTo(fit(120))
        }
        
        titleTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(merhead.snp.right).offset(10)
            make.centerY.equalTo(merhead.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
        priceLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(line1.snp.bottom).snOffset(32)
            make.width.equalTo(fit(120))
        }
        priceTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(priceLable.snp.right).offset(10)
            make.centerY.equalTo(priceLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
        countLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.snEqualTo(line2.snp.bottom).snOffset(32)
            make.width.equalTo(fit(120))
            
        }
        countTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(countLable.snp.right).offset(10)
            make.centerY.equalTo(countLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        numLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.snEqualTo(line3.snp.bottom).snOffset(32)
            make.width.equalTo(fit(120))
            
        }
        
        numTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(numLable.snp.right).offset(10)
            make.centerY.equalTo(numLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        merDescription.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.snEqualTo(line4.snp.bottom).snOffset(32)
            make.width.equalTo(fit(120))
            
        }
        
        merTextView.snp.makeConstraints { (make) in
            make.left.snEqualTo(numLable.snp.right).offset(10)
            make.right.equalToSuperview().offset(fit(-100))
            make.top.equalTo(merDescription.snp.top).snOffset(-15)
            make.height.snEqualTo(100)
        }
        
        merNotice.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.snEqualTo(line5.snp.bottom).snOffset(32)
            make.width.equalTo(fit(120))
            
        }
        merNoticeTextView.snp.makeConstraints { (make) in
            make.left.snEqualTo(numLable.snp.right).offset(10)
            make.right.equalToSuperview().offset(fit(-100))
            make.top.equalTo(merNotice.snp.top).snOffset(-15)
            make.height.snEqualTo(100)
        }
        
        merLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.snEqualTo(line6.snp.bottom).snOffset(32)
            make.width.equalTo(fit(120))
        }
        merLableTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(merLable.snp.right).offset(10)
            make.centerY.equalTo(merLable.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
        
        merType.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.snEqualTo(line7.snp.bottom).snOffset(32)
            make.width.equalTo(fit(120))
        }
        merTypeTextField.snp.makeConstraints { (make) in
            make.left.snEqualTo(merType.snp.right).offset(10)
            make.centerY.equalTo(merType.snp.centerY)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
    }

}

extension  LBMerchantTextFileCell:APJTextPickerViewDelegate,APJTextPickerViewDataSource{
    func textPickerView(_ textPickerView: APJTextPickerView, titleForRow row: Int) -> String? {
        return type[row]
    }
    func numberOfRows(in pickerView: APJTextPickerView) -> Int {
        return type.count
    }
}


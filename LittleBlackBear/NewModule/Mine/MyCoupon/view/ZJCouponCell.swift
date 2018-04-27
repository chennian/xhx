//
//  ZJCouponCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 26/4/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import SwiftyJSON
class ZJCouponCellModel : SNSwiftyJSONAble{
//    var va : Bool = false
    
    /*
     "shopName": "从前音乐餐厅",
     "name": "2-3人从前音乐餐厅套餐",
     "endTime": "2018-04-26",
     "terminaltime": "2018-07-26 00:00:00",
     "status": "2"
     */
    
    var shopName : String
    var name : String
    var endTime : String
    var terminaltime : String
    var status : String
    var verfifyCode : String
    
    required init?(jsonData: JSON) {
        self.shopName = jsonData["shopName"].stringValue
        self.name = jsonData["name"].stringValue
        self.endTime = jsonData["endTime"].stringValue
        self.terminaltime = jsonData["terminaltime"].stringValue
        self.status = jsonData["status"].stringValue
        self.verfifyCode = jsonData["verfifyCode"].stringValue
    }
}


class ZJCouponCell: SNBaseTableViewCell {

    
    //1 使用过
    var model : ZJCouponCellModel?{
        didSet{
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            guard let date = formatter.date(from: model!.terminaltime) else{
                return
            }
            
            if model!.status == "1"{
                checkBtn.isHidden = true
                backgroudImg.image = UIImage(named:"have_been_used")
            }else if date < Date(){
                checkBtn.isHidden = true
                backgroudImg.image = UIImage(named:"past_due")
            }else{
                checkBtn.isHidden = false
                backgroudImg.image = UIImage(named:"ticket")
            }
 
            nameLab.text = model!.shopName
            subNameLab.text = "商品名称：" + model!.name
            dateLab.text = "有效期至：" + model!.terminaltime

        }
    }
    let backgroudImg = UIImageView().then({
        $0.contentMode = .center
    })
    
    let nameLab = UILabel().then({
        $0.textColor = .white
        $0.font = BoldFont(32)//Font(32)
    })
    let subNameLab = UILabel().then({
        $0.textColor = .white
        $0.font = Font(24)
    })
    let dateLab = UILabel().then({
        $0.textColor = .white
        $0.font = Font(24)
    })
    let checkBtn = UIButton().then({
        $0.setTitle("查看", for: .normal)
        $0.titleLabel?.font = Font(32)
        $0.layer.cornerRadius = fit(33)
        $0.layer.borderWidth = fit(1.5)
        $0.layer.borderColor = UIColor.white.cgColor
    })
    
    override func setupView() {
        line.isHidden = true
        contentView.addSubview(backgroudImg)
        contentView.addSubview(nameLab)
        contentView.addSubview(subNameLab)
        contentView.addSubview(dateLab)
        contentView.addSubview(checkBtn)
        backgroudImg.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.snEqualTo(62)
            make.top.snEqualTo(backgroudImg).snOffset(39)
        }
        dateLab.snp.makeConstraints { (make) in
            make.left.snEqualTo(nameLab)
            make.bottom.snEqualTo(backgroudImg).snOffset(-56)
        }
        subNameLab.snp.makeConstraints { (make) in
            make.left.snEqualTo(nameLab)
            make.top.snEqualTo(nameLab.snp.bottom).snOffset(25)
        }
        checkBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(backgroudImg)
            make.width.snEqualTo(120)
            make.height.snEqualTo(66)
            make.right.snEqualToSuperview().snOffset(-80)
        }
        
    }

}

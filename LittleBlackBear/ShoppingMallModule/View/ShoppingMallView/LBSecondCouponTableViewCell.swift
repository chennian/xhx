//
//  LBSecondCouponTableViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/10.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBSecondCouponTableViewCell: SNBaseTableViewCell {
    
    var secondCouponModel:LBMerMarkListModel?{
        didSet{
            guard secondCouponModel != nil else{return}
            let model = secondCouponModel
            if model!.mainImgUrl.count > 0,model!.mainImgUrl.isURLFormate() {
                imgView.kf.setImage(with: URL(string: model!.mainImgUrl))
            }
            couponTitleLabel.text = model!.markTitle
//            subCouponTitleLabel.text = model!.markSubhead
//            calculationCurrentTime(model!.validEndDate)
        }
    }

    var groupCouponModel:LBGroupMmerMarkList?{
        
        didSet{
            guard groupCouponModel != nil else{return}
            let model = groupCouponModel
            if model!.mainImgUrl.count > 0,model!.mainImgUrl.isURLFormate() {
                imgView.kf.setImage(with: URL(string: model!.mainImgUrl))
            }
            couponTitleLabel.text = model!.markTitle
//            subCouponTitleLabel.text = model!.markSubhead
//            calculationCurrentTime(model!.validEndDate + " " + "23:59:59")
            finshed.text = "已拼32人"
            kajuanView.text = "50元"
            nameBtn.setTitle(model!.merShortName, for: .disabled)
            coutDownView.setRemainTime(endTime: model!.validEndDate + " " + "23:59:59")
        }
    }
    
//    var timeText:String = ""{
//        didSet{
//            timeLabel.text = timeText
//        }
//    }
    

    
    private let nameBtn = UIButton().then{
        $0.setImage(UIImage(named : "home_store"), for: .disabled)
        $0.titleLabel?.font = Font(24)
        $0.setTitleColor(Color(0x8f8f8f), for: .disabled)
        $0.isEnabled = false
    } // 店铺名称
    private let imgView = UIImageView()//主图
    
    private let couponTitleLabel = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }// 卡券标题
    //home_ticket2
    private let kajuanView = ZJKaJuanView()
    
    private let finshed = UILabel().then{
        $0.text = "已拼23人"
        $0.textColor = Color(0xa3a3a3)
        $0.font = Font(22)
        $0.textAlignment = .center
        $0.backgroundColor = Color(0xe2e2e2)
    }
    
    let coutDownView = ZJCountDownView.size(width: 40, height: 36, fontSize: fit(24))

    override func setupView() {
        
        contentView.addSubview(nameBtn)
        contentView.addSubview(imgView)
//        contentView.addSubview(timeLabel)
        contentView.addSubview(couponTitleLabel)
//        contentView.addSubview(subCouponTitleLabel)
        contentView.addSubview(kajuanView)
        contentView.addSubview(finshed)
        contentView.addSubview(coutDownView)
        imgView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.snEqualTo(30)
            make.width.snEqualTo(710)
            make.height.snEqualTo(234)
        }
        couponTitleLabel.snp.makeConstraints { (make) in
            make.left.snEqualTo(24)
            make.top.equalTo(imgView.snp.bottom).snOffset(22)
        }
        nameBtn.snp.makeConstraints { (make) in
            make.left.equalTo(couponTitleLabel)
            make.top.equalTo(couponTitleLabel.snp.bottom).snOffset(8)
        }
        kajuanView.snp.makeConstraints { (make) in
            make.left.equalTo(couponTitleLabel)
            make.top.equalTo(nameBtn.snp.bottom).snOffset(20)
            make.height.snEqualTo(32)
            make.width.snEqualTo(106)
        }
        finshed.snp.makeConstraints { (make) in
            make.width.snEqualTo(118)
            make.height.snEqualTo(32)
            make.right.equalTo(imgView)
            make.bottom.equalTo(kajuanView)
        }
        coutDownView.snp.makeConstraints { (make) in
            make.left.equalTo(imgView)
            make.width.equalTo(imgView).multipliedBy(0.5)
            make.top.equalTo(imgView)
            make.height.snEqualTo(54)
        }
    }
    
//    func calculationCurrentTime(_ endTime:String){
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let endDate = dateFormatter.date(from: endTime)
//        let dateNow = Date()
//        guard endDate != nil else {return}
//
//        let compas = Calendar.current.dateComponents([.day,.hour,.minute,.second], from: dateNow, to: endDate!)
//        let day = compas.day ?? 0
//        let hour = compas.hour ?? 0
//        let minute = compas.minute ?? 0
//        let second = compas.second ?? 0
//
//        if day <= 0, hour <= 0, minute <= 0, second <= 0{
//             timeLabel.text = "活动已经结束"
//        }else{
//            timeLabel.text = "活动倒计时:\(day)天\(hour)时\(minute)分\(second)秒"
//        }
//
//    }
    
}




class ZJKaJuanView : SNBaseView{
    var text: String = "" {
        didSet{
            contentBtn.setTitle(text, for: .disabled)
        }
    }
    let basicTitle = UIButton().then{
        $0.titleLabel?.font = Font(22)
        $0.setTitleColor(.white, for: .disabled)//.textColor = .white
        $0.setTitle("券", for: .disabled)
        $0.setBackgroundImage(UIImage(named:"home_ticket1"), for: .disabled)
        $0.isEnabled = false
        $0.backgroundColor = Color(0xff3646)
    }
    let contentBtn = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "home_ticket2"), for: .disabled)
        $0.titleLabel?.font = Font(22)
        $0.isEnabled = false
        $0.setTitleColor(Color(0xff2e3e), for: .disabled)
        $0.titleEdgeInsets = UIEdgeInsetsMake(0, -fit(2), 0, 0)
    }
    override func setupView() {
        addSubview(basicTitle)
        addSubview(contentBtn)
        basicTitle.snp.makeConstraints { (make) in
            make.width.snEqualTo(40)
            make.height.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
        contentBtn.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.left.equalTo(basicTitle.snp.right)
            make.centerY.equalToSuperview()
            make.width.snEqualTo(65)
        }
    }
}











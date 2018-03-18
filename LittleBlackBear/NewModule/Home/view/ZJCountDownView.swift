//
//  ZJCountDownView.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJCountDownView: SNBaseView {
    
    static func size(width : CGFloat,height : CGFloat,fontSize : CGFloat) ->ZJCountDownView{
        let view = ZJCountDownView()
        view.pointWidth = width
        view.pointHeight = height
        view.pointFont = fontSize
        view.setView()
//        view.backgroundColor = .black
        return view
    }
    private var pointWidth : CGFloat = 0.0
    private var pointHeight : CGFloat = 0.0
    private var pointFont : CGFloat = 0.0
    let title = UILabel().then{
        $0.text = "倒计时"
        $0.textColor = Color(0x151515)
        $0.font = Font(24)
    }
    let dayLab = UILabel().then{
        $0.font = Font(24)
        $0.textColor = .white
        $0.backgroundColor = Color(0x4d4d4d)
        $0.layer.cornerRadius = fit(6)
        $0.textAlignment = .center
        $0.clipsToBounds = true
    }
    let daySby = UILabel().then{
        $0.font = Font(24)
        $0.textColor = Color(0x4d4d4d)
        $0.text = ":"
        $0.textAlignment = .center
    }
    let hourLab = UILabel().then{
        $0.font = Font(24)
        $0.textColor = .white
        $0.backgroundColor = Color(0x4d4d4d)
        $0.layer.cornerRadius = fit(6)
        $0.textAlignment = .center
        $0.clipsToBounds = true
    }
    let HourSby = UILabel().then{
        $0.font = Font(24)
        $0.textColor = Color(0x4d4d4d)
        $0.text = ":"
        $0.textAlignment = .center
    }
    let minuteLab = UILabel().then{
        $0.font = Font(24)
        $0.textColor = .white
        $0.backgroundColor = Color(0x4d4d4d)
        $0.layer.cornerRadius = fit(6)
        $0.textAlignment = .center
        $0.clipsToBounds = true
    }
    let MinuteSby = UILabel().then{
        $0.font = Font(24)
        $0.textColor = Color(0x4d4d4d)
        $0.text = ":"
        $0.textAlignment = .center
    }
    let secondLab = UILabel().then{
        $0.font = Font(24)
        $0.textColor = .white
        $0.backgroundColor = Color(0xff3646)
        $0.layer.cornerRadius = fit(6)
        $0.textAlignment = .center
        $0.clipsToBounds = true
    }
    fileprivate var disPlayLink:CADisplayLink?
    deinit {
        
    }
    
    private var endTime : String = ""
    
    func setRemainTime(endTime:String){
        
        self.endTime = endTime
        disPlayLink = CADisplayLink(target: self,selector: #selector(calculateTIme))
                disPlayLink!.add(to: RunLoop.current, forMode:.commonModes)
        
                disPlayLink!.isPaused = false
        
        
    }
    
    func calculateTIme(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let endDateOp = dateFormatter.date(from: endTime)
        let dateNow = Date()
        guard let endDate = endDateOp else {return}
        
        let compas = Calendar.current.dateComponents([.day,.hour,.minute,.second], from: dateNow, to: endDate)
        let day = compas.day ?? 0
        let hour = compas.hour ?? 0
        let minute = compas.minute ?? 0
        let second = compas.second ?? 0
        
        if day <= 0, hour <= 0, minute <= 0, second <= 0{
            //             timeLabel.text = "活动已经结束"
            dayLab.text = "00"
            hourLab.text = "00"
            minuteLab.text = "00"
            secondLab.text = "00"
        }else{
            dayLab.text = String(format: "%02d", day)//"88"
            hourLab.text = String(format: "%02d", hour)
            minuteLab.text = String(format: "%02d", minute)
            secondLab.text = String(format: "%02d", second)
        }
    }
    
    func setView() {
        title.font =  UIFont.systemFont(ofSize: pointFont)
        hourLab.font =  UIFont.systemFont(ofSize: pointFont)
        HourSby.font =  UIFont.systemFont(ofSize: pointFont)
        minuteLab.font =  UIFont.systemFont(ofSize: pointFont)
        MinuteSby.font =  UIFont.systemFont(ofSize: pointFont)
        dayLab.font =  UIFont.systemFont(ofSize: pointFont)
        daySby.font =  UIFont.systemFont(ofSize: pointFont)
        secondLab.font =  UIFont.systemFont(ofSize: pointFont)
//        setRemainTime()
        addSubview(title)
        addSubview(hourLab)
        addSubview(HourSby)
        addSubview(minuteLab)
        addSubview(MinuteSby)
        addSubview(dayLab)
        addSubview(daySby)
        addSubview(secondLab)
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.88)
        
        title.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.snEqualTo(pointHeight)
        }
        dayLab.snp.makeConstraints { (make) in
            make.width.snEqualTo(pointWidth)
            make.height.snEqualTo(pointHeight)
            make.centerY.equalToSuperview()
            make.left.snEqualTo(115)
        }
        daySby.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.snEqualTo(dayLab.snp.right).snOffset(5)
        }
        hourLab.snp.makeConstraints { (make) in
            make.width.snEqualTo(pointWidth)
            make.height.snEqualTo(pointHeight)
            make.centerY.equalToSuperview()
            make.left.snEqualTo(daySby.snp.right).snOffset(5)
        }
        HourSby.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.snEqualTo(hourLab.snp.right).snOffset(5)
        }
        minuteLab.snp.makeConstraints { (make) in
            make.width.snEqualTo(pointWidth)
            make.height.snEqualTo(pointHeight)
            make.centerY.equalToSuperview()
            make.left.snEqualTo(HourSby.snp.right).snOffset(5)
        }
        MinuteSby.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.snEqualTo(minuteLab.snp.right).snOffset(5)
        }
        secondLab.snp.makeConstraints { (make) in
            make.width.snEqualTo(pointWidth)
            make.height.snEqualTo(pointHeight)
            make.centerY.equalToSuperview()
            make.left.snEqualTo(MinuteSby.snp.right).snOffset(5)
        }
    }

}

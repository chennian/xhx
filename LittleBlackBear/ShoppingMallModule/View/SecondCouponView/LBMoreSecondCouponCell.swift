//
//  LBMoreSecondCouponCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/10.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBMoreSecondCouponCell: UITableViewCell {
    
   
    var getCouponAction:((UIButton,String)->())?
    var markId:String = ""
    var secondModel:LBMerMarkListModel?{
        didSet{
            guard secondModel != nil else{return}
            let model = secondModel
            if model!.mainImgUrl.count > 0,model!.mainImgUrl.isURLFormate() {
                mercImgView.kf.setImage(with: URL(string:model!.mainImgUrl))
            }
            couponTitleLabel.text = model!.markTitle
            subCouponLabel.text = model!.markSubhead
            detailCouponLabel.text = model!.markExplain
            couponTypeLabel.text = model!.markType
            markId = model!.id
            calculationCurrentTime(model!.validEndDate)
            
        }
    }
    
    var groupModel:LBGroupMmerMarkList?{
        didSet{
            guard groupModel != nil else{return}
            let model = groupModel
            if model!.mainImgUrl.count > 0,model!.mainImgUrl.isURLFormate() {
                mercImgView.kf.setImage(with: URL(string:model!.mainImgUrl))
            }
            couponTitleLabel.text = model!.markTitle
            subCouponLabel.text = model!.markSubhead
            detailCouponLabel.text = model!.markExplain
            couponTypeLabel.text = model!.markType
            markId = model!.id
            calculationCurrentTime(model!.validEndDate)
        }
    }
    
    var buttonTag:Int?{
        didSet{
            guard buttonTag != nil else{return}
            button.tag = buttonTag!
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        button.addTarget(self , action: #selector(getCouponAction(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private let timeLabel = UILabel()
    private let couponTypeLabel = UILabel()
    private let mercImgView = UIImageView()
    private let couponTitleLabel = UILabel()
    private let subCouponLabel = UILabel()
    private let detailCouponLabel = UILabel()
    private let button = UIButton()
    
    private func setupUI() {
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(couponTypeLabel)
        contentView.addSubview(mercImgView)
        contentView.addSubview(couponTitleLabel)
        contentView.addSubview(subCouponLabel)
        contentView.addSubview(detailCouponLabel)
        contentView.addSubview(button)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        couponTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        mercImgView.translatesAutoresizingMaskIntoConstraints = false
        couponTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subCouponLabel.translatesAutoresizingMaskIntoConstraints = false
        detailCouponLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        timeLabel.font = FONT_30PX
        timeLabel.textColor = COLOR_e60013
        
        couponTypeLabel.font = FONT_30PX
        couponTypeLabel.textColor = COLOR_ffffff
        couponTypeLabel.backgroundColor = COLOR_e60013
        couponTypeLabel.layer.cornerRadius = 10
        couponTypeLabel.layer.masksToBounds = true
        couponTypeLabel.textAlignment = .center
        
        couponTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        couponTitleLabel.textColor = COLOR_222222
        
        subCouponLabel.font = UIFont.boldSystemFont(ofSize: 15)
        subCouponLabel.textColor = COLOR_999999
        
        detailCouponLabel.font = FONT_28PX
        detailCouponLabel.textColor = COLOR_999999
        
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.titleLabel?.font = FONT_32PX
        button.setTitleColor(COLOR_ffffff, for: .normal)
        button.setTitleColor(COLOR_ffffff, for: .selected)
        button.setBackgroundImage(UIImage.imageWithColor(COLOR_c22f4a), for: .normal)
//        button.setBackgroundImage(UIImage.imageWithColor(COLOR_bebebe), for: .selected)
        button.setTitle("立即抢券", for: .normal)
//        button.setTitle("已领取", for: .selected)
        
        
        contentView.addConstraint(BXLayoutConstraintMake(timeLabel, .left, .equal,contentView,.left,13))
        contentView.addConstraint(BXLayoutConstraintMake(timeLabel, .top, .equal,contentView,.top,25))
        
        contentView.addConstraint(BXLayoutConstraintMake(couponTypeLabel,.right,.equal,contentView,.right,-12))
        contentView.addConstraint(BXLayoutConstraintMake(couponTypeLabel, .top, .equal,contentView,.top,25))
        contentView.addConstraint(BXLayoutConstraintMake(couponTypeLabel, .height, .equal,nil,.height,25))
        contentView.addConstraint(BXLayoutConstraintMake(couponTypeLabel, .width, .equal,nil,.width,65))
        
        contentView.addConstraint(BXLayoutConstraintMake(mercImgView, .top, .equal, timeLabel,.bottom,20))
        contentView.addConstraint(BXLayoutConstraintMake(mercImgView, .left, .equal,timeLabel,.left))
        contentView.addConstraint(BXLayoutConstraintMake(mercImgView, .width, .equal,nil,.width,60))
        contentView.addConstraint(BXLayoutConstraintMake(mercImgView, .height,.equal,nil,.height,60))
        
        contentView.addConstraint(BXLayoutConstraintMake(couponTitleLabel, .bottom, .equal,contentView,.centerY,-3))
        contentView.addConstraint(BXLayoutConstraintMake(couponTitleLabel, .left,.equal,mercImgView,.right,15))
        
        contentView.addConstraint(BXLayoutConstraintMake(subCouponLabel, .left, .equal,couponTitleLabel,.right,10))
        contentView.addConstraint(BXLayoutConstraintMake(subCouponLabel, .bottom, .equal,couponTitleLabel,.bottom))
        
        contentView.addConstraint(BXLayoutConstraintMake(detailCouponLabel, .top, .equal,contentView,.centerY,3))
        contentView.addConstraint(BXLayoutConstraintMake(detailCouponLabel, .left,.equal,mercImgView,.right,15))
        
        contentView.addConstraint(BXLayoutConstraintMake(button, .centerX, .equal,contentView,.centerX))
        contentView.addConstraint(BXLayoutConstraintMake(button, .bottom,.equal,contentView,.bottom,-20))
        contentView.addConstraint(BXLayoutConstraintMake(button, .width,.equal,nil,.width,280))
        contentView.addConstraint(BXLayoutConstraintMake(button, .height,.equal,nil,.height,40))


    }
    
    func getCouponAction(_ button:UIButton)  {
//        button.isSelected = !button.isSelected
        guard let action = getCouponAction else { return }
        action(button,markId)
    }
    
    func calculationCurrentTime(_ endTime:String){
        
        let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let endDate = dateFormatter.date(from: endTime)
        let dateNow = Date()
        guard endDate != nil else {return}
        
        let compas = Calendar.current.dateComponents([.day,.hour,.minute,.second], from: dateNow, to: endDate!)
        let day = compas.day ?? 0
        let hour = compas.hour ?? 0
        let minute = compas.minute ?? 0
        let second = compas.second ?? 0
        
        if day <= 0, hour <= 0, minute <= 0, second <= 0{
            timeLabel.text = "活动已经结束"
        }else{
            timeLabel.text = "活动倒计时:\(day)天\(hour)时\(minute)分\(second)秒"
        }
        
    }
}










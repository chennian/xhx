//
//  LBMoreSecondCouponDetailCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/11.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBSecondCouponDetailCutDownCell: UITableViewCell {
    
    var model:LBSecondCouponDetailMarkInfoModel?{
        didSet{
            guard model != nil else { return }
            couponTypeLabel.text = model!.markType
        }
    }
    
    private let cutDownLabel = UILabel()
    private let couponTypeLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubview(cutDownLabel)
        contentView.addSubview(couponTypeLabel)
        
        cutDownLabel.translatesAutoresizingMaskIntoConstraints = false
        couponTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cutDownLabel.textColor = COLOR_e60013
        cutDownLabel.font = FONT_30PX
        
        couponTypeLabel.textColor = COLOR_ffffff
        couponTypeLabel.font = FONT_30PX
        couponTypeLabel.backgroundColor = COLOR_e60013
        couponTypeLabel.layer.cornerRadius = 10
        couponTypeLabel.layer.masksToBounds = true
        couponTypeLabel.textAlignment = .center
        
        contentView.addConstraint(BXLayoutConstraintMake(cutDownLabel, .left, .equal,contentView,.left,20))
        contentView.addConstraint(BXLayoutConstraintMake(cutDownLabel, .top, .equal,contentView,.top,25))
        
        contentView.addConstraint(BXLayoutConstraintMake(couponTypeLabel, .bottom, .equal,contentView,.bottom))
        contentView.addConstraint(BXLayoutConstraintMake(couponTypeLabel, .right, .equal,contentView,.right,-20))
        contentView.addConstraint(BXLayoutConstraintMake(couponTypeLabel, .width, .equal,nil,.width,80))
        contentView.addConstraint(BXLayoutConstraintMake(couponTypeLabel, .height, .equal,nil,.height,35))
        
        
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
            cutDownLabel.text = "活动已经结束"
        }else{
            cutDownLabel.text = "活动倒计时:\(day)天\(hour)时\(minute)分\(second)秒"
        }
        
    }
}


class LBSecondCouponDetailExplainCell: UITableViewCell {
    
    var model:LBSecondCouponDetailMarkInfoModel?{
        didSet{
            guard model != nil else { return }
            
            titleLabel.text = model!.markTitle
            subTitleLabel.text = model!.markSubhead
            if model!.disRate > 0{
                moneyLabel.text = "\(model!.disRate/10)" + "折"
            }else{
                moneyLabel.text = model!.disAmount + "元"

            }
            if model!.markType == "团购券"{
                couponLabel.text = "全团人数:" + model!.markNum + "人"
            }
            valiLabel.text = "有效期：" + model!.validStartDate + "至" + model!.validEndDate
            explainLabel.text = model!.markExplain
            
        }
    }
    var imgUrl:String = ""{
        didSet{
            guard imgUrl.isURLFormate() else { return }
            mercIconImgView.kf.setImage(with: URL(string:imgUrl))
            
        }
    }
    private let mercIconImgView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let moneyLabel = UILabel()
    private let couponLabel = UILabel()
    private let valiLabel = UILabel()
    private let line0 = LBlineView()
    private let explainLabel = UILabel()
    private let line1 = LBlineView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        contentView.addSubview(mercIconImgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(moneyLabel)
        contentView.addSubview(couponLabel)
        contentView.addSubview(valiLabel)
        contentView.addSubview(line0)
        contentView.addSubview(explainLabel)
        contentView.addSubview(line1)
        
        mercIconImgView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        couponLabel.translatesAutoresizingMaskIntoConstraints = false
        valiLabel.translatesAutoresizingMaskIntoConstraints = false
        line0.translatesAutoresizingMaskIntoConstraints = false
        explainLabel.translatesAutoresizingMaskIntoConstraints = false
        line1.translatesAutoresizingMaskIntoConstraints = false
        
        mercIconImgView.layer.cornerRadius = 30
        mercIconImgView.layer.masksToBounds = true
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = COLOR_222222
        
        subTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        subTitleLabel.textColor = COLOR_999999
        
        moneyLabel.textColor = COLOR_e60013
        moneyLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        couponLabel.textColor = COLOR_999999
        couponLabel.font = FONT_28PX
        
        valiLabel.textColor = COLOR_999999
        valiLabel.font = FONT_28PX
        
        explainLabel.font = FONT_30PX
        explainLabel.textColor = COLOR_222222
        explainLabel.numberOfLines = 0
        
        contentView.addConstraint(BXLayoutConstraintMake(mercIconImgView, .top, .equal,contentView,.top,22))
        contentView.addConstraint(BXLayoutConstraintMake(mercIconImgView, .centerX, .equal,contentView,.centerX))
        contentView.addConstraint(BXLayoutConstraintMake(mercIconImgView, .width, .equal,nil,.width,60))
        contentView.addConstraint(BXLayoutConstraintMake(mercIconImgView, .height, .equal,nil,.height,60))
        
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .top, .equal,mercIconImgView,.bottom,13))
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .centerX, .equal,contentView,.centerX))
                
        contentView.addConstraint(BXLayoutConstraintMake(subTitleLabel, .top, .equal,titleLabel,.bottom,5))
        contentView.addConstraint(BXLayoutConstraintMake(subTitleLabel, .centerX, .equal,contentView,.centerX))
        
        
        contentView.addConstraint(BXLayoutConstraintMake(moneyLabel, .top, .equal,subTitleLabel,.bottom,5))
        contentView.addConstraint(BXLayoutConstraintMake(moneyLabel, .centerX, .equal,contentView,.centerX))
        
        contentView.addConstraint(BXLayoutConstraintMake(couponLabel, .top, .equal,moneyLabel,.bottom,10))
        contentView.addConstraint(BXLayoutConstraintMake(couponLabel, .centerX, .equal,contentView,.centerX))
        
        contentView.addConstraint(BXLayoutConstraintMake(valiLabel, .top, .equal,couponLabel,.bottom,10))
        contentView.addConstraint(BXLayoutConstraintMake(valiLabel, .centerX, .equal,contentView,.centerX))
        
        
        contentView.addConstraint(BXLayoutConstraintMake(line0, .left, .equal,contentView,.left))
        contentView.addConstraint(BXLayoutConstraintMake(line0, .height, .equal,nil,.height,1))
        contentView.addConstraint(BXLayoutConstraintMake(line0, .top, .equal,valiLabel,.bottom,15))
        contentView.addConstraint(BXLayoutConstraintMake(line0, .width, .equal,nil,.width,KSCREEN_WIDTH))
        
        contentView.addConstraint(BXLayoutConstraintMake(explainLabel, .left, .equal,contentView,.left,15))
        contentView.addConstraint(BXLayoutConstraintMake(explainLabel, .top, .equal,line0,.top,10))
        
        contentView.addConstraint(BXLayoutConstraintMake(line1, .left, .equal,contentView,.left))
        contentView.addConstraint(BXLayoutConstraintMake(line1, .height, .equal,nil,.height,1))
        contentView.addConstraint(BXLayoutConstraintMake(line1, .top, .equal,explainLabel,.bottom,5))
        contentView.addConstraint(BXLayoutConstraintMake(line1, .width, .equal,nil,.width,KSCREEN_WIDTH))
        
    }
    
    
}

class LBCouponDetailShopCell: UITableViewCell {
    
    
    var model:LBSecondCouponDetailCommListModel?{
        didSet{
            guard model != nil else { return }
            if model!.commoPicUrl.count > 0,model!.commoPicUrl.isURLFormate(){
                shopImageView.kf.setImage(with: URL(string:model!.commoPicUrl))
            }
            shopNameLabel.text = model!.commoName
            shopPriceLabel.text = model!.commoPrice
        }
    }
    
    private let shopImageView = UIImageView()
    private let shopNameLabel = UILabel()
    private let shopPriceLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubview(shopImageView)
        contentView.addSubview(shopNameLabel)
        contentView.addSubview(shopPriceLabel)
        
        shopImageView.translatesAutoresizingMaskIntoConstraints = false
        shopNameLabel.translatesAutoresizingMaskIntoConstraints = false
        shopPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        shopNameLabel.font = FONT_30PX
        shopNameLabel.textColor = COLOR_4a4d57
        
        shopPriceLabel.font = FONT_30PX
        shopPriceLabel.textColor = COLOR_4a4d57
        
        contentView.addConstraint(BXLayoutConstraintMake(shopImageView, .left,.equal,contentView,.left,18))
        contentView.addConstraint(BXLayoutConstraintMake(shopImageView, .top, .equal,contentView,.top,20))
        contentView.addConstraint(BXLayoutConstraintMake(shopImageView, .width, .equal,nil,.width,80))
        contentView.addConstraint(BXLayoutConstraintMake(shopImageView, .height,.equal,nil,.height,80))
        
        contentView.addConstraint(BXLayoutConstraintMake(shopNameLabel, .top, .equal,shopImageView,.top,18))
        contentView.addConstraint(BXLayoutConstraintMake(shopNameLabel, .left, .equal,shopImageView,.right,12))
        
        contentView.addConstraint(BXLayoutConstraintMake(shopPriceLabel, .top, .equal,shopNameLabel,.bottom,15))
        contentView.addConstraint(BXLayoutConstraintMake(shopPriceLabel, .left, .equal,shopImageView,.right,12))
        
    }
}
class LBCouponDetailCommCell: UITableViewCell {
    
    var cellType:LBSecondCouponDetailCellType?{
        didSet{
            guard cellType != nil else{return}
            switch cellType! {
            case .commCell(let model,let text):
                if text.count > 0 {
                    titleLabel.text = text
                    show(views: accessoryImageView,titleLabel)
                }else{
                    
                    switch model.useScope {
                    case 0:
                        show(views: titleLabel,lineView)
                        titleLabel.text = "全店通用"
                        titleLabel.textColor = COLOR_e60013
                    case 1:
                        titleLabel.text = "部分商品"
                        show(views: titleLabel,lineView)
                    default:break
                    }
                }
            default:
                break
            }
        }
    }
    
    private let titleLabel = UILabel()
    private let accessoryImageView = UIImageView(image:UIImage(named:"redAccessoryIcon"))
    private let lineView = LBlineView()
    private let packView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.groupTableViewBackground
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(views:UIView...){
        for view in packView.subviews {
            if views.contains(view){
                view.isHidden = false
            }else{
                view.isHidden = true
            }
        }
    }
    private func setupUI() {
        
        contentView.addSubview(packView)
        packView.addSubview(titleLabel)
        packView.addSubview(lineView)
        packView.addSubview(accessoryImageView)
        
        packView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        
        packView.backgroundColor = COLOR_ffffff
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = COLOR_222222
        
        
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[packView]-0-|",
                                                                  options: NSLayoutFormatOptions(rawValue: 0),
                                                                  metrics: nil,
                                                                  views: ["packView":packView]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[packView]-0-|",
                                                                  options: NSLayoutFormatOptions(rawValue: 0),
                                                                  metrics: nil,
                                                                  views: ["packView":packView]))
        
        
        packView.addConstraint(BXLayoutConstraintMake(titleLabel, .left, .equal,packView,.left,22.5))
        packView.addConstraint(BXLayoutConstraintMake(titleLabel, .centerY, .equal,packView,.centerY))
        
        
        packView.addConstraint(BXLayoutConstraintMake(lineView, .left, .equal,packView,.left))
        packView.addConstraint(BXLayoutConstraintMake(lineView, .height, .equal,nil,.height,1))
        packView.addConstraint(BXLayoutConstraintMake(lineView, .top, .equal,packView,.bottom))
        packView.addConstraint(BXLayoutConstraintMake(lineView, .width, .equal,nil,.width,KSCREEN_WIDTH))
        
        packView.addConstraint(BXLayoutConstraintMake(accessoryImageView, .right, .equal,packView,.right,-10))
        packView.addConstraint(BXLayoutConstraintMake(accessoryImageView, .height, .equal,nil,.height,10))
        packView.addConstraint(BXLayoutConstraintMake(accessoryImageView, .centerY, .equal,packView,.centerY))
        packView.addConstraint(BXLayoutConstraintMake(accessoryImageView, .width, .equal,nil,.width,5))
        
    }
}
class LBCouponDetailFooterView: UIView {
    
    var clickGetCouponAction:((UIButton)->())?
    var button_isEnabled:Bool = true{
        didSet{
            button.isEnabled = button_isEnabled
        }
    }
    var button_isHidden:Bool = false{
        didSet{
            button.isHidden = button_isHidden
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 90)
        setupUI()
        button.addTarget(self, action: #selector(clickGetCouponAction(_ :)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let button = UIButton()
    private func setupUI(){
        
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        
        button.setTitle("立即领取", for: .normal)
        button.setTitle("已领取", for: .selected)
        button.setBackgroundImage(UIImage.imageWithColor(COLOR_e60013), for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(COLOR_999999), for: .selected)
        
        addConstraint(BXLayoutConstraintMake(button, .centerX, .equal,self,.centerX))
        addConstraint(BXLayoutConstraintMake(button, .top, .equal,self,.top,20))
        addConstraint(BXLayoutConstraintMake(button, .width, .equal,nil,.width,230*AUTOSIZE_X))
        addConstraint(BXLayoutConstraintMake(button, .height, .equal,nil,.height,40))
        
        
    }
    
    func clickGetCouponAction(_ button:UIButton) {
        button.isSelected = !button.isSelected
        guard let action = clickGetCouponAction else { return  }
        action(button)
    }
}




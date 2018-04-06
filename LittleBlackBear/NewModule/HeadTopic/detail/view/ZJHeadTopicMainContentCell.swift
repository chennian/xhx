//
//  ZJHeadTopicMainContentView.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 18/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class ZJHeadTopicMainContentCell: SNBaseTableViewCell {

    let clickPub = PublishSubject<(index : Int ,imgs : [String])>()
    
    let buttonClick = PublishSubject<ZJHeadTopicButtonType>()
    
    var model : ZJHeadTopicCellModel?{
        didSet{
//            shareButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: {[unowned self] () in
//                self.buttonClick.onNext(ZJHeadTopicButtonType.share(model : self.model!))
//            }).disposed(by: disposeBag)
//            commitionButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
//                self.buttonClick.onNext(ZJHeadTopicButtonType.common(model : self.model!))
//            }).disposed(by: disposeBag)
//
//            likeButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
//                self.buttonClick.onNext(ZJHeadTopicButtonType.like(id : self.model!.id,btn : self.likeButton))
//            }).disposed(by: disposeBag)
            
            imgsView.clickPub.asObserver().subscribe(onNext: { (index ,imgs) in
                self.clickPub.onNext((index: index, imgs: imgs))
            }).disposed(by: disposeBag)
            
            var imgViewheight : CGFloat
            
            
            if model!.images.count > 0 && model!.images.count <= 3{
                imgViewheight = fit(228) + fit(28)
            } else if model!.images.count > 3 && model!.images.count <= 6 {
                imgViewheight = CGFloat(2) * fit(228) + fit(28)  + fit(12)
            }else if model!.images.count > 6 {
                imgViewheight = CGFloat(3) * fit(228) + fit(12) + fit(28)
            }else {
                imgViewheight = 0.0
            }
            
            
            imgsView.snp.remakeConstraints { (make) in
                make.left.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalTo(imgViewheight)
                make.top.equalTo(contentLab.snp.bottom).snOffset(28)
            }
            loaclIcon.snp.remakeConstraints { (make) in
                make.top.equalTo(imgsView.snp.bottom)
                make.left.equalTo(contentLab)
            }
            loaclLab.snp.remakeConstraints { (make) in
                make.centerY.equalTo(loaclIcon)
                make.left.equalTo(loaclIcon.snp.right).snOffset(8)
            }
            
            headIcon.kf.setImage(with: URL(string:model!.headImg), placeholder: UIImage(named:"LBlogoIconHead"))
            nameLab.text = model!.nickName
            
            //timeLab
            imgsView.imgStrs = model!.images
            contentLab.text = model!.description
            
            if model!.location_desc != ""{
                loaclLab.text = model!.location_desc
                loaclLab.isHidden = false
                loaclIcon.isHidden = false
            }else{
                loaclLab.isHidden = true
                loaclIcon.isHidden = true
            }
        }
    }
    
    let headIcon = UIImageView().then{
        $0.layer.cornerRadius = fit(40)
        $0.clipsToBounds = true
    }
    let nameLab = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    let timeLab = UILabel().then{
        $0.textColor = Color(0xa5a5a5)
        $0.font = Font(26)
    }
    let contentLab = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(34)
        $0.numberOfLines = 0
        //        $0.lineBreakMode = .
    }
    
    let loaclLab = UILabel().then{
        $0.textColor = Color(0x939393)
        $0.font = Font(26)
    }
    let loaclIcon = UIImageView().then{
        $0.image = UIImage(named : "headline_address")
    }

    
    
    
    let imgsView = ZJHeadTopicImageMutilyImageView()
    
    override func setupView() {
        backgroundColor = Color(0xf5f5f5)
        contentView.backgroundColor = .white
        line.backgroundColor = Color(0xe2e2e2)
        contentView.snp.remakeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.snEqualTo(20)
        }
        headIcon.backgroundColor = .red
//        nameLab.text = "安吉都"
//        timeLab.text = "50分钟前"
//        contentLab.text = "烤尚宫寒是自主烤肉。水晶火锅"
//        loaclLab.text = "深圳,会展中心"
        contentView.addSubview(imgsView)
        contentView.addSubview(headIcon)
        contentView.addSubview(nameLab)
        contentView.addSubview(timeLab)
        contentView.addSubview(contentLab)
        contentView.addSubview(loaclIcon)
        contentView.addSubview(loaclLab)
        
        headIcon.snp.makeConstraints { (make) in
            make.left.snEqualTo(20)
            make.top.snEqualTo(24)
            make.height.width.snEqualTo(80)
        }
        nameLab.snp.makeConstraints { (make) in
            make.centerY.snEqualTo(headIcon)
            make.left.snEqualTo(headIcon.snp.right).snOffset(13)
        }
        timeLab.snp.makeConstraints { (make) in
            make.right.snEqualToSuperview().snOffset(-25)
            make.centerY.equalTo(headIcon)
        }
        contentLab.snp.makeConstraints { (make) in
            make.left.snEqualTo(20)
            make.right.snEqualToSuperview().snOffset(-20)
            make.top.snEqualTo(headIcon.snp.bottom).snOffset(26)
        }
        
        

    }

}




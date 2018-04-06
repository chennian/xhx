//
//  ZJHeadTopicCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 18/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift

enum ZJHeadTopicButtonType {
    case share(model : ZJHeadTopicCellModel)
    case common(model : ZJHeadTopicCellModel)
    case like(id : String ,btn : UIButton)
    case delete(id : String)
}
class ZJHeadTopicCell: SNBaseTableViewCell {
    
    let buttonClick = PublishSubject<ZJHeadTopicButtonType>()
    let clickPub = PublishSubject<(index : Int ,imgs : [String])>()
    var model : ZJHeadTopicCellModel?{
        didSet{
            previewLab.isHidden = false
            arrowImg.isHidden = false
            deleteBtn.isHidden = true
            shareButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: {[unowned self] () in
                self.buttonClick.onNext(ZJHeadTopicButtonType.share(model : self.model!))
            }).disposed(by: disposeBag)
            commitionButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
                self.buttonClick.onNext(ZJHeadTopicButtonType.common(model : self.model!))
            }).disposed(by: disposeBag)
            
            likeButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
                self.buttonClick.onNext(ZJHeadTopicButtonType.like(id : self.model!.id,btn : self.likeButton))
                self.likeButton.isSelected =  !self.likeButton.isSelected
                self.model!.praise = self.likeButton.isSelected
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

            likeButton.isSelected = model!.praise
            
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
            nameLab.text = model!.nickName == "" ? "暂无昵称" : model!.nickName
            
            //timeLab
            imgsView.imgStrs = model!.images
            shareButton.setTitle(model!.forwardNum, for: .normal)
            commitionButton.setTitle(model!.replyNum, for: .normal)
            likeButton.setTitle(model!.real_praise, for: .normal)
            contentLab.text = model!.description
            
            if model!.location_desc != ""{
                loaclLab.text = model!.location_desc
                loaclLab.isHidden = false
                loaclIcon.isHidden = false
            }else{
                loaclLab.isHidden = true
                loaclIcon.isHidden = true
            }
            
            imgsView.clickPub.asObserver().subscribe(onNext: { (index ,imgs) in
                self.clickPub.onNext((index: index, imgs: imgs))
            }).disposed(by: disposeBag)
        }
    }
    
    func manage(){
        previewLab.isHidden = true
        arrowImg.isHidden = true
        deleteBtn.isHidden = false
        deleteBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            self.buttonClick.onNext(ZJHeadTopicButtonType.delete(id: self.model!.id))
        }).disposed(by: disposeBag)
    }

   public  let headIcon = UIImageView().then{
        $0.layer.cornerRadius = fit(40)
        $0.clipsToBounds = true
    }
    let nameLab = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }
    let timeLab = UILabel().then{
        $0.textColor = Color(0xa5a5a5)
        $0.font = Font(20)
    }
    let contentLab = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(34)
        $0.numberOfLines = 0
//        $0.lineBreakMode = .
    }
    let previewLab = UILabel().then{
        $0.textColor = Color(0x74787e)
        $0.text = "查看"
        $0.font = Font(28)
    }
    let arrowImg = UIImageView.init(image: UIImage(named: "home_more"))
    
    let loaclLab = UILabel().then{
        $0.textColor = Color(0x939393)
        $0.font = Font(26)
    }
    let loaclIcon = UIImageView().then{
        $0.image = UIImage(named : "headline_address")
    }
    
    let shareButton = UIButton().then{
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.titleLabel?.font = Font(30)
        $0.setImage(UIImage(named : "headline_transpond"), for: .normal)
    }
    let commitionButton = UIButton().then{
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.titleLabel?.font = Font(30)
        $0.setImage(UIImage(named : "headline_evaluate"), for: .normal)
    }
    let likeButton = UIButton().then{
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.titleLabel?.font = Font(30)
        $0.setImage(UIImage(named : "headline_praise"), for: .normal)
        $0.setImage(UIImage(named : "headline_praise1"), for: .selected)
    }
    
    
    let deleteBtn = UIButton().then({
        $0.setTitleColor(Color(0x74787e), for: .normal)
        $0.titleLabel?.font = Font(28)
        $0.setTitle("删除", for: .normal)
    })
    
    /*
     let preview = SinglePhotoPreviewViewController()
     let data = self.getModelExceptButton()
     preview.selectImages = data
     preview.sourceDelegate = self
     preview.currentPage = button.tag
     self.show(preview, sender: nil)
     */

    let imgsView = ZJHeadTopicImageMutilyImageView()
    
    override func setupView() {
        backgroundColor = Color(0xf5f5f5)
        contentView.backgroundColor = .white
        line.backgroundColor = Color(0xe2e2e2)
        contentView.snp.remakeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.snEqualTo(20)
        }
        headIcon.backgroundColor = .gray
//        nameLab.text = "安吉都"
//        timeLab.text = "50分钟前"
//        contentLab.text = "烤尚宫寒是自主烤肉。水晶火锅"
//        loaclLab.text = "深圳,会展中心"
        shareButton.setTitle("56", for: .normal)
        commitionButton.setTitle("56", for: .normal)
        likeButton.setTitle("56", for: .normal)
        contentView.addSubview(imgsView)
        contentView.addSubview(headIcon)
        contentView.addSubview(nameLab)
        contentView.addSubview(timeLab)
        contentView.addSubview(contentLab)
        contentView.addSubview(loaclIcon)
        contentView.addSubview(loaclLab)
        contentView.addSubview(shareButton)
        contentView.addSubview(commitionButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(previewLab)
        contentView.addSubview(arrowImg)
        contentView.addSubview(deleteBtn)
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
            make.left.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom)
            
//            make.centerY.equalTo(headIcon)
        }
        contentLab.snp.makeConstraints { (make) in
            make.left.snEqualTo(20)
            make.right.snEqualToSuperview().snOffset(-20)
            make.top.snEqualTo(headIcon.snp.bottom).snOffset(26)
        }
        arrowImg.snp.makeConstraints { (make) in
            make.top.snEqualTo(42)
            make.right.snEqualToSuperview().snOffset(-20)
        }
        
        previewLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(arrowImg)
            make.right.equalTo(arrowImg.snp.left).snOffset(-10)
        }
        line.snp.remakeConstraints { (make) in
            make.left.snEqualTo(20)
            make.right.snEqualToSuperview().snOffset(-20)
            make.height.snEqualTo(1)
            make.bottom.snEqualToSuperview().snOffset(-90)
        }
        shareButton.snp.makeConstraints { (make) in
            make.left.bottom.snEqualToSuperview()
            make.width.snEqualToSuperview().multipliedBy(0.33)
            make.top.snEqualTo(line.snp.bottom)
        }
        commitionButton.snp.makeConstraints { (make) in
            make.size.equalTo(shareButton)
            make.bottom.equalTo(shareButton)
            make.centerX.equalToSuperview()
        }
        likeButton.snp.makeConstraints { (make) in
            make.size.equalTo(shareButton)
            make.bottom.equalTo(shareButton)
            make.right.equalToSuperview()
        }
        deleteBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(arrowImg)
            make.right.equalTo(arrowImg.snp.left).snOffset(-10)
        }
    }
}




class ZJHeadTopicImageMutilyImageView : SNBaseView{
    
    
    let clickPub = PublishSubject<(index : Int ,imgs : [String])>()
    var imgStrs : [String] = []{
        didSet{
            subviews.forEach({$0.removeFromSuperview()})
            let count = imgStrs.count
            let marginW = fit(13)
            let marginH = fit(12)
            let lineNum = 3
            for i in 0..<count{
                let imgBtn = UIButton()
                imgBtn.setImage(createImageBy(color: Color(0xf1f1f1)), for: .normal)
                imgBtn.kf.setImage(with: URL(string:imgStrs[i]), for: .normal)
                addSubview(imgBtn)
                
                imgBtn.imageView?.contentMode = .scaleAspectFill
                let left = CGFloat(i % lineNum) * (fit(228) + marginW) + fit(20)
                let top = CGFloat(i / lineNum) * (fit(228) + marginH)
                imgBtn.snp.makeConstraints({ (make) in
                    make.width.height.snEqualTo(228)
                    make.left.equalTo(left)
                    make.top.equalTo(top)
                })
                imgBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
                    self.clickPub.onNext((index: i, imgs: self.imgStrs))
                }).disposed(by: disposeBag)
            }
        }
    }
    
}

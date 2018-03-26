//
//  ZJHeadTopicToolHeader.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 22/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
enum ZJHeadTopicToolBarButtonType {
    case share
    case like
    case common
}
class ZJHeadTopicToolHeader: SNBaseView {
    let btnClick = PublishSubject<ZJHeadTopicToolBarButtonType>()
    
    var showType : ZJHeadTopicToolBarButtonType = .common{
        didSet{
            switch showType {
            case .common:
                self.shareBtn.isSelected = false
                self.likeBtn.isSelected = false
                self.commomBtn.isSelected = true
                self.anmiLine(btn: self.commomBtn)
            case .like:
                self.commomBtn.isSelected = false
                self.shareBtn.isSelected = false
                self.likeBtn.isSelected = true
                self.anmiLine(btn: self.likeBtn)
            case .share:
                self.commomBtn.isSelected = false
                self.likeBtn.isSelected = false
                self.shareBtn.isSelected = true
                self.anmiLine(btn: self.shareBtn)
            }
        }
    }
    func setContent(share : String , commom : String ,like : String){
//        commomBtn.isSelected = true
        shareBtn.setTitle("转发 " + share, for: .normal)
        commomBtn.setTitle("评论 " + commom, for: .normal)
        likeBtn.setTitle("点赞 " + like, for: .normal)
        
        
        shareBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: {[unowned self] () in
            if self.shareBtn.isSelected {return}
            self.commomBtn.isSelected = false
            self.likeBtn.isSelected = false
            self.shareBtn.isSelected = true
            self.btnClick.onNext(ZJHeadTopicToolBarButtonType.share)
//            self.anmiLine(btn: self.shareBtn)
        }).disposed(by: disposeBag)
        commomBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: {[unowned self] () in
            if self.commomBtn.isSelected {return}
            self.shareBtn.isSelected = false
            self.likeBtn.isSelected = false
            self.commomBtn.isSelected = true
            self.btnClick.onNext(ZJHeadTopicToolBarButtonType.common)
//            self.anmiLine(btn: self.commomBtn)
        }).disposed(by: disposeBag)
        likeBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: {[unowned self] () in
            if self.likeBtn.isSelected {return}
            self.commomBtn.isSelected = false
            self.shareBtn.isSelected = false
            self.likeBtn.isSelected = true
            self.btnClick.onNext(ZJHeadTopicToolBarButtonType.like)
//            self.anmiLine(btn: self.likeBtn)
        }).disposed(by: disposeBag)
    }

    private func anmiLine(btn : UIButton){
        downLine.snp.remakeConstraints { (make) in
            make.height.snEqualTo(6)
            make.width.snEqualTo(60)
            make.centerX.equalTo(btn)
            make.bottom.snEqualTo(line.snp.top).snOffset(-2)
        }
        // 告诉self.view约束需要更新
        self.needsUpdateConstraints()
        // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
        self.updateConstraintsIfNeeded()

        self.layoutIfNeeded()

    }
   
    override func setupView() {
        addSubview(shareBtn)
        addSubview(commomBtn)
        addSubview(likeBtn)
        addSubview(line)
        addSubview(downLine)
        commomBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        shareBtn.snp.makeConstraints { (make) in
            make.left.snEqualTo(80)//equalTo(commomBtn).snOffset(-fit(250))
            make.centerY.equalTo(commomBtn)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-80)//centerX.equalToSuperview().multipliedBy(1.5)
            make.centerY.equalTo(commomBtn)
        }
        line.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.snEqualTo(1)
        }
        downLine.snp.makeConstraints { (make) in
            make.height.snEqualTo(6)
            make.width.snEqualTo(60)
            make.centerX.equalTo(commomBtn)
            make.bottom.snEqualTo(line.snp.top).snOffset(-2)
        }
    }
    
    
    let shareBtn = UIButton().then{
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.titleLabel?.font = Font(28)
        $0.setTitleColor(Color(0xff0000), for: .selected)
    }
    let commomBtn = UIButton().then{
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.titleLabel?.font = Font(28)
        $0.setTitleColor(Color(0xff0000), for: .selected)
    }
    let likeBtn = UIButton().then{
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.titleLabel?.font = Font(28)
        $0.setTitleColor(Color(0xff0000), for: .selected)
    }
    let line = UIView().then{
        $0.backgroundColor = Color(0xe2e2e2)
    }
    
    let downLine = UIView().then({
        $0.backgroundColor = Color(0xff0000)
        $0.layer.cornerRadius = fit(2)
    })
}

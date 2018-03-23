//
//  ZJHeadTopicToolBar.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 18/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift

class ZJHeadTopicToolBar: SNBaseView {

    
    
    
//    func set(share : String , like : String){
//        likeButton.content.text = like
//        shareButton.content.text = share
//
//    }
    let replayClick = PublishSubject<String>()
    
    let line = UIView().then{
        $0.backgroundColor = Color(0xe2e2e2)
    }
    
    let commonBtn = ZJHeadTopicInputView().then({
//        $0.attributedPlaceholder = NSAttributedString(string: "评论po主", attributes: [NSFontAttributeName : Font(28),NSForegroundColorAttributeName : Color(0xa6a6a6)])
//        $0.leftViewMode = .always
//        let leftV = UIView(frame: CGRect(x: 0, y: 0, width: fit(22), height: 1))
//        $0.leftView = leftV
        $0.backgroundColor = Color(0xf4f4f4)
        $0.textColor = Color(0x313131)
        $0.font = Font(28)
        $0.placeholderT = "评论po主"
        
    })
    let likeButton = ZJHeadTopicToolBarFunButton(icon: "headline_praise")

    let shareButton = ZJHeadTopicToolBarFunButton(icon: "headline_transpond")
    
    let returnBtn = UIButton().then({
        $0.setTitle("发送", for: .normal)
        $0.setTitleColor(Color(0xff0000), for: .normal)
        $0.setTitleColor(Color(0x939393), for: .disabled)
        $0.isEnabled = false
        $0.isHidden = true
    })
    let lineV = UIView().then{
        $0.backgroundColor = Color(0xe2e2e2)
        $0.isHidden = true
    }
    override func setupView() {
        addSubview(commonBtn)
        addSubview(likeButton)
        addSubview(shareButton)
        addSubview(line)
        addSubview(lineV)
        addSubview(returnBtn)
        line.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.snEqualTo(1)
        }
        commonBtn.snp.makeConstraints { (make) in
            make.width.snEqualTo(420)
            make.height.snEqualTo(70)
            make.centerY.equalToSuperview()
            make.left.snEqualTo(20)
        }
        
        likeButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.snEqualTo(100)
            make.left.snEqualTo(commonBtn.snp.right).snOffset(33)
        }
        shareButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.snEqualTo(100)
            make.right.snEqualToSuperview().snOffset(-33)
        }
        likeButton.content.text = "点赞"
        shareButton.content.text = "转发"

        lineV.snp.makeConstraints { (make) in
            make.top.snEqualTo(26)
            make.bottom.snEqualToSuperview().snOffset(-26)
            make.width.snEqualTo(2)
            make.right.equalToSuperview().snOffset(-130)
        }
        returnBtn.snp.makeConstraints { (make) in
            make.centerY.snEqualToSuperview()
            make.width.snEqualTo(130)
//            make.bottom.equalToSuperview()
            make.height.equalToSuperview()
            make.right.equalToSuperview()
        }
        
    }
    
    
    
    override func bindEvent() {
        commonBtn.tv.rx.didBeginEditing.asObservable().subscribe(onNext: { () in
            self.returnBtn.isHidden = false
            self.lineV.isHidden = false
            self.shareButton.isHidden = true
            self.likeButton.isHidden = true
            self.commonBtn.backgroundColor = .white
            self.snp.remakeConstraints({ (make) in
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-LL_TabbarSafeBottomMargin)
                make.height.snEqualTo(120)
            })
            self.commonBtn.snp.remakeConstraints { (make) in
//                make.width.snEqualTo(420)
                make.right.equalTo(self.lineV.snp.left).snOffset(-20)
                make.height.snEqualTo(90)
                make.centerY.equalToSuperview()
                make.left.snEqualTo(20)
            }
            
            self.needsUpdateConstraints()
            // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
            self.updateConstraintsIfNeeded()
            
            self.layoutIfNeeded()
//            self.commonBtn.snp.makeConstraints({ (make) in
//                make.left.snEqualTo(20)
//                make.right.snEqualTo(lineV.snp.left).snOffset(-20)
//                make
//            })
        }).disposed(by: disposeBag)
        commonBtn.tv.rx.didChange.asObservable().subscribe(onNext: { () in
            self.returnBtn.isEnabled = self.commonBtn.tv.text!.utf16.count > 0

        }).disposed(by: disposeBag)
        commonBtn.tv.rx.didEndEditing.asObservable().subscribe(onNext: { () in
            self.returnBtn.isHidden = true
            self.lineV.isHidden = true
            self.shareButton.isHidden = false
            self.likeButton.isHidden = false
            self.commonBtn.backgroundColor = Color(0xf4f4f4)
            self.snp.remakeConstraints({ (make) in
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-LL_TabbarSafeBottomMargin)
                make.height.snEqualTo(120)
            })
            
            self.commonBtn.snp.remakeConstraints { (make) in
                make.width.snEqualTo(420)
                make.height.snEqualTo(70)
                make.centerY.equalToSuperview()
                make.left.snEqualTo(20)
            }
            
            
            self.needsUpdateConstraints()
            // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
            self.updateConstraintsIfNeeded()
            
            self.layoutIfNeeded()
        }).disposed(by: disposeBag)
        
        returnBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            self.replayClick.onNext(self.commonBtn.tv.text)
            self.commonBtn.tv.resignFirstResponder()
            self.commonBtn.tv.text = ""
        }).disposed(by: disposeBag)
    }
}
class ZJHeadTopicToolBarCommonButton : UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLab = UILabel().then{
        $0.text = "评论po主"
        $0.textColor = Color(0xa6a6a6)
        $0.font = Font(28)
    }
    
    
   
    
    func setUpView(){
        backgroundColor = Color(0xf4f4f4)
        layer.cornerRadius = fit(4)
        addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.snEqualTo(22)
        }
    }
}

class ZJHeadTopicToolBarFunButton : UIButton{
    let iconImgV = UIImageView()
    let content = UILabel().then{
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    func setSelect(selected : Bool,img:String){
        if selected{
            isSelected = true
            iconImgV.image = UIImage(named : img + "1")
        }else{
            isSelected = false
            iconImgV.image = UIImage(named : img)
        }
    }
    
    convenience init(icon : String) {
        self.init()
        iconImgV.image = UIImage(named : icon)
        setUpView()
    }
    
    func setUpView(){
        addSubview(iconImgV)
        addSubview(content)
        iconImgV.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.snEqualTo(22)
        }
        content.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.snEqualToSuperview().snOffset(-18)
        }
    }
}

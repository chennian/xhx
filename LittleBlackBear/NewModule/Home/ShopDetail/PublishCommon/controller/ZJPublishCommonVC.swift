//
//  ZJPublishCommonVC.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 15/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJPublishCommonVC: SNBaseViewController {

    var shopId : String = ""

    override func setupView() {
        title = "发布评论"
        navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: pubBtn)
        let startContent = UIView()
        startContent.backgroundColor = .white
        
        view.addSubview(startContent)
        startContent.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(20)
            make.height.snEqualTo(90)
        }
        let tipLab = UILabel()
        tipLab.textColor = Color(0x313131)
        tipLab.font = Font(30)
        tipLab.text = "评价"
        
        startContent.addSubview(tipLab)
        startContent.addSubview(startView)
        
        tipLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.snEqualTo(30)
        }
    
        startView.snp.makeConstraints { (make) in
            make.left.snEqualTo(150)
            make.height.snEqualTo(28)
            make.width.snEqualTo(245)
            make.centerY.equalToSuperview()
        }
        
        let textVContent = UIView()
        textVContent.backgroundColor = .white
        view.addSubview(textVContent)
        textVContent.addSubview(textVIew)
        textVContent.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(startContent.snp.bottom).snOffset(20)
            make.height.snEqualTo(300)
        }
        
        textVIew.snp.makeConstraints { (make) in
            make.left.snEqualTo(30)
            make.centerY.equalToSuperview()
            make.height.snEqualToSuperview().snOffset(-60)
            make.width.equalToSuperview()
        }
    }
    
    
    override func bindEvent() {
        pubBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            self.publishCommo()
        }).disposed(by: disposeBag)
    }
    
    
    
    func publishCommo(){
        if startView.startCount == 0 {
            SZHUD("请打分", type: .error, callBack: nil)
            return
        }
        if textVIew.text.utf16.count == 0 {
            SZHUD("请输入评论语", type: .error, callBack: nil)
            return
        }
        
        SNRequestBool(requestType: API.publishCommon(shopId: shopId, description: textVIew.text, images: "", grade: String(format: "%d", startView.startCount))).subscribe(onNext: { (res) in
            switch res{
            case .bool:
                SZHUD("发布成功", type: .info, callBack: nil)
            self.navigationController?.popViewController(animated: true)
            case .fail:
                SZHUD("评论失败", type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    
    
    let startView = LBStartLevelView().then({
        $0.spacing = fit(20)
        $0.startCount = 0
    })
    
    let textVIew = SLTextView().then({
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
        $0.placeholder = "评价一下吧～"
        $0.placeholderFont = Font(30)
        $0.placeholderColor = Color(0xe2e2e2)
    })
    
    let pubBtn = UIButton().then({
        $0.setTitle("发布", for: .normal)
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.titleLabel?.font = Font(30)
        $0.sizeToFit()
    })

}

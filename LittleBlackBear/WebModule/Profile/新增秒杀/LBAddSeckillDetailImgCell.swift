//
//  LBAddSeckillDetailImgCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift


class LBAddSeckillDetailImgCell: SNBaseTableViewCell {
    
    var imgTap =  PublishSubject<(AliOssTransferProtocol,String)>()


    private let showLable = UILabel().then{
        $0.text = "详情展示图"
    }
    var showImge1 = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"new_addition"),for:.normal)
        $0.fuName = "img1"
        $0.imageView?.contentMode = .scaleAspectFill
    }
    var showImge2 = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"new_addition"),for:.normal)
        $0.fuName = "img2"
        $0.imageView?.contentMode = .scaleAspectFill
    }
    var showImge3 = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"new_addition"),for:.normal)
        $0.fuName = "img3"
        $0.imageView?.contentMode = .scaleAspectFill
    }
    
    func bindEvent(){
        showImge1.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext: {[unowned self] () in
            self.imgTap.onNext((self.showImge1,self.showImge1.fuName))
        }).disposed(by: disposeBag)
        showImge2.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext: {[unowned self] () in
            self.imgTap.onNext((self.showImge2,self.showImge2.fuName))
        }).disposed(by: disposeBag)
        showImge3.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext: {[unowned self] () in
            self.imgTap.onNext((self.showImge3,self.showImge3.fuName))
        }).disposed(by: disposeBag)
    }
    
    override func setupView() {
        contentView.addSubview(showLable)
        contentView.addSubview(showImge1)
        contentView.addSubview(showImge2)
        contentView.addSubview(showImge3)
        bindEvent()

        
        showLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(26)
            make.width.equalTo(fit(160))
        }
        showImge1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(showLable.snp.bottom).snOffset(40)
            make.width.snEqualTo(158)
            make.height.snEqualTo(158)
        }
        
        showImge2.snp.makeConstraints { (make) in
            make.left.equalTo(showImge1.snp.right).snOffset(20)
            make.top.equalTo(showImge1.snp.top)
            make.width.snEqualTo(158)
            make.height.snEqualTo(158)
        }
        
        showImge3.snp.makeConstraints { (make) in
            make.left.equalTo(showImge2.snp.right).snOffset(20)
            make.top.equalTo(showImge2.snp.top)
            make.width.snEqualTo(158)
            make.height.snEqualTo(158)
        }
    }
}

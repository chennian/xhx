//
//  ZJMineFunctionCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 26/4/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
enum ZJMineFunctionType {
    case pushToVc(vc : String)
    case describtion(text : String)
    case blockFuntion(function : ()->())
    case signOut
}


class ZJMineFunctionCellModel {
    var icon : String
    var name : String
    var function : ZJMineFunctionType
    
    init(icon : String ,name : String,function : ZJMineFunctionType) {
        self.icon = icon
        self.name = name
        self.function = function
    }
}



class ZJMineFunctionCell: SNBaseTableViewCell {

    var model : ZJMineFunctionCellModel?{
        didSet{
            iconImgV.image = UIImage(named:model!.icon)
            nameLab.text = model!.name
            
            switch model!.function{
            case .describtion(let text):
                arrowImg.isHidden = true
                dexcriptionLab.isHidden = false
                dexcriptionLab.text = text
            default:
                arrowImg.isHidden = false
                dexcriptionLab.isHidden = true
            }
        }
    }
    
    
    
    

    
    let iconImgV = UIImageView().then({
        $0.contentMode = .center
    })
    let nameLab = UILabel().then({
        $0.font = Font(30)
        $0.textColor = Color(0x000607)
    })
    
    let arrowImg = UIImageView(image: UIImage.init(named: "home_more"))
    
    
    let dexcriptionLab = UILabel().then({
        $0.font = Font(30)
        $0.textColor = Color(0x000607)
    })
    
    override func setupView() {
        contentView.addSubview(iconImgV)
        contentView.addSubview(nameLab)
        contentView.addSubview(arrowImg)
        contentView.addSubview(dexcriptionLab)
        iconImgV.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.snEqualTo(30)
        }
        
        nameLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.snEqualTo(102)
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.snEqualToSuperview().snOffset(-40)
        }
        line.snp.remakeConstraints { (make) in
            make.left.snEqualTo(nameLab)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
        }
        dexcriptionLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.snEqualToSuperview().snOffset(-40)
        }

        
    }
    
}

class ZJMineSignOutCell : SNBaseTableViewCell{
    let signOutbtn = UILabel().then({
        $0.text = "退出登录"//setTitle("退出登录", for: .normal)
        $0.textColor = Color(0xff0000)//setTitleColor(Color(0xff0000), for: .normal)
        $0.font = Font(30)
//        $0.backgroundColor = .white
    })
    override func setupView() {
        contentView.addSubview(signOutbtn)
        signOutbtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}

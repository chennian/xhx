//
//  LBDistanceCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/13.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBDistanceCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var model:LBHomeMerchantModel?{
        didSet{
//            guard let item = model else {return}
//            button.setTitle(item.address, for: .normal)
//            label.text = "距离您" + item.distance
            addressLab.text = model!.address
            distanceLab.text = "距离您" + model!.distance
            setupUI()
        }
    }
    
    let loacIcon = UIImageView(image: UIImage(named :"headline_address"))
    let addressLab = UILabel().then({
        $0.textColor = COLOR_999999
        $0.font = FONT_30PX
        $0.numberOfLines = 0
    })
    private let distanceLab = UILabel().then({
        $0.font = FONT_28PX
        $0.textColor = COLOR_999999
    })
    let tipLab = UILabel().then({
        $0.text = "查看地图"
        $0.textColor = COLOR_999999
        $0.font = FONT_28PX
        
    })
    let arrowImg = UIImageView(image: UIImage(named :"rightAccessoryIcon"))
    
   private func setupUI(){
        contentView.addSubview(addressLab)
        contentView.addSubview(loacIcon)
        contentView.addSubview(distanceLab)
        contentView.addSubview(arrowImg)
        contentView.addSubview(tipLab)
    
        loacIcon.snp.makeConstraints { (make) in
            make.left.snEqualTo(30)
            make.top.snEqualTo(30)
        }
        addressLab.snp.makeConstraints { (make) in
            make.left.snEqualTo(loacIcon.snp.right).snOffset(10)
            make.right.equalTo(tipLab.snp.left).snOffset(-10)
            make.top.equalTo(loacIcon)
        }
    distanceLab.snp.makeConstraints { (make) in
        make.left.snEqualTo(loacIcon)
        make.bottom.snEqualToSuperview().snOffset(-30)
    }
    tipLab.snp.makeConstraints { (make) in
        make.centerY.equalToSuperview()
        make.right.equalTo(arrowImg.snp.left).snOffset(-10)
    }
    arrowImg.snp.makeConstraints { (make) in
        make.centerY.equalToSuperview()
        make.right.equalToSuperview().snOffset(-30)
    }
    }

}

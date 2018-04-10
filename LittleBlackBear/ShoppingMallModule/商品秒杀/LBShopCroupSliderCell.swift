//
//  LBShopCroupSliderCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 20/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import SDCycleScrollView

class LBShopCroupSliderCell: SNBaseTableViewCell {
    
    var model : ZJActgivityDetailBannerCellModel?{
        didSet{
            sdScrollBanner.imageURLStringsGroup = model!.imgArray
            //            if model!.endTime
            sdScrollBanner.bannerImageViewContentMode = .scaleAspectFill
            countDownView.setRemainTime(endTime: model!.endTime! + " " + "23:59:59" )
        }
    }
    
    lazy var sdScrollBanner : SDCycleScrollView = {
        let obj = SDCycleScrollView(frame: CGRect.zero, delegate: self, placeholderImage: UIImage())
        obj?.bannerImageViewContentMode = .scaleAspectFill
        obj?.pageDotColor = UIColor(white: 1.0, alpha: 0.6)
        obj?.currentPageDotColor = .white
        return obj!
    }()
    
    let countDownView = ZJCountDownView.size(width: 40, height: 36, fontSize: fit(24))
}


extension LBShopCroupSliderCell {
    
    override func setupView() {
        line.isHidden = true
        contentView.addSubview(sdScrollBanner)
        contentView.addSubview(countDownView)
        countDownView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.76)
        sdScrollBanner.snp.makeConstraints { (make) in
            make.edges.snEqualTo(0)
            make.height.snEqualTo(504)
        }
        countDownView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.snEqualTo(64)
        }
        
        
    }
}

extension LBShopCroupSliderCell : SDCycleScrollViewDelegate{
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
        //        let model = models[index]
        
        
        //        let type : BMPageJumpType = PageJumpTypeType(fast_way: model.fast_way, jump_id: model.jump_id, site_url: model.site_url)
        //        self.didSelectPub.onNext(type)
        
    }
}

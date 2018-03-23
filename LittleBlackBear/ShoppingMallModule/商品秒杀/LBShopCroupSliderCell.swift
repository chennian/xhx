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
        }
    }
    
    lazy var sdScrollBanner : SDCycleScrollView = {
        let obj = SDCycleScrollView(frame: CGRect.zero, delegate: self, placeholderImage: UIImage())
        obj?.bannerImageViewContentMode = .scaleAspectFill
        obj?.pageDotColor = UIColor(white: 1.0, alpha: 0.6)
        obj?.currentPageDotColor = .white
        return obj!
    }()
}


extension LBShopCroupSliderCell {
    
    override func setupView() {
        line.isHidden = true
        contentView.addSubview(sdScrollBanner)
        
        sdScrollBanner.snp.makeConstraints { (make) in
            make.edges.snEqualTo(0)
            make.height.snEqualTo(504)
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

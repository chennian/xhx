//
//  ZJSpaceCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJSpaceCell: SNBaseTableViewCell {

    var styleColor : UIColor = .clear{
        didSet{
            backgroundColor = styleColor
            contentView.backgroundColor = styleColor
        }
    }
    
    override func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        hidLine()
    }

}

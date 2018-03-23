//
//  ZPHBaseTableViewCell.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/17.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import RxSwift

class SNBaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        basicStyle()
        setupView()
        initCustom()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private(set) var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    
    let line = UIView().then{
        $0.backgroundColor = Color(0xe2e2e2)
//        $0.backgroundColor = color_line_gray_dc
    }


}


@objc extension SNBaseTableViewCell {
    func setupView() {
        
    }
    
    func hidLine(){
        line.isHidden = true
    }
    
    func basicStyle() {
        selectionStyle = .none
        contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.snEqualTo(1)
        }
    }
    
    func initCustom() {
        
    }
}

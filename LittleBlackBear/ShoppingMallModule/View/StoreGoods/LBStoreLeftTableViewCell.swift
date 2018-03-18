//
//  LBStoreCategoryTableViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBStoreLeftTableViewCell: UITableViewCell {

    var label_text:String = ""{
        didSet{
            guard label_text.count > 0  else{return}
            label.text = label_text
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        label.backgroundColor = selected ?COLOR_ffffff:COLOR_efefef
        label.textColor = selected ?COLOR_e60013:COLOR_222222
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isSelected = true
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let label = UILabel()
    let line  = UIView()
    func setupUI(){
        
        contentView.addSubview(label)
        contentView.addSubview(line)
        label.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = COLOR_222222
        label.font = FONT_30PX
        label.textAlignment = .center
        line.backgroundColor = COLOR_efefef
        let views = ["label":label,"line":line]
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label]|",
                                                                 options: NSLayoutFormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: ["label":label]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|",
                                                                  options: NSLayoutFormatOptions(rawValue: 0),
                                                                  metrics: nil,
                                                                  views: ["line":line]))

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label][line(0.5)]|",
                                                                 options: NSLayoutFormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: views))
    }
    
}

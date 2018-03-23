//
//  LBShoppingButtonCell.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/12/11.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBShoppingButtonCell: UITableViewCell {

//    var cellType:shoppingCellTye = .button("",""){
//        didSet{
//            switch cellType {
//            case let .button(text,_):
//                setupUI()
//                button.backgroundColor = UIColor.white
//                button.titleLabel?.font = FONT_30PX
//                button.setTitleColor(COLOR_e60013, for: .normal)
//                button.setImage(UIImage(named:"redAccessoryIcon"), for: .normal)
//                button.setTitle(text, for: .normal)
//            
//                guard let imgW = button.imageView?.image?.size.width,
//                    let lbW  = button.titleLabel?.text?.getSize(15).width
//                    else{return}
//                button.titleEdgeInsets = UIEdgeInsetsMake(0, -imgW, 0, imgW)
//                button.imageEdgeInsets = UIEdgeInsetsMake(0, lbW, 0, -lbW-20)
//                
//            default:
//                break
//            }
//        }
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private let button = UIButton()
	func setupUI() {
        
        contentView.backgroundColor = COLOR_e6e6e6
		contentView.addSubview(button)
        button.isUserInteractionEnabled = false
		button.translatesAutoresizingMaskIntoConstraints = false
		contentView.addConstraint(BXLayoutConstraintMake(button,.left, .equal,contentView,.left))
		contentView.addConstraint(BXLayoutConstraintMake(button,.right,.equal,contentView,.right))
		contentView.addConstraint(BXLayoutConstraintMake(button,.top,.equal,contentView,.top))
		contentView.addConstraint(BXLayoutConstraintMake(button,.bottom,.equal,contentView,.bottom,-10))
		
		
		
	}
	
}

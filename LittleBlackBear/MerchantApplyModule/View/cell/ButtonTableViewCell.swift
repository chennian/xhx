//
//  ButtonTableViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

enum ButtonTableViewCellType{
    case button(title: String, top: CGFloat, bottom: CGFloat)
	case button0(img:String,selectedImg:String,title:String,top:CGFloat,bottom:CGFloat)
}

class ButtonTableViewCell: LBMerchantApplyTableViewCell, ApplyTableViewCellProtocol {
	
	static let  indentifier: String = "ButtonTableViewCell"
    
    fileprivate var buttonTopConstract: NSLayoutConstraint?
	fileprivate var buttonBottomConstract: NSLayoutConstraint?
	
    var myType: ButtonTableViewCellType = .button(title: "", top: 0.0, bottom: 0.0) {
        didSet {
            cellType = ApplyTableViewCellType.button(myType)
			button.removeFromSuperview()
            switch myType {
            case let .button(title: title, top: top, bottom: _):
		
                button.setTitle(title, for: UIControlState.normal)
				button.backgroundColor = COLOR_1478b8
                buttonTopConstract?.constant = top
				button.tag = 0
				mycontentView.addSubview(button)
				configUI()
				
			case let .button0(img:img,selectedImg:selectedImg,title:title,top:top,bottom:bottom):
				button.setTitle(title, for: UIControlState.normal)
				button.setImage(UIImage(named:img), for: .normal)
				button.setImage(UIImage(named:selectedImg), for: .selected)
				buttonTopConstract?.constant = top
				buttonBottomConstract?.constant = bottom
				button.titleLabel?.font = FONT_28PX
				button.setTitleColor(COLOR_fc843b, for: .normal)
				button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
				
				let range1 = NSRange(location: 0, length: title.count)
				let number = NSNumber(value:NSUnderlineStyle.styleSingle.rawValue)
				let attributedStr = NSMutableAttributedString(string: title)
				attributedStr.addAttribute(NSAttributedStringKey.underlineStyle, value: number, range: range1)
				attributedStr.addAttribute(NSAttributedStringKey.foregroundColor, value: COLOR_fc843b, range: range1)
				button.setAttributedTitle(attributedStr, for: UIControlState.normal)
				button.tag = 1
				mycontentView.addSubview(button)
				configUI()

            }
        
        }
    }
    
    let button: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 10.f
        button.layer.masksToBounds = true
		button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
		
        button.addTarget(self, action: #selector(ButtonTableViewCell.nextButtonClick(btn:)), for: UIControlEvents.touchUpInside)
	
	
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	func configUI()  {
		
//		let topConstract = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: mycontentView, attribute: .top, multiplier: 1.0, constant: 20.0)
		let centerXConstract = NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: mycontentView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
		let bottomConstract = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: mycontentView, attribute: .bottom, multiplier: 1.0, constant: -20)
		mycontentView.addConstraints([bottomConstract, centerXConstract])
		let widthConstract = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 320)
		let heightConstract = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 45.0)
//		buttonTopConstract = topConstract
		buttonBottomConstract = bottomConstract
		button.addConstraints([widthConstract, heightConstract])
		mycontentView.addConstraints([bottomConstract,centerXConstract])
	}
    func nextButtonClick(btn: UIButton) {
        delegate?.buttonCell?(self, nextButtonClick: btn)
    }

}

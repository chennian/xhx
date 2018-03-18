//
//  LBMerchantApplyTableViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

protocol ApplyTableViewCellProtocol {
    associatedtype TableViewCellType
	static var indentifier: String { get}
    var myType: TableViewCellType { get set }
}
@objc protocol CommonTableViewCellDelegate: NSObjectProtocol {
    @objc optional func commonCell(_ commonCell: CommonTableViewCell, textFieldDidEndEditing textField: UITextField)
    @objc optional func commonCell(_ commonCell: CommonTableViewCell, textFieldShouldBeginEditing textField: UITextField)
    @objc optional func commonCell(_ commonCell: CommonTableViewCell, verificationButtonClick verificationButton: UIButton)
    @objc optional func commonCell(_ commonCell: CommonTableViewCell, arrowCellClick textField: UITextField)
}


@objc protocol ImageTableViewCellDelegate: NSObjectProtocol {
    @objc optional func imageCell(_ imageCell: ImageTableViewCell, imageButtonClick imageButton: UIImageView)
}

@objc protocol ButtonTableViewCellDelegate: NSObjectProtocol {
    @objc optional func buttonCell(_ buttonCell: ButtonTableViewCell, nextButtonClick nextButton: UIButton)
}


protocol ApplyTableViewCellDelegate: CommonTableViewCellDelegate, ImageTableViewCellDelegate, ButtonTableViewCellDelegate {
    
}



class LBMerchantApplyTableViewCell: UITableViewCell {
    var cellType: ApplyTableViewCellType?
    
    weak var delegate: ApplyTableViewCellDelegate?
    
   
    var myCellContent: Any? {
        get {
            guard let cellType = cellType else {
                print("没有初始化cellType")
                return nil
            }
            switch cellType {
            case .common:
                return textFieldText
            case .image:
                return images
            default:
                return nil
            }
        }
        
        set {
            guard let cellType = cellType else {
                print("没有初始化cellType")
                return
            }
            
            switch cellType {
            case .common:
                textFieldText = newValue as? String
            case .image:
                guard let aimages = newValue as? [UIImage?] else {
                    return
                }
                assert(images.count == aimages.count, "不相等")
                for (index, image) in aimages.enumerated() {
                    if let image = image {
                        images[index] = image
                    }
                }
            default:
                break
            }
        }
        
    }
    
    // textField 内部
    var textFieldText: String?
    var images: [UIImage?] = [UIImage]()
    
    var mycontentViewTopConstraint: NSLayoutConstraint?
    /// 最外层view
    let mycontentView: UIView = {
        let mycontentView = UIView()
        return mycontentView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(mycontentView)
        // mycontentView
        ({
            mycontentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[mycontentView]-20-|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: ["mycontentView" : mycontentView]))
            
            let bottomConstraint = NSLayoutConstraint(item: mycontentView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0)
            let topConstraint = NSLayoutConstraint(item: mycontentView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0)
            mycontentViewTopConstraint = topConstraint
            contentView.addConstraints([bottomConstraint, topConstraint])
            }())
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

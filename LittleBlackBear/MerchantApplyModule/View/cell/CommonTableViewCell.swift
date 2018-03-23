//
//  CustomTableViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit


enum CommonTableViewCellType{
	
    case describe(title: String, subtitle: String)
    case describe1(imgName:String,title: String, subtitle: String)
    case tips(title: String, subtitle: String)
    case input0(title: String, placeholder: String)
    case input1(title: String, rightplaceholder: String)
    case input2(placeholder: String)
    case input3(title: String, placeholder: String,constraint:CGFloat)
    case verification(placeholder: String)
}


class CommonTableViewCell: LBMerchantApplyTableViewCell, ApplyTableViewCellProtocol {
	
    
	static var indentifier = "CommonTableViewCell"
	
	let contentSize = CGSize(width: CGFloat(MAXFLOAT) , height: CGFloat(MAXFLOAT))

    var titleLabelWidth: CGFloat {
	
        let text: NSString = "商家基本信息"
		return text.textSizeWith(contentSize: contentSize, font: titleLabel.font).width

    }
	
    var separatorLeftConstraint: NSLayoutConstraint?
    var textFieldRightConstraint: NSLayoutConstraint?
    var textFieldLeftConstraint: NSLayoutConstraint?
    var textFieldType:LBTextFieldType?{
        didSet{
            configTextField(textFieldType!)
        }
    }
    var myType: CommonTableViewCellType = .describe(title: "", subtitle: "") {
        didSet {
            self.cellType = ApplyTableViewCellType.common(myType)

            switch myType {
            case let .describe(title: title, subtitle: subtitle):
                self.descriptionLabel.text(contents: (text: title, font: FONT_28PX), (text: subtitle, font: FONT_24PX))
				descriptionLabel.textColor = COLOR_fc843b
                separatorLeftConstraint?.constant = 0
                show(views: descriptionLabel)
				
            case let .describe1(imgName: imgName, title: title, subtitle: subtitle ):
                self.descriptionLabel.text(contents: (text: title, font: FONT_28PX), (text: subtitle, font: FONT_24PX))
                self.avatarView.image = UIImage(named:imgName)
                separatorLeftConstraint?.constant = 0
                show(views:avatarView, descriptionLabel)
            case let .input0(title: title, placeholder: placeholder):
                titleLabel.text = title
                textField.placeholder = placeholder
                separatorLeftConstraint?.constant = 15
                textFieldLeftConstraint?.constant = 5.0
                textFieldRightConstraint?.constant = 0.0
                titleLabel.alignmentJustify_colon(withWidth: titleLabelWidth)
                show(views: titleLabel, textField)
            case let .tips(title: title, subtitle: subtitle):
                self.descriptionLabel.text(contents: (text: title, font: FONT_24PX), (text: subtitle, font: FONT_24PX))
                separatorLeftConstraint?.constant = 0
                show(views:tipsLabel)
            case let .input1(title: title, rightplaceholder: rightplaceholder):
                titleLabel.text = title
                textField.placeholder = rightplaceholder
                separatorLeftConstraint?.constant = 15
                textFieldLeftConstraint?.constant = 0.0
                textFieldRightConstraint?.constant = -25.0
                textField.textAlignment = NSTextAlignment.right
                titleLabel.alignmentJustify_colon(withWidth: titleLabelWidth)

                show(views: titleLabel, textField, arrowImageView)
            case let .input2(placeholder: placeholder):
                textField.placeholder = placeholder
                separatorLeftConstraint?.constant = 15
                textFieldLeftConstraint?.constant = -titleLabelWidth
                textFieldRightConstraint?.constant = 0.0
                show(views: textField)
            case let .input3(title: title, placeholder: placeholder, constraint: constraint):
                titleLabel.text = title
                textField.placeholder = placeholder
                separatorLeftConstraint?.constant = constraint
                textFieldLeftConstraint?.constant = 0.0
                textFieldRightConstraint?.constant = -35.0
                textField.textAlignment = NSTextAlignment.center
                titleLabel.alignmentJustify_colon(withWidth: titleLabelWidth)
                show(views: titleLabel, textField)
				configTextField()
            case let .verification(placeholder: placeholder):
                textField.placeholder = placeholder
                separatorLeftConstraint?.constant = 15
                textFieldLeftConstraint?.constant = -titleLabelWidth
                textFieldRightConstraint?.constant = -100.0
                show(views: textField, verificationButton)

            }
        }
    }
    
    override var textFieldText: String? {
        didSet {
            textField.text = textFieldText
        }
    }
    
    func show(views: UIView...) {
        for view in mycontentView.subviews {
            if views.contains(view) {
                view.isHidden = false
            }else {
                view.isHidden = true
            }
        }
    }
    let avatarView:UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = COLOR_dadada
        return separatorView
    }()
    

    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        descriptionLabel.backgroundColor = UIColor.red
        descriptionLabel.textColor = COLOR_666666
        descriptionLabel.font = FONT_28PX
        return descriptionLabel
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.backgroundColor = UIColor.green
        titleLabel.textColor = COLOR_222222
        titleLabel.font = FONT_28PX
        return titleLabel
    }()
    let tipsLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = COLOR_222222
        titleLabel.font = FONT_24PX
        return titleLabel
    }()
    let textField: UITextField  = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.backgroundColor = UIColor.blue
        textField.textColor = COLOR_222222
        textField.font = FONT_28PX
        return textField
        }()
    
    let arrowImageView: UIImageView = {
        let arrow = UIImageView(image: UIImage(named: "icon"))
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    let verificationButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("获取验证码", for: .normal)
        btn.backgroundColor = COLOR_1478b8
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = FONT_24PX
        btn.layer.cornerRadius = 5.f
        btn.layer.masksToBounds = true
        return btn
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellHeight = 55.0
        textField.delegate = self
        verificationButton.addTarget(self, action: #selector(CommonTableViewCell.btnClick(btn:)), for: .touchUpInside)
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func btnClick(btn: UIButton) {
        delegate?.commonCell?(self, verificationButtonClick: btn)
    }
    func configTextField(_ type:LBTextFieldType) {
        switch type {
        case .text:
            textField.autocorrectionType = .default
            textField.autocapitalizationType = .sentences
            textField.keyboardType = .default
        case .number:
            textField.keyboardType = .numberPad
        case .numbersAndPunctuation:
            textField.keyboardType = .numbersAndPunctuation
        case .decimal:
            textField.keyboardType = .decimalPad
        case .name:
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .words
            textField.keyboardType = .default
        case .phone:
            textField.keyboardType = .phonePad
        case .namePhone:
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .words
            textField.keyboardType = .namePhonePad
        case .url:
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .URL
        case .twitter:
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .twitter
        case .email:
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .emailAddress
        case .asciiCapable:
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .asciiCapable
        case .password:
            textField.isSecureTextEntry = true
            textField.clearsOnBeginEditing = false
        default:
            break
        }
    }
    

}

// MARK: - UITextFieldDelegate
extension CommonTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.commonCell?(self, textFieldDidEndEditing: textField)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.commonCell?(self, textFieldShouldBeginEditing: textField)
        switch myType {
        case .input1:
            delegate?.commonCell?(self, arrowCellClick: textField)
            return false
        default:
            return true
        }
                
    }
}


// MARK: - UI
extension CommonTableViewCell {
	func configTextField() {
		let rightView = UIImageView(image: UIImage(named: "selectorImg"))
		textField.layer.borderColor = COLOR_dadada.cgColor
		textField.layer.borderWidth = 0.5
		textField.rightView = rightView
		textField.rightViewMode = .always
	}
    fileprivate func setupUI() {
        
        contentView.addSubview(separatorView)
        mycontentView.addSubview(avatarView)
        mycontentView.addSubview(descriptionLabel)
        mycontentView.addSubview(titleLabel)
        mycontentView.addSubview(tipsLabel)
        mycontentView.addSubview(textField)
        mycontentView.addSubview(arrowImageView)
        mycontentView.addSubview(verificationButton)

                
        // separatorView
        ({
            let leftConstraint = NSLayoutConstraint(item: separatorView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0)
            separatorLeftConstraint = leftConstraint
            let rightConstraint = NSLayoutConstraint(item: separatorView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0)
            let bottomConstraint = NSLayoutConstraint(item: separatorView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0)
            let heightConstraint = NSLayoutConstraint(item: separatorView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 1.0)
            separatorView.addConstraint(heightConstraint)
            contentView.addConstraints([leftConstraint, rightConstraint, bottomConstraint])
            }())
        // avatarView
        ({
            let leftConstraint = NSLayoutConstraint(item: avatarView, attribute: .left, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0)
            let centerYConstraint = NSLayoutConstraint(item: avatarView, attribute: .centerY, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
            let widthConstraint = NSLayoutConstraint(item: avatarView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 21)
            let HeightConstraint = NSLayoutConstraint(item: avatarView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 21)
            mycontentView.addConstraints([leftConstraint,widthConstraint,HeightConstraint,centerYConstraint])
            
        }())
        // descriptionLabel
        ({
            let leftConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: avatarView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 5.0)
            let rightConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0)
            let centerYConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
            mycontentView.addConstraints([leftConstraint, rightConstraint, centerYConstraint])
            }())
        
        
        // titleLabel
        ({
            let leftConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0)
            let centerYConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
            mycontentView.addConstraints([leftConstraint, centerYConstraint])
            }())
        // tipsLabel
        ({
            
            let leftConstraint = NSLayoutConstraint(item: tipsLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0)
            let centerYConstraint = NSLayoutConstraint(item: tipsLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
            let widthConstraint = NSLayoutConstraint(item: tipsLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: titleLabelWidth + 0.5)
            mycontentView.addConstraints([leftConstraint, centerYConstraint])
            tipsLabel.addConstraint(widthConstraint)
            }())
        // textField
        ({
            let leftConstraint = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0)
            textFieldLeftConstraint = leftConstraint
            let rightConstraint = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0)
            textFieldRightConstraint = rightConstraint
			let textFieldHeight = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30)
            let centerYConstraint = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
            mycontentView.addConstraints([leftConstraint, rightConstraint, centerYConstraint,textFieldHeight])
            }())
		
        // arrowImageView
        ({
            let rightConstraint = NSLayoutConstraint(item: arrowImageView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -2.0)
            let centerYConstraint = NSLayoutConstraint(item: arrowImageView , attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
            mycontentView.addConstraints([rightConstraint, centerYConstraint])
            }())
        // verificationButton
        ({
            let widthConstraint = NSLayoutConstraint(item: verificationButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 80)
            let heightConstraint = NSLayoutConstraint(item: verificationButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 27)
            let rightConstraint = NSLayoutConstraint(item: verificationButton, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -3.0)
            let centerYConstraint = NSLayoutConstraint(item: verificationButton , attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
            verificationButton.addConstraints([widthConstraint, heightConstraint])
            mycontentView.addConstraints([rightConstraint, centerYConstraint])
            }())
    }
}

//
//  LBInputTableViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/29.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit


@objc protocol LBInputTableViewCellDelegate: NSObjectProtocol {
    @objc optional func input(_ cell: UITableViewCell, textFieldDidEndEditing textField: UITextField)
    @objc optional func input(_ cell: UITableViewCell, textFieldShouldBeginEditing textField: UITextField)
    @objc func input(_ cell: UITableViewCell,_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    @objc optional func input(_ cell: UITableViewCell, verificationButtonClick verificationButton: UIButton)
    @objc optional func input(_ cell: UITableViewCell, commitButtonClick commitButton: UIButton)
    
}

class LBInputTableViewCell: UITableViewCell{
    
    var delegate:LBInputTableViewCellDelegate?
    
    var textFieldType:LBTextFieldType?{
        didSet{
            configTextField(textFieldType!)
        }
    }
    
    var cellType:LBInputType = .input(label:"" , placeHolder: ""){
        didSet{
            switch cellType {
            case let .input(label: text , placeHolder: placeHolder):
                label.text = text
                textField.placeholder = placeHolder
                _textFieldRightConstraint?.constant = 0
                
                show(views:label,textField)
            case let .button(title: title, height: height):
                commitButton.setTitle(title, for: .normal)
                buttonHeightConstract?.constant = height
                show(views: commitButton)
            }
            
        }
    }
    var myCellContent: Any? {
        get {
            switch cellType {
            case .input(label: _, placeHolder: _):
                return textFieldText
            default:
                return nil
            }
        }
        set {
            switch cellType {
            case.input(label: _, placeHolder: _):
                textFieldText = newValue as? String
            default:
                break
            }
        }
        
    }
    var textFieldText: String? {
        didSet {
            textField.text = textFieldText
        }
    }
    fileprivate var buttonHeightConstract: NSLayoutConstraint?
    fileprivate var _textFieldRightConstraint: NSLayoutConstraint?
    
    let textField = UITextField()
    let label = UILabel()
    let verificationButton = UIButton()
    let commitButton = UIButton()
    
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
        textField.delegate = self
        verificationButton.addTarget(self , action: #selector(sendVerifiCodeAction(_ :)), for: .touchUpInside)
        commitButton.addTarget(self, action: #selector(clickCommitBtnAction(_ :)), for: .touchUpInside)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        
        contentView.addSubview(textField)
        contentView.addSubview(label)
        contentView.addSubview(verificationButton)
        contentView.addSubview(commitButton)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        verificationButton.translatesAutoresizingMaskIntoConstraints = false
        commitButton.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = FONT_28PX
        label.textColor = COLOR_222222
        
        textField.font = FONT_28PX
        textField.textColor = COLOR_999999
        
        verificationButton.setTitleColor(UIColor.white, for: .normal)
        verificationButton.titleLabel?.font = FONT_32PX
        verificationButton.setTitle("获取验证码", for: .normal)
        verificationButton.backgroundColor = COLOR_f2808a
        
        commitButton.titleLabel?.font = FONT_32PX
        commitButton.backgroundColor = COLOR_f2808a
        
        
        contentView.addConstraint(BXLayoutConstraintMake(label,.left,.equal,contentView,.left,20*AUTOSIZE_X))
        contentView.addConstraint(BXLayoutConstraintMake(label,.centerY,.equal,contentView,.centerY))
        
        contentView.addConstraint(BXLayoutConstraintMake(textField, .left, .equal,label,.right,5))
        contentView.addConstraint(BXLayoutConstraintMake(textField, .height,.equal,contentView,.height))
        contentView.addConstraint(BXLayoutConstraintMake(textField, .centerY, .equal,contentView,.centerY))
        
        contentView.addConstraint(BXLayoutConstraintMake(verificationButton, .width,.equal,nil,.width,100*AUTOSIZE_X))
        contentView.addConstraint(BXLayoutConstraintMake(verificationButton, .centerY, .equal,contentView,.centerY))
        contentView.addConstraint(BXLayoutConstraintMake(verificationButton, .height,.equal,contentView,.height))
        contentView.addConstraint(BXLayoutConstraintMake(verificationButton, .right,.equal,contentView,.right))
        
        contentView.addConstraint(BXLayoutConstraintMake(commitButton, .width,.equal,nil,.width,200))
        contentView.addConstraint(BXLayoutConstraintMake(commitButton, .centerY, .equal,contentView,.centerY))
        contentView.addConstraint(BXLayoutConstraintMake(commitButton, .centerX, .equal,contentView,.centerX))
        contentView.addConstraint(BXLayoutConstraintMake(commitButton, .height,.equal,nil,.height,45))
        
    }
    func show(views: UIView...) {
        for view in contentView.subviews {
            if views.contains(view) {
                view.isHidden = false
            }else {
                view.isHidden = true
            }
        }
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
    
    func sendVerifiCodeAction(_ button:UIButton){
        delegate?.input!(self, verificationButtonClick: button)
    }
    func clickCommitBtnAction(_ button:UIButton){
        delegate?.input!(self, commitButtonClick: button)
    }
}

extension LBInputTableViewCell:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return (delegate?.input(self, textField, shouldChangeCharactersIn: range, replacementString: string))!
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.input!(self, textFieldDidEndEditing: textField)
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

//
//  LBModifyBankCardCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/4.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
protocol LBModifyBankCardCellDelegate: NSObjectProtocol {
    func modify(_ cell: LBModifyBankCardCell, textFieldDidEndEditing textField: UITextField)
    func modify(_ cell: LBModifyBankCardCell, textFieldShouldBeginEditing textField: UITextField)
    func modify(_ cell: LBModifyBankCardCell,_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    func modify(_ cell: LBModifyBankCardCell, commitButtonClick button: UIButton)
    
}
enum LBModifyBankCellType {
    case title_label(String)
    case textField(String,String)
    case button(title:String,height:CGFloat)
}
class LBModifyBankCardCell: UITableViewCell{
    
    var delegate:LBModifyBankCardCellDelegate?
    
    var textFieldType:LBTextFieldType?{
        didSet{
            configTextField(textFieldType!)
        }
    }
    
    var selfType:LBModifyBankCellType = .textField("" , ""){
        didSet{
            switch selfType {
            case .title_label(let text):
                titleLabel.text = text
                show(views:titleLabel)
            case .textField(let text,let placeHolder):
                label.text = text
                textField.placeholder = placeHolder
                _textFieldRightConstraint?.constant = 0
                show(views:label,textField)
            case let .button(title:title,height:height):
                button.setTitle(title, for: .normal)
                buttonHeightConstract?.constant = height
                show(views: button)
            }
            
        }
    }
    
    var myCellContent: Any? {
        get {
            switch selfType {
            case .textField( _, _):
                return textFieldText
            default:
                return nil
            }
        }
        set {
            switch selfType {
            case.textField( _, _):
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
    
    private var buttonHeightConstract: NSLayoutConstraint?
    private var _textFieldRightConstraint: NSLayoutConstraint?
    
    private let titleLabel = UILabel()
    private let label = UILabel()
    private let textField = UITextField()
    private let button = UIButton()
    
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
        button.addTarget(self, action: #selector(clickCommitBtnAction(_ :)), for: .touchUpInside)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(label)
        contentView.addSubview(textField)
        contentView.addSubview(button)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = FONT_28PX
        titleLabel.textColor = COLOR_222222
        
        label.font = FONT_28PX
        label.textColor = COLOR_222222
        
        textField.font = FONT_28PX
        textField.textColor = COLOR_999999
        
        
        button.titleLabel?.font = FONT_32PX
        button.backgroundColor = COLOR_f2808a
        
        
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel,.left,.equal,contentView,.left,20*AUTOSIZE_X))
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel,.centerY,.equal,contentView,.centerY))
        
        contentView.addConstraint(BXLayoutConstraintMake(label,.left,.equal,contentView,.left,20*AUTOSIZE_X))
        contentView.addConstraint(BXLayoutConstraintMake(label,.centerY,.equal,contentView,.centerY))
        
        contentView.addConstraint(BXLayoutConstraintMake(textField, .left, .equal,label,.right,5))
        contentView.addConstraint(BXLayoutConstraintMake(textField, .height,.equal,contentView,.height))
        contentView.addConstraint(BXLayoutConstraintMake(textField, .centerY, .equal,contentView,.centerY))
        
        contentView.addConstraint(BXLayoutConstraintMake(button, .width,.equal,nil,.width,200))
        contentView.addConstraint(BXLayoutConstraintMake(button, .centerY, .equal,contentView,.centerY))
        contentView.addConstraint(BXLayoutConstraintMake(button, .centerX, .equal,contentView,.centerX))
        contentView.addConstraint(BXLayoutConstraintMake(button, .height,.equal,nil,.height,45))
        
    }
    
    private func show(views: UIView...) {
        for view in contentView.subviews {
            if views.contains(view) {
                view.isHidden = false
            }else {
                view.isHidden = true
            }
        }
    }
    
    private func configTextField(_ type:LBTextFieldType) {
        switch type {
        case .text:
            textField.autocorrectionType = .default
            textField.autocapitalizationType = .sentences
            textField.keyboardType = .default
        case .number:
            textField.keyboardType = .numberPad
        default:
            break
        }
    }
    
    func clickCommitBtnAction(_ button:UIButton){
        delegate?.modify(self, commitButtonClick: button)
    }
    
}

extension LBModifyBankCardCell:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return (delegate?.modify(self, textField, shouldChangeCharactersIn: range, replacementString: string))!
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.modify(self  , textFieldDidEndEditing: textField)
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

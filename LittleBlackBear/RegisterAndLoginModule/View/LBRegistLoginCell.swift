//
//  LBRegistAndLoginCell.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/23.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

@objc protocol LBRegistLoginCellDelegate: NSObjectProtocol {
    @objc optional func registLoginCell(registLogin cell: LBRegistLoginCell, textFieldDidEndEditing textField: UITextField)
    @objc optional func registLoginCell(registLogin cell: LBRegistLoginCell, textFieldShouldBeginEditing textField: UITextField)
    @objc func registLoginCell(registLogin cell: LBRegistLoginCell,_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    @objc optional func registLoginCell(registLogin cell: LBRegistLoginCell, verificationButtonClick verificationButton: SMSButton)
    @objc optional func registLoginCell(registLogin cell: LBRegistLoginCell, commitButtonClick commitButton: UIButton)
    
}
class LBRegistLoginCell: UITableViewCell{
    
    var delegate:LBRegistLoginCellDelegate?
    
    var textFieldType:LBTextFieldType?{
        didSet{
			configTextField(textFieldType!)
        }
    }
    var selfType:LBRegistLoginCellType = .input(imgName:"" , placeHolder: ""){
        didSet{
            switch selfType {
            case let .input(imgName: imgName , placeHolder: placeHolder):
                _imageView.image = UIImage(named:imgName)
                textField.placeholder = placeHolder
				_textFieldRightConstraint?.constant = 0
				configContentView()
				show(views: _imageView,textField)
            case let .verifInput(imgName: imgName, placeHolder: placeHolder):
                _imageView.image = UIImage(named:imgName)
                textField.placeholder = placeHolder
				_textFieldRightConstraint?.constant = -100*AUTOSIZE_X
				configContentView()
				show(views: _imageView,textField,verificationButton)
            case let .button(title: title, height: height):
                commitButton.setTitle(title, for: .normal)
                buttonHeightConstract?.constant = height
                show(views: commitButton)
            }

        }
    }
    var myCellContent: Any? {
        get {
            switch selfType {
            case .input(imgName: _, placeHolder: _), .verifInput(imgName: _, placeHolder: _):
                return textFieldText
            default:
                return nil
            }
        }
        set {
            switch selfType {
            case.input(imgName: _, placeHolder: _), .verifInput(imgName: _, placeHolder: _):
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
    
    var clickPrivateDetailBtn:((UIButton)->())?
    var clickPrivateBtn:((UIButton)->())?
    
    fileprivate var buttonHeightConstract: NSLayoutConstraint?
	fileprivate var _textFieldRightConstraint: NSLayoutConstraint?
    
    fileprivate let _contentView = UIView()
    fileprivate let textField = UITextField()
    fileprivate let _imageView = UIImageView()
    fileprivate let verificationButton = SMSButton()
    fileprivate let commitButton = UIButton()

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
    
	func configContentView() {
		_contentView.layer.cornerRadius = 2
		_contentView.layer.masksToBounds = true
		_contentView.layer.borderWidth = 0.5
		_contentView.layer.borderColor = COLOR_99aab5.cgColor
	}
    
    private	func setupUI() {
        
        contentView.addSubview(_contentView)
        _contentView.addSubview(textField)
        _contentView.addSubview(_imageView)
        _contentView.addSubview(verificationButton)
        _contentView.addSubview(commitButton)

        _contentView.translatesAutoresizingMaskIntoConstraints = false
        _imageView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        verificationButton.translatesAutoresizingMaskIntoConstraints = false
        commitButton.translatesAutoresizingMaskIntoConstraints = false

        
        textField.font = FONT_30PX
        textField.textColor = COLOR_999999
        
        verificationButton.setTitleColor(UIColor.white, for: .normal)
        verificationButton.titleLabel?.font = FONT_32PX
        verificationButton.setTitle("获取验证码", for: .normal)
        verificationButton.backgroundColor = COLOR_f2808a
		
		commitButton.titleLabel?.font = FONT_32PX
		commitButton.backgroundColor = COLOR_f2808a
        commitButton.layer.cornerRadius = 2
        commitButton.layer.masksToBounds = true 
        
        commitButton.tag = 0
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-40-[_contentView]-40-|",
                                                                  options: NSLayoutFormatOptions(rawValue:0),
                                                                  metrics: nil,
                                                                  views: ["_contentView":_contentView]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[_contentView(45)]|",
                                                                  options: NSLayoutFormatOptions(rawValue:0),
                                                                  metrics: nil,
                                                                  views: ["_contentView":_contentView]))
        
        //_imageView
        ({
            _contentView.addConstraint(BXLayoutConstraintMake(_imageView, .left, .equal,_contentView,.left,21*AUTOSIZE_X))
            _contentView.addConstraint(BXLayoutConstraintMake(_imageView, .centerY, .equal,_contentView,.centerY))
            _contentView.addConstraint(BXLayoutConstraintMake(_imageView, .width, .equal,nil,.width,17*AUTOSIZE_X))
            _contentView.addConstraint(BXLayoutConstraintMake(_imageView, .height, .equal,nil,.height,17*AUTOSIZE_Y))
        }())
        //textField
        ({
            _contentView.addConstraint(BXLayoutConstraintMake(textField, .left, .equal,_imageView,.right,17*AUTOSIZE_X))
            _contentView.addConstraint(BXLayoutConstraintMake(textField, .height,.equal,_contentView,.height))
			_contentView.addConstraint(BXLayoutConstraintMake(textField, .centerY, .equal,_contentView,.centerY))

			let textFieldRightConstraint = BXLayoutConstraintMake(textField, .right, .equal,_contentView,.right )
			_textFieldRightConstraint = textFieldRightConstraint
			_contentView.addConstraint(textFieldRightConstraint)
            }())

        //verificationButton
        ({
            _contentView.addConstraint(BXLayoutConstraintMake(verificationButton, .width,.equal,nil,.width,100*AUTOSIZE_X))
            _contentView.addConstraint(BXLayoutConstraintMake(verificationButton, .centerY, .equal,_contentView,.centerY))
            _contentView.addConstraint(BXLayoutConstraintMake(verificationButton, .height,.equal,_contentView,.height))
			_contentView.addConstraint(BXLayoutConstraintMake(verificationButton, .right,.equal,_contentView,.right))

        }())
        
        //commitButton
        ({
            _contentView.addConstraint(BXLayoutConstraintMake(commitButton, .width,.equal,_contentView,.width))
            _contentView.addConstraint(BXLayoutConstraintMake(commitButton, .centerY, .equal,_contentView,.centerY))
            _contentView.addConstraint(BXLayoutConstraintMake(commitButton, .centerX, .equal,_contentView,.centerX))
            _contentView.addConstraint(BXLayoutConstraintMake(commitButton, .height,.equal,_contentView,.height))
            }())
	
        
    }
    func show(views: UIView...) {
        for view in _contentView.subviews {
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
    
    func sendVerifiCodeAction(_ button:SMSButton){
        guard let delegate = delegate else {return}
        delegate.registLoginCell!(registLogin: self, verificationButtonClick: button)
    }
    
    func clickCommitBtnAction(_ btn:UIButton){
        guard let delegate = delegate else {return}
		delegate.registLoginCell!(registLogin: self, commitButtonClick: btn)
    }
}

extension LBRegistLoginCell:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return (delegate?.registLoginCell(registLogin: self, textField, shouldChangeCharactersIn: range, replacementString: string))!
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let delegate = delegate else {return}
		delegate.registLoginCell!(registLogin: self, textFieldDidEndEditing: textField)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}






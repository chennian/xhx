//
//  LBShoppingSearchBar.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/6.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBShoppingSearchBar: UIView {

    var clickLocationBtnAction:((_ btn:UIButton)->Void)?
    var searchAction:((_ text:String)->Void)?
    var buttonWConstraint:NSLayoutConstraint?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 44)
        self.backgroundColor = UIColor.white
        setupUI()
        setupConstraint()
        btn.addTarget(self, action: #selector(clickLocationBtnAction(_ :)), for: .touchUpInside)
        searchField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let btn = UIButton()
    private let searchField:LBSearchField = {
        let field = LBSearchField()
        field.backgroundColor = COLOR_f2f2f2
        field.keyboardType = .webSearch
        field.placeholder = "输入商家商品搜索"
        field.font = FONT_30PX
        field.textColor = COLOR_7f7f7f
        field.layer.cornerRadius = 5
        field.layer.masksToBounds = true
        let imgView = UIImageView(image: UIImage(named:"searchIcon"))
        field.rightView = imgView
        field.rightViewMode = .always
        field.leftView = UIView()
        field.leftViewMode = .always
        return field
    }()
    let line = UIView()
    
    func setupUI(){
        
        addSubview(btn)
        addSubview(searchField)
        addSubview(line)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        searchField.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -5)
        btn.titleLabel?.font = FONT_30PX
        btn.setTitleColor(COLOR_222222, for: .normal)
        btn.titleLabel?.textAlignment = .left
        btn.setImage(UIImage(named:"locationMark"), for: .normal)
        var city:String = LBKeychain.get(LOCATION_CITY_KEY)
        if city.count ==  0 {
            city = "定位"
        }
        buttonWConstraint?.constant = city.width(15) + 15
        btn.setTitle(city, for: .normal)
        line.backgroundColor = COLOR_e6e6e6
        
    }
        
    func setupConstraint() {
        
        addConstraint(BXLayoutConstraintMake(searchField, .right, .equal,self,.right,-10))
        addConstraint(BXLayoutConstraintMake(searchField, .bottom, .equal,self,.bottom,-10))
        addConstraint(BXLayoutConstraintMake(searchField, .height, .equal,nil,.height,30))
        addConstraint(BXLayoutConstraintMake(searchField, .left, .equal,btn,.right,5))
        
        addConstraint(BXLayoutConstraintMake(btn, .left, .equal,self,.left,15))
        addConstraint(BXLayoutConstraintMake(btn, .centerY, .equal,searchField,.centerY))
        let btnWidthConstraint = BXLayoutConstraintMake(btn, .width, .equal,nil,.width,80)
        buttonWConstraint = btnWidthConstraint
        btn.addConstraint(btnWidthConstraint)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|",
                                                      options: NSLayoutFormatOptions(rawValue:0),
                                                      metrics: nil,
                                                      views: ["line":line]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-44-[line(0.5)]|",
                                                      options: NSLayoutFormatOptions(rawValue:0),
                                                      metrics: nil,
                                                      views: ["line":line]))
        
    }
    
    
    func clickLocationBtnAction(_ btn:UIButton)  {
        guard let action = clickLocationBtnAction else {return}
        action(btn)
    }

}
extension LBShoppingSearchBar:UITextFieldDelegate{
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true 
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let action = searchAction  else{return}
        action(textField.text!)
    }
}


class LBSearchField: UITextField {
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        super.rightViewRect(forBounds: bounds)
        return CGRect(x: self.width-15-20, y: (self.height-16)/2, width: 15, height: 16)
    }
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        super.leftViewRect(forBounds: bounds)
        return CGRect(x: 10, y: 0, width: 20, height: 30)

    }
}











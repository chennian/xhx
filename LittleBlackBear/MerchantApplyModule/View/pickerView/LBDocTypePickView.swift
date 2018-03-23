//
//  LBDocTypePickView.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/6.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBDocTypePickView: UIView {
    var dissMissIndustryPickerViewAction: (()->())?
    var didSelectRowWithValue:((_ value:String)->())?
    fileprivate var List:[String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subViewInit()
        loadBankTotalData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var pickerView: UIPickerView! = { [unowned self] in
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 216))
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        return picker
        }()
    
    func subViewInit()  {
        addSubview(pickerView)
    }
    func loadBankTotalData(){
        List = ["中国居民身份证","香港居民身份证","澳门居民身份证","台湾居民身份证"]
    }
    
}
extension LBDocTypePickView:UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if List.count > 0 {
            return List.count
        }else{
            return 0
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if List.count > 0 && row <= List.count {
            if (self.didSelectRowWithValue != nil) {
                self.didSelectRowWithValue!(self.List[row])
            }
            return (self.List[row])
            
        }else{
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if List.count > 0 && row <= List.count {
            
            if (self.didSelectRowWithValue != nil) {
                self.didSelectRowWithValue!(self.List[row])
            }
            
        }
        pickerView.reloadAllComponents()
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = pickerView.delegate?.pickerView!(pickerView, titleForRow: row, forComponent: component)
        let size:CGSize = (label.text?.getSize(14))!
        label.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        return label
    }

}

//
//  BXBankTotalPickView.swift
//  BaiXiangPay
//
//  Created by 蘇崢 on 2017/5/3.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit


class LBBankTotalPickView: UIView {
	
	var dissMissIndustryPickerViewAction: (()->())?	
	var didSelectRowWithValue:((_ id:String,_ value2:String)->())?
	fileprivate var List = [LBJSON]()
	
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
        LBHttpService.LB_Request(.merRecBankTotal, method: .post, parameters: lb_md5Parameter(), headers: nil, success: { [weak self](json) in
            guard let strongSelf = self else{return}
            strongSelf.List = json["bankTotal"].arrayValue
            Print(json["bankTotal"])
            }, failure: { (failure) in
            
        }) { (error) in
            
        }
	}
	
}
extension LBBankTotalPickView:UIPickerViewDelegate,UIPickerViewDataSource{
	
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
			let dictionary = self.List[row]
			if (self.didSelectRowWithValue != nil) {
				self.didSelectRowWithValue!(dictionary["banktotalid"].stringValue,dictionary["banktotalname"].stringValue)
			}
			return dictionary["banktotalname"].stringValue
			
		}else{
			return ""
		}
		
	}
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
		if List.count > 0 && row <= List.count {
			
			let dictionary = self.List[row]
			if (self.didSelectRowWithValue != nil) {
				self.didSelectRowWithValue!( dictionary["banktotalid"].stringValue, dictionary["banktotalname"].stringValue)
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


//
//  BXIndustryPickerView.swift
//  BaiXiangPay
//
//  Created by 蘇崢 on 2017/5/2.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBIndustryPickerView: UIView {
		
	var dissMissIndustryPickerViewAction: (()->())?
	var didSelectRowWithValue:((_ value1:String,_ value2:String)->())?
	var IndustryDetailPickView:((_ list:[LBJSON])->())?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		subViewInit()
		loadIndustryData()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    var fistComponentList = [LBJSON]()
    var secondComponentList = [LBJSON]()

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

}
extension LBIndustryPickerView{
    func loadIndustryData() {
        LBHttpService.LB_Request(.industryType_selectAll, method: .post, parameters: lb_md5Parameter(), headers: nil, success: { [weak self](json) in
            guard let strongSelf = self else{return}
            strongSelf.fistComponentList = json["list"].arrayValue
        }, failure: { (failItem) in
            UIAlertView(title: "提示", message: failItem.message, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定" ).show()
        }) { _ in}
    }
}
extension LBIndustryPickerView:UIPickerViewDelegate,UIPickerViewDataSource{

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 2
	}
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		
		if component == 0 {
			return fistComponentList.count
		}else{
			let selectedFirstRow:Int = pickerView.selectedRow(inComponent: 0)
			guard selectedFirstRow < fistComponentList.count else{return fistComponentList.count}
			self.secondComponentList = fistComponentList[selectedFirstRow]["list"].arrayValue
			return self.secondComponentList.count
		}
	}
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		if component == 0 {
			return self.fistComponentList[row]["name"].stringValue
		}else{
			let selectedFirstRow:Int = pickerView.selectedRow(inComponent: 0)
			self.secondComponentList = self.fistComponentList[selectedFirstRow]["list"].arrayValue
            var  dictionary:LBJSON?
			if row < self.secondComponentList.count {
                dictionary = self.secondComponentList[row]
			}
			if (self.IndustryDetailPickView != nil && dictionary != nil) {
                self.IndustryDetailPickView!((dictionary?["list"].arrayValue)!)
			}
			return dictionary?["name"].stringValue
		}
	}
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		guard fistComponentList.count > 0 else{return}
		var itemOneItem:LBJSON?
		var itemSecondName:String = ""
		
		if component == 0 {
			itemOneItem = self.fistComponentList[row]
			pickerView.reloadComponent(1)
			pickerView.selectRow(0, inComponent: 1, animated: true)
		}
		let selectedFirstRow = pickerView.selectedRow(inComponent: 0)
		let selectedSecondRow = pickerView.selectedRow(inComponent: 1)
		self.secondComponentList = self.fistComponentList[selectedFirstRow]["list"].arrayValue
		itemSecondName = self.secondComponentList[0]["name"].stringValue

		if component == 1 {
			itemOneItem = self.fistComponentList[selectedFirstRow]
			self.secondComponentList = self.fistComponentList[selectedFirstRow]["list"].arrayValue
			itemSecondName = self.secondComponentList[selectedSecondRow]["name"].stringValue
		}
		if (self.didSelectRowWithValue != nil) {
			self.didSelectRowWithValue!( itemOneItem?["name"].stringValue ?? "", itemSecondName)
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


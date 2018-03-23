//
//  BXDatePickView.swift
//  BaiXiangPay
//
//  Created by 蘇崢 on 2017/5/19.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class BXDatePickView: UIView {
	
	var yearSelected:Int = 0
	var monthSelected:Int = 0
	
	var dissMissIndustryPickerViewAction: (()->())?
	var didSelectRowWithValue:((_ value1:String,_ value2:String)->())?
	fileprivate var provinceArray:[[String:Any]] = [[String:Any]]()
	fileprivate var cityArray:[[String:Any]] = [[String:Any]]()
	fileprivate var selectDictionary:[String:Any] = [String:Any]()
	fileprivate var provinceName:String = ""
	fileprivate var cityName:String = ""
	fileprivate var cityItem:[String:Any] = [String:Any]()
	
	fileprivate let toolbar: ToolBarView! = ToolBarView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 44.0))
	fileprivate lazy var pickerView: UIPickerView! = { [unowned self] in
		let picker = UIPickerView(frame: CGRect(x: 0, y: 44, width: KSCREEN_WIDTH, height: 216))
		picker.delegate = self
		picker.dataSource = self
		picker.backgroundColor = UIColor.white
		let now  = Date()
		let calendar = Calendar.current
		let unitFlags:Set<Calendar.Component> = [.year , .month , .day , .hour , .minute]
		let dd = calendar.dateComponents(unitFlags, from: now)
		let year = dd.year
		let month = dd.month
		let day = dd.day
		picker.selectRow(year! - 2015, inComponent: 0, animated: true)
		picker.selectRow(month! - 1, inComponent: 1, animated: true)
//		picker.selectRow(day! - 1, inComponent: 2, animated: true)
		return picker
		
		}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		subViewInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

	func subViewInit()  {
		addSubview(toolbar)
		addSubview(pickerView)
		toolbar.delegate = self
	}
	
}
extension BXDatePickView:UIPickerViewDelegate,UIPickerViewDataSource{
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 2
	}
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		switch component {
		case 0:
			return 100
		case 1:
			return 12
//		case 2:
//			yearSelected = pickerView.selectedRow(inComponent: 0) + 2015
//			monthSelected = pickerView.selectedRow(inComponent: 1) + 1
//			if monthSelected == 2 && monthSelected % 4 == 0 && yearSelected % 100 != 0 {
//				return 29
//			}else if (monthSelected == 2 ){return 28}
//			else if (monthSelected == 1 || monthSelected == 3 || monthSelected == 5 || monthSelected == 7 || monthSelected == 8 || monthSelected == 10 || monthSelected == 12){return 31}
//			else { return 30}
		default:return 0
			
		}
	}
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		switch component {
		case 0: return "\(row + 2015)年"
		case 1:
			if (row + 1 < 10){
				return "0\(row + 1)月"
			}else{
				return "\(row + 1)月"
			}
//		case 2: return "\(row + 1)日"
		default:return ""
		}
	}
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
		switch component {
		case 0:pickerView.reloadComponent(1)
		case 2:pickerView.reloadComponent(1)
		default:break
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
extension BXDatePickView:ToolBarViewDelegate{
	
	func dissMissPickView() {
		if (self.dissMissIndustryPickerViewAction != nil) {
			self.dissMissIndustryPickerViewAction!()
		}
		if (didSelectRowWithValue != nil) {
			let yearArray = pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)!.components(separatedBy: "年")
			
			let monthList = pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 1), forComponent: 1)!.components(separatedBy: "月")
//			let dayList = pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 2), forComponent: 2)!.components(separatedBy: "日")
			
			didSelectRowWithValue!("\(yearArray.first ?? "")","\(monthList.first ?? "")")
		}
	}
}

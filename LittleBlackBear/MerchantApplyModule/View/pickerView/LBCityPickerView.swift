//
//  BXCityPickerView.swift
//  BaiXiangPay
//
//  Created by 蘇崢 on 2017/5/3.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBCityPickerView: UIView {
	
	var dissMissIndustryPickerViewAction: (()->())?
	var didSelectRowWithValue:((_ value1:String,_ value2:String)->())?
	fileprivate var provinceArray:[[String:Any]] = [[String:Any]]()
	fileprivate var cityArray:[[String:Any]] = [[String:Any]]()
	fileprivate var selectDictionary:[String:Any] = [String:Any]()
	fileprivate var provinceName:String = ""
	fileprivate var cityName:String = ""
	fileprivate var cityItem:[String:Any] = [String:Any]()

	fileprivate lazy var pickerView: UIPickerView! = { [unowned self] in
		let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 216))
		picker.delegate = self
		picker.dataSource = self
		picker.backgroundColor = UIColor.white
		return picker
		}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		subViewInit()
		loadCityData()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

	
	func subViewInit()  {
		addSubview(pickerView)
		
		
	}
	func loadCityData(){
		
		let path = Bundle.main.path(forResource: "cityDataList", ofType: "json")
		guard (path != nil) else {
			Print("Error finding file")
			return
		}
		do {
			//将获得json数据转换为data格式数据
			let data: NSData? = NSData(contentsOfFile: path!)
			//将data序列化，并且判断是否属于字典类型数据结构
			if let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
				
				let dataList:[[String:Any]] = jsonResult["dataList"] as! [[String:Any]]
				provinceArray = dataList
				selectDictionary = dataList[0]
				provinceName = selectDictionary["privinceName"] as! String
				if !selectDictionary.isEmpty {
					cityArray = selectDictionary["citys"] as! [[String : Any]]
					cityName = cityArray[0]["cityName"] as! String
					cityItem = cityArray[0]
				}
				
			}
		} catch let error as NSError {
			Print("Error:\n \(error)")
			return
		}
		
	}

}
extension LBCityPickerView:UIPickerViewDelegate,UIPickerViewDataSource{
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 2
	}
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		
		if component == 0 {
			return provinceArray.count
		}else{
			return self.cityArray.count
		}
	}
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		if component == 0 {
			if row < provinceArray.count {
				let provinceDictionary:[String:Any] = provinceArray[row]
				
				if !provinceDictionary.isEmpty {
					provinceName = (provinceDictionary["privinceName"] as? String)!
				}

			}
			return provinceName
		}else{
			if row < cityArray.count {
				let cityDictionary:[String:Any] = cityArray[row]
				
				if !cityDictionary.isEmpty {
					cityName = (cityDictionary["cityName"] as? String)!
				}
				
			}
			return cityName
		}

	}
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
		if component == 0 {
			if row < provinceArray.count {
				provinceName = (provinceArray[row]["privinceName"] as? String)!
				selectDictionary = provinceArray[row]
			}
			if selectDictionary.isEmpty {
					cityArray = []
			}else{
				cityArray = selectDictionary["citys"] as! [[String : Any]]
			}
			pickerView.reloadComponent(1)
			pickerView.selectRow(0, inComponent: 1, animated: true)
			cityItem = cityArray[0]
		}
		if component == 1 {
			cityName = (cityArray[row]["cityName"] as? String)!
			cityItem = cityArray[0]
		}
		if (didSelectRowWithValue != nil) {
			didSelectRowWithValue!(provinceName,cityName)
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


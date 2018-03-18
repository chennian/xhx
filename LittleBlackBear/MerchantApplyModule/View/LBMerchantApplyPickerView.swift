//
//  LBMerchantApplyPickerView.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias ConfirmHandle = (String, String) -> ()
class ApplyPickerViewConfig {
    var isTapDismiss: Bool
    var pickerHeight: CGFloat
    
    init(_ pickerHeight: CGFloat = 260.f, _ isTapDismiss: Bool = true) {
        self.isTapDismiss = isTapDismiss
        self.pickerHeight = pickerHeight
    }
}

class LBMerchantApplyPickerView {
    
    static let tapGes = UITapGestureRecognizer(target: LBMerchantApplyPickerView.self, action: #selector(LBMerchantApplyPickerView.dismiss))
    static let window: UIWindow = {
        let w = UIWindow(frame: UIScreen.main.bounds)
        w.backgroundColor = UIColor.clear
        w.windowLevel = UIWindowLevelNormal
        w.addGestureRecognizer(tapGes)
        return w
    }()
    
    static var config = ApplyPickerViewConfig()
    static var pickerView: UIView?
    
    static func configer(config: (ApplyPickerViewConfig) -> ()) -> (LBMerchantApplyPickerView.Type) {
        config(self.config)
        return self
    }
    
    
    static func showCityPickerView(confirmHandle: @escaping ConfirmHandle) {
        UIApplication.shared.keyWindow?.endEditing(true)
        let height = config.pickerHeight
        tapGes.isEnabled = config.isTapDismiss
        let picker = LBMerchantApplyCityPickerView(height: height) {
            dismiss()
            if !$0 {
                confirmHandle($1, $2)
            }
        }
        
        pickerView = picker
        window.addSubview(picker)
        window.isHidden = false
        UIView.animate(withDuration: 0.5) {
            let y = UIScreen.main.bounds.height
            picker.frame.origin.y = y - height
        }
    }
    
    @objc static func dismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            pickerView?.frame.origin.y = UIScreen.main.bounds.size.height
        }, completion: { (complete) in
            pickerView?.removeFromSuperview()
            window.isHidden = true
        })
    }
    
}


class LBMerchantApplyCityPickerView: UIView {
    
    typealias CloseHandle = (_ isCancle: Bool,_ privince: String,_ city: String) -> ()
    var closeHandle: CloseHandle
    
    var dataList: JSON?
    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor.white
        return pickerView;
    }()
    
    let toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.setShadowImage(UIImage(), forToolbarPosition: UIBarPosition.any)
        toolBar.setBackgroundImage(UIImage(), forToolbarPosition: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        toolBar.backgroundColor = COLOR_1478b8
        toolBar.tintColor = UIColor.white
        return toolBar;
    }()
    
    init(height: CGFloat, closeHandle: @escaping CloseHandle) {
        self.closeHandle = closeHandle
        let y = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        super.init(frame: CGRect(x: 0, y: y, width: width, height: height))
        setupUI()
        loadData()
    }
    fileprivate func loadData() {
        guard let jsonPath = Bundle.main.path(forResource: "cityDataList.json", ofType: nil) else {
            print("路径有毛病")
            return
        }
        guard let jsonStr = try? String(contentsOfFile: jsonPath, encoding: .utf8) else {
            return
        }
        
        let data = JSON(parseJSON: jsonStr)
        dataList = data["dataList"]
        
        
    }
    
    fileprivate func setupUI() {
        addSubview(pickerView)
        addSubview(toolBar)
        
        let leftItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(toolBarClick(bar:)))
        leftItem.width = 50
        leftItem.tag = 0
        let flexbleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let rightItem = UIBarButtonItem(title: "确定", style: .plain, target: self, action: #selector(toolBarClick(bar:)))
        rightItem.width = 50
        rightItem.tag = 1
        toolBar.items = [leftItem, flexbleSpace, rightItem]
        
        ({
            toolBar.translatesAutoresizingMaskIntoConstraints = false
            let leftConstraint = NSLayoutConstraint(item: toolBar, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0)
            let rightConstraint = NSLayoutConstraint(item: toolBar, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0)
            let topConstraint = NSLayoutConstraint(item: toolBar, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0)
            let heightConstraint = NSLayoutConstraint(item: toolBar, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 44.0)
            toolBar.addConstraint(heightConstraint)
            addConstraints([leftConstraint, rightConstraint, topConstraint])
        })()
        ({
            pickerView.translatesAutoresizingMaskIntoConstraints = false
            let leftConstraint = NSLayoutConstraint(item: pickerView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0)
            let rightConstraint = NSLayoutConstraint(item: pickerView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0)
            let topConstraint = NSLayoutConstraint(item: pickerView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: toolBar, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0)
            let bottomConstraint = NSLayoutConstraint(item: pickerView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0)
            addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
        })()
        pickerView.dataSource = self;
        pickerView.delegate = self;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toolBarClick(bar: UIBarButtonItem) {
        var isCancel: Bool = false
        if bar.tag == 0 { // 取消
            isCancel = true
        }
        
        let row0 = pickerView.selectedRow(inComponent: 0)
        let row1 = pickerView.selectedRow(inComponent: 1)
        
        let privince = dataList?[row0]["privinceName"].string ?? ""
        let city = dataList?[row0]["citys"][row1]["cityName"].string ?? ""
        closeHandle(isCancel, privince, city)
    }
}

extension LBMerchantApplyCityPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return dataList?.count ?? 0
        }else if component == 1 {
            let row0 = pickerView.selectedRow(inComponent: 0)
            return dataList?[row0]["citys"].count ?? 0
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return dataList?[row]["privinceName"].string
        }else if component == 1 {
            let row0 = pickerView.selectedRow(inComponent: 0)
            return dataList?[row0]["citys"][row]["cityName"].string
        }
        return nil
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
        }
    }
}

//
//  SNBaseRadioButton.swift
//  diandianzanumsers
//
//  Created by 楠 on 2017/6/20.
//  Copyright © 2017年 specddz. All rights reserved.
//

import UIKit

class SNBaseRadioButton: UIButton {

   fileprivate(set) var groupId : String = ""
    private var check : Bool = false
    var checked : Bool {
        set {
            check = newValue
            setChecked()
        }
        get {
            return check
        }
    }
    
    fileprivate static var checkedGroupDic = [String : [SNBaseRadioButton]]()
    
//    typealias click = (SNBaseRadioButton,Bool, String) -> ()
//    var radioClick :click?
    
    init(groupId id: String) {
    
    groupId = id
    
    super.init(frame: .zero)
    
    setupView()
    refreshState()
    addToGroup()
    addTarget(self, action: #selector(radioChecked), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SNBaseRadioButton {
    
    @objc func setupView() {}
    
    @objc func refreshState() {}
    
    func addToGroup() {
        
        guard var sRadios = SNBaseRadioButton.checkedGroupDic[groupId] else {
            var sradios = [SNBaseRadioButton]()
            sradios.append(self)
            SNBaseRadioButton.checkedGroupDic[groupId] = sradios
            return
        }
        
        sRadios.append(self)
        SNBaseRadioButton.checkedGroupDic[groupId] = sRadios
        
    }
    
    func removeFromGroup() {
        
        guard var sRadios = SNBaseRadioButton.checkedGroupDic[groupId] else {
            return
        }
        
//        sRadios.remove(object: self)
        
        if sRadios.count == 0 {
            SNBaseRadioButton.checkedGroupDic.removeValue(forKey: groupId)
        }
    }
    

    @objc func radioChecked() {
        
        if checked {
//            sort = !sort
//            radioClick?(self, true,groupId)  //点击回调
            click()
            return
        }
        
//        sort = true
        isSelected = !isSelected
        checked = isSelected
        refreshState()
        
        if isSelected {
            unCheckedOthers()
        }
        
        click()
//        radioClick?(self, true,groupId) // 点机回调
    }
    
    // 响应点击事件
    @objc func click() {}
    
    func setChecked() {
        
        //        if checked {
        //            return
        //        }
        
        isSelected = checked
        refreshState()
        
        if isSelected {
            unCheckedOthers()
        }
        
    }
    
   
    func unCheckedOthers() {
        
        guard let raios = SNBaseRadioButton.checkedGroupDic[groupId] else {
            return
        }
        
        if raios.count > 0 {
            
            for button in raios {
                if button != self {
                    button.checked = false
//                    button.image = UIImage(named: "price")!
                    unCheckRefresh()
                }
            }
        }
    }
    
//    清除样式
    @objc func unCheckRefresh() {}
}

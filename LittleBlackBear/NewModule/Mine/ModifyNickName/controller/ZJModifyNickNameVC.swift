//
//  ZJModifyNickNameVC.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 22/4/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJModifyNickNameVC: SNBaseViewController {

    
    let btn = UIButton().then({
        $0.setTitle("保存", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = Font(30)
//        $
    })
    
    

    fileprivate let nikeTextField = UITextField()
    func saveNickName(){
        if nikeTextField.text! == ""{
            SZHUD("请输入昵称", type: .info, callBack: nil)
            return
        }
        ZJLog(messagr: LLTimeStamp)
        SNRequestBool(requestType: API.modifyNickName(name: nikeTextField.text!)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(_):
//                LLNickName = self.nikeTextField.text!
                LBKeychain.set(self.nikeTextField.text!, key: LLNickName)
                SZHUD("修改成功", type: .info, callBack: nil)
                self.navigationController?.popViewController(animated: true)
            case .fail(_,let msg):
                SZHUD(msg ?? "修改昵称失败", type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    override func setupView() {
        
//        navigationController.
        
        btn.addTarget(self, action: #selector(saveNickName), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        title = "修改昵称"
        let mainSmallView = UIView()
        mainSmallView.backgroundColor = ColorRGB(red: 255, green: 255, blue: 255)
        self.view.addSubview(mainSmallView)
        nikeTextField.borderStyle = .none
        nikeTextField.placeholder = "请设置你的昵称"
        nikeTextField.font = Font(30)
        nikeTextField.textColor = Color(0x313131)
        
        let nickLable = UILabel()
        nickLable.font = Font(30)
        nickLable.textColor = Color(0x313131)
        nickLable.text = "昵称"
        
        
//        self.view.addSubview(mainView)
//        mainView.addSubview(mainSmallView)
        mainSmallView.addSubview(nickLable)
        mainSmallView.addSubview(nikeTextField)
        
//        mainView.snp.makeConstraints { (make) in
//            make.left.equalToSuperview()
//            make.right.equalToSuperview()
//            make.top.equalToSuperview()
//            make.height.snEqualTo(0)
//        }
        mainSmallView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.snEqualTo(20)
            make.height.snEqualTo(100)
        }
        
        nickLable.snp.makeConstraints { (make) in
            make.left.equalTo(mainSmallView.snp.left).snOffset(30)
            make.centerY.equalToSuperview()
            make.width.snEqualTo(80)
        }
        
        nikeTextField.snp.makeConstraints { (make) in
            make.left.equalTo(nickLable.snp.right)
            make.centerY.equalTo(nickLable)
            make.right.equalToSuperview().offset(fit(-100))
        }
        
    }
    
    
    


}

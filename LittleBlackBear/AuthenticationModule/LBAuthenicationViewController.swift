//
//  LBAuthenicationViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/29.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBAuthenicationViewController: UIViewController {
    
    var authenicationSuccessHandler:(()->())?
    
    fileprivate let tableView  = UITableView()
    fileprivate let cellItem:[LBAuthenicationType] = [
                                                      .input(label: "*持卡人姓名:",placeHolder: "请输入持卡人姓名"),
                                                      .input(label: "*身份证号码:",placeHolder: "请输入身份证号码"),
                                                      .input(label: "*银行名称:",placeHolder: "请输入开卡行"),
                                                      .input(label: "*储蓄卡卡号:",placeHolder: "请输入储蓄卡卡号"),
                                                      .input(label: "*手机号:",placeHolder: "请输入银行预留手机号"),
                                                      .button(title: "确定", height: 45)
                                                      ]
    
    fileprivate var cellContentDict: [IndexPath: Any?] = [IndexPath: Any?]()

    fileprivate lazy var textFieldKeyBoradTys:[LBTextFieldType] = [LBTextFieldType]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "实名认证"
        view.backgroundColor = COLOR_ffffff
        setupTableView()
        textFieldKeyBoradTys = [.unknown,
                                .numbersAndPunctuation,
                                .unknown,
                                .number,
                                .phone,
                                .unknown,
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"left_arrow_white")?.withRenderingMode(.alwaysOriginal),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(popViewController))
    }
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupTableView() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|",
                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views:["tableView":tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|",
                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views:["tableView":tableView]))
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LBAuthenicationTableViewCell.self, forCellReuseIdentifier: "LBAuthenicationTableViewCell")
        
    }
    
    
}

extension LBAuthenicationViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItem.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LBAuthenicationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LBAuthenicationTableViewCell", for: indexPath) as! LBAuthenicationTableViewCell
        cell.delegate = self
        cell.currentIndexPath = indexPath
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20)
        cell.selfType = cellItem[indexPath.row]
        cell.textFieldType = textFieldKeyBoradTys[indexPath.row]
        guard let content = cellContentDict[indexPath] else { return cell }
        cell.myCellContent = content
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellItem[indexPath.row] {
        case .button(title: _, height: _):
            return 100
        default:
            return 60
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
}

extension LBAuthenicationViewController:LBAuthenicationTableViewCellDelegate,LBAuthenicationPresenter{
    
 
    func authenication(_ cell: LBAuthenicationTableViewCell, _ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func authenication(_ cell: LBAuthenicationTableViewCell, textFieldShouldBeginEditing textField: UITextField) {
        
    }
    
    func authenication(_ cell: LBAuthenicationTableViewCell, textFieldDidEndEditing textField: UITextField){
        guard let indexPath = cell.currentIndexPath else {
            return
        }
        cellContentDict[indexPath] = textField.text
        Print(cellContentDict[indexPath])
    }

    func authenication(_ cell: LBAuthenicationTableViewCell, verificationButtonClick verificationButton: UIButton) {
        
    }
    

    func authenication(_ cell: LBAuthenicationTableViewCell, _ textField:UITextField, commitButtonClick commitButton: UIButton) {
      
        guard let name = cellContentDict[IndexPath(row: 0, section: 0)] as? String,name.count > 0 else { return
            showAlertView("请输入持卡人姓名", "确定", {_ in
                textField.resignFirstResponder()
			})
        }
        guard let idCardNum = cellContentDict[IndexPath(row: 1, section: 0)] as? String,idCardNum.count > 0 else { return
            showAlertView("请输入身份证号码", "确定",{_ in
                textField.resignFirstResponder()
            })
        }
        guard let bankCardName = cellContentDict[IndexPath(row: 2, section: 0)] as? String,bankCardName.count > 0 else { return
            showAlertView("请输入银行卡名称", "确定", {_ in
                textField.resignFirstResponder()
            })
        }
        guard let bankCardNum = cellContentDict[IndexPath(row: 3, section: 0)] as? String,bankCardNum.count > 0 else { return
            showAlertView("请输入储蓄卡卡号", "确定", {_ in
                textField.resignFirstResponder()
            })
        }
        guard let phoneNum = cellContentDict[IndexPath(row: 4, section: 0)] as? String,phoneNum.count > 0 else { return
            showAlertView("请输入手机号号", "确定", {_ in
                textField.resignFirstResponder()
            })
        }
        let mercId = LBKeychain.get(CURRENT_MERC_ID)
        let parameter:[String:Any] = ["mercId":mercId,
                                      "authenMobile":phoneNum,
                                      "authenIdcard":idCardNum,
                                      "cardNum":bankCardNum,
                                      "actName":name,
                                      "bankEn":"bankEn",
                                      "bankName":bankCardName]
        uploadAuthenicationData(parameter: parameter)

    }
    
   
}












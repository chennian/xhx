//
//  LBModifyBankCardViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/4.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBModifyBankCardViewController: UIViewController {

    
    fileprivate let tableView = UITableView(frame: .zero, style:.grouped)
    fileprivate var cellItem:[LBModifyBankCellType] = [LBModifyBankCellType]()
    fileprivate var cellTypes:[LBTextFieldType] = [LBTextFieldType]()
    var cellContentDict: [IndexPath: Any?] = [IndexPath: Any?]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCellItem()
        setupUI()
        navigationItem.title = "变更提现银行卡"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    private func setupUI() {
        
        view.addSubview(tableView)
        automaticallyAdjustsScrollViewInsets = false
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|",
                                                           options: NSLayoutFormatOptions.alignAllCenterY,
                                                           metrics: nil,
                                                           views: ["tableView": tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|",
                                                           options: NSLayoutFormatOptions.alignAllCenterX,
                                                           metrics: nil,
                                                           views: ["tableView": tableView]))
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        tableView.register(LBModifyBankCardCell.self, forCellReuseIdentifier: "LBModifyBankCardCell")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"left_arrow_white")?.withRenderingMode(.alwaysOriginal),
                                                           style: .plain,target: self,
                                                           action: #selector(popViewController))
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func setCellItem() {
        
        let userName = LBKeychain.get(CURRENT_USER_NAME)
        cellItem = [
            ((userName.count>0) ? .title_label("用户姓名:\(userName)"):.textField("用户姓名:", "请输入用户姓名")),
            .textField("所属银行:", "请输入所属银行，如：工商银行"),
            .textField("银行卡号:", "请输入银行卡号"),
            .textField("手机号:", "请输入银行预留手机号"),
            .button(title: "提交申请", height: 45)

        ]
        
        cellTypes = [.unknown,.unknown,.number,.unknown,.unknown]
        tableView.reloadData()
        
        
    }

}
extension LBModifyBankCardViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellItem.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LBModifyBankCardCell", for: indexPath) as! LBModifyBankCardCell
        cell.delegate = self
        cell.selfType = cellItem[indexPath.section]
        cell.textFieldType = cellTypes[indexPath.section]
        cell.currentIndexPath = indexPath
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0)
        guard let content = cellContentDict[indexPath] else { return cell}
        cell.myCellContent = content
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45

    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
   
}
extension LBModifyBankCardViewController:LBModifyBankCardCellDelegate{
    
    func modify(_ cell: LBModifyBankCardCell, textFieldDidEndEditing textField: UITextField) {
        guard let indexPath = cell.currentIndexPath else {
            return
        }
        
        cellContentDict[indexPath] = textField.text
    }
    
    func modify(_ cell: LBModifyBankCardCell, textFieldShouldBeginEditing textField: UITextField) {
        
    }
    
    func modify(_ cell: LBModifyBankCardCell, _ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func modify(_ cell: LBModifyBankCardCell, commitButtonClick button: UIButton) {
        
        
        guard let bankCardName = cellContentDict[IndexPath(row: 0, section: 1)] as? String else {
            
            UIAlertView(title: "提示", message: "请输入银行名称", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        guard let bankCardNum  = cellContentDict[IndexPath(row: 0, section: 2)] as? String else {
            UIAlertView(title: "提示", message: "请输入银行卡号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        
        guard let bankPhone = cellContentDict[IndexPath(row:0,section:3)] as? String else {
            UIAlertView(title: "提示", message: "请输入银行预留手机号", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            return
        }
        let mercId = LBKeychain.get(CURRENT_MERC_ID)
        let parameters = lb_md5Parameter(parameter: ["mercId":mercId,"authenMobile":bankPhone,"cardNum":bankCardNum,"bankName":bankCardName])
        LBHttpService.LB_Request(.modifyWithDrawCard, method:.post, parameters: parameters, success: {[weak self] (json) in
            guard let strongSelf  = self else{return}
            strongSelf.showAlertView("提现银行卡变更成功", "确定", {(_) in
                    strongSelf.navigationController?.popViewController(animated: true )
            })

        }, failure: {[weak self] (failItem) in
            guard let strongSelf  = self else{return}
            strongSelf.showAlertView(failItem.message, "确定", nil)
            
        }) { [weak self](_) in
            guard let strongSelf  = self else{return}
            strongSelf.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)
        }
        
    }
    
    
}



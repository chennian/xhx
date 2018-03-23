//
//  LBSettingPayPasswordViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/29.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBSettingPayPasswordViewController: UIViewController {
    
    fileprivate let tableView  = UITableView()
    fileprivate let cellItems:[LBInputType] = [
        .input(label: "设置支付密码:",placeHolder: "请输入六位数密码"),
        .input(label: "确认支付密码:",placeHolder: "请再次输入密码"),
        .button(title: "确定", height: 45)
    ]
    fileprivate lazy var textFieldKeyBoradTys:[LBTextFieldType] = [.password,
                                                                   .password,
                                                                   .unknown]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "设置支付密码"
        view.backgroundColor = COLOR_ffffff
        setupTableView()
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
        tableView.register(LBInputTableViewCell.self, forCellReuseIdentifier: "LBInputTableViewCell")
    }
    
    
}

extension LBSettingPayPasswordViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:LBInputTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LBInputTableViewCell", for: indexPath) as! LBInputTableViewCell
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20)
        cell.textFieldType = textFieldKeyBoradTys[indexPath.row]
        cell.cellType = cellItems[indexPath.row]
        cell.delegate = self
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellItems[indexPath.row] {
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

extension LBSettingPayPasswordViewController:LBInputTableViewCellDelegate{
  
    
    func input(_ cell: UITableViewCell, commitButtonClick commitButton: UIButton) {
        
    }
    
    func input(_ cell: UITableViewCell, textFieldShouldBeginEditing textField: UITextField) {
        
    }
    
    func input(_ cell: UITableViewCell, textFieldDidEndEditing textField: UITextField){
        
    }
    
    func input(_ cell: UITableViewCell, verificationButtonClick verificationButton: UIButton) {
        
    }
    
    func input(_ cell: UITableViewCell, _ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
}

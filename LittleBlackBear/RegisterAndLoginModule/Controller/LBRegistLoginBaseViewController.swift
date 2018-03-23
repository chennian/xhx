//
//  LBRegistLoginBaseViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/23.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBRegistLoginBaseViewController: UIViewController {
	
    var cellContentDict: [IndexPath: Any?] = [IndexPath: Any?]()
    var cellItems: [LBRegistLoginCellType] = [LBRegistLoginCellType]() {
        didSet {
            tableView.reloadData()
        }
    }
    var textFieldKeyBoradTys:[LBTextFieldType] = [LBTextFieldType]()
    var tableView: LBRegsitLoginBaseTableView = {
        let tableView = LBRegsitLoginBaseTableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.backgroundColor = COLOR_ffffff
        tableView.tableHeaderView = LBLogoHeaderView()
        LBRegistLoginTableViewCellFactory.registerTableViewCell(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|",
                                                           options: NSLayoutFormatOptions.alignAllCenterX,
                                                           metrics: nil,
                                                           views: ["tableView": tableView]))
    }
}
extension LBRegistLoginBaseViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  cellItems.count > 0 ? 1:0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = LBRegistLoginTableViewCellFactory.dequeueReusableCell(withTableView: tableView, type: cellItems [indexPath.section])!
        cell.currentIndexPath = indexPath
        cell.delegate = self
        cell.selectionStyle = .none

        if indexPath.section < textFieldKeyBoradTys.count {
            cell.textFieldType = textFieldKeyBoradTys[indexPath.section]
        }
        
        guard let content = cellContentDict[indexPath] else {
            return cell
        }
        
        cell.myCellContent = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 43
        }
            return 30
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
}
extension LBRegistLoginBaseViewController:LBRegistLoginCellDelegate{
    
    func registLoginCell(registLogin cell: LBRegistLoginCell, _ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    func registLoginCell(registLogin cell: LBRegistLoginCell, textFieldShouldBeginEditing textField: UITextField) {
        
    }
    func registLoginCell(registLogin cell: LBRegistLoginCell, textFieldDidEndEditing textField: UITextField) {
        guard let indexPath = cell.currentIndexPath else {
            return
        }
    
        cellContentDict[indexPath] = textField.text
        Print("第 \(indexPath) ---> \(String(describing: cellContentDict[indexPath]))")
    }
    func registLoginCell(registLogin cell: LBRegistLoginCell, verificationButtonClick verificationButton: SMSButton) {
        
    }
    func registLoginCell(registLogin cell: LBRegistLoginCell, commitButtonClick commitButton: UIButton) {
        
    }
    
    
    
    
    
}






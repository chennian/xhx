//
//  LBUserInfoViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/4.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBUserInfoViewController: UIViewController {

    var cellDict:[String] = [String](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
    fileprivate let  identifier = "LBUserInfoViewController"
    fileprivate let tableView  = UITableView(frame: .zero, style: .grouped)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadUerinfo()
    }
    

    private func setupUI() {
        
        navigationItem.title = "用户信息"
        view.backgroundColor = COLOR_ffffff
        
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
        tableView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:identifier)
        
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
    }

}
extension LBUserInfoViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellDict.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0)
        cell.textLabel?.text = cellDict[indexPath.section]
        cell.textLabel?.font = FONT_28PX
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 45
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
extension LBUserInfoViewController:LBUserInfoPresenter{
    func loadUerinfo() {
        
        requiredUserInfo(phoneNumber: LBKeychain.get(PHONE_NUMBER))
    }
}





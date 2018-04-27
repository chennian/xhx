//
//  LBMerchantApplyTypeViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBMerchantApplyTypeViewController: UITableViewController {
    
    private let ItemData:[String] = ["individual","enterprise"]
    fileprivate let cellId  = "LBMerchantApplyTypeViewController"
    var isOtherApply:applyType = .selfApply

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        navigationItem.title = "申请成为商家"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"left_arrow_white")?.withRenderingMode(.alwaysOriginal),style: .plain,target: self, action: #selector(popViewController))
    }
    func popViewController() {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(COLOR_e60013), for: .default)
    }
    private func configTableView() {
        tableView.backgroundColor = COLOR_ffffff
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.register(LBMerchantApplyTypeViewCell.self, forCellReuseIdentifier: cellId)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(TINT_COLOR),
                                                                 for: .any,
                                                                 barMetrics: .default)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:COLOR_ffffff,
                                                                   NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 16*default_scale)]
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return ItemData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LBMerchantApplyTypeViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LBMerchantApplyTypeViewCell
        cell.selectionStyle = .none
        cell.imageName = ItemData[indexPath.section]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (225+42)*AUTOSIZE_Y
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController  = LBMerchantApplyViewControllerTypeOne()
        switch indexPath.section {
        case 0:
            UserDefaults.standard.set(LBMerchantApplyTypeStyle.priv.rawValue, forKey:"LBMerchantApplyTypeStyle")
        case 1:
            UserDefaults.standard.set(LBMerchantApplyTypeStyle.company.rawValue, forKey:"LBMerchantApplyTypeStyle")
        default:
            break
        }
        viewController.isOtherApply = self.isOtherApply
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

//
//  LBPrivatePolicyViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/25.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
class LBPrivatePolicyViewController: UIViewController {
    
    
    var accepttedPolicy:((Bool)->())?
    private let policyView = LBPrivatePolicyView()
    private let statusBar = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        view.addSubview(policyView)
        policyView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[policyView]|",
                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["policyView":policyView]))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[policyView]|",
                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["policyView":policyView]))
        
        policyView.acceptionPolicy = {[weak self](result)in
            guard result == true else { return }
            guard let `self` = self else { return }
            guard let accepttedPolicy = self.accepttedPolicy else { return }
            self.showAlertView(message: "您已阅读并接受《小黑熊用户协议》",
                               actionTitles: ["取消","确定"],
                               handler: { (action) in
                if action.title == "确定"{
                    accepttedPolicy(true)

                }else{
                    accepttedPolicy(false)
                }
            })
        }
        
        statusBar.translatesAutoresizingMaskIntoConstraints = false
        statusBar.backgroundColor = UIColor.white
        view.addSubview(statusBar)
        view.addConstraint(BXLayoutConstraintMake(statusBar,.left,  .equal,view,.left))
        view.addConstraint(BXLayoutConstraintMake(statusBar,.top,   .equal,view,.top))
        view.addConstraint(BXLayoutConstraintMake(statusBar,.right, .equal,view,.right))
        view.addConstraint(BXLayoutConstraintMake(statusBar,.height,.equal,nil, .height,STATUS_BAR_HEIGHT))
    }
    
}

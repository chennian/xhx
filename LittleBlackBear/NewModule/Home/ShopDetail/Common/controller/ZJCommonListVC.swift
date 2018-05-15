//
//  ZJCommonListVC.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 15/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJCommonListVC: SNBaseViewController {

    var shopId : String = ""
    
    
//    var need

    let tableview = SNBaseTableView().then({
        $0.register(ZJCommonCell.self)
        $0.backgroundColor = Color(0xf5f5f5)
    })
    let viewModel = ZJCommonViewModel()
  
    override func setupView() {
        title = "全部评论"
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.snEqualTo(2)
            make.left.right.bottom.equalToSuperview()
        }
        
        tableview.delegate = viewModel
        tableview.dataSource = viewModel
        navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: pubBtn)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.requestData(shopid : shopId)
    }
    
    
    let pubBtn = UIButton().then({
        $0.setTitle("评论", for: .normal)
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.titleLabel?.font = Font(30)
        $0.sizeToFit()
    })
    override func bindEvent() {
        
        viewModel.publish.subscribe(onNext: { (count) in
            self.tableview.zj_reloadData(count: count)
        }).disposed(by: disposeBag)
        
        pubBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            
            if LBKeychain.get(ISLOGIN) != LOGIN_TRUE{
                self.presentLoginViewController()
                return
            }
            let vc = ZJPublishCommonVC()
            vc.shopId = self.shopId
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
    
    fileprivate func presentLoginViewController(){
        
        let viewController = LBLoginViewController()
        //        present(, animated: true, completion: nil)
        viewController.loginSuccessHanlder = { () in
            //            guard let strongSelf = self else{return}
            viewController.dismiss(animated: true, completion: nil)
            //            guard let action = strongSelf.loginSuccessHanlder else{return}
            //            action()
            //            strongSelf.navigationController?.popToRootViewController(animated: true)
            //            strongSelf.setCellItem()
        }
//        jumpSubject.onNext(SNJumpType.present(vc: LBNavigationController(rootViewController: viewController), anmi: true))
        self.present(LBNavigationController(rootViewController: viewController), animated: true, completion: nil)
        
    }


}

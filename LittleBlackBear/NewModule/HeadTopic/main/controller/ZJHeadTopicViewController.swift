//
//  ZJHeadTopicViewController.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 18/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJHeadTopicViewController: SNBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let test = "我{d83d}安德森"
        
//        let s = test.
//        ZJLog(messagr: s)
    }

    let tableview = SNBaseTableView().then{
        $0.register(ZJHeadTopicCell.self)
        $0.backgroundColor = Color(0xf5f5f5)
    }
    
    
    var firstReload : Bool = true
    override func viewAppear(_ animated: Bool) {
        super.viewAppear(animated)
        if firstReload{
            
            viewModel.getData()
            firstReload = false
        }
    }
    func rightItemClick(){
        let vc = ViewController()//ZJHeadTopicPostViewController()
        vc.popPublic.subscribe(onNext: {[unowned self] (refres) in
            self.firstReload = true
            self.tableview.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: false)
        }).disposed(by: disposeBag)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    let viewModel = ZJHeadTopicViewModel()
    override func setupView() {
        let righrItem = UIBarButtonItem(image: UIImage(named : "headline_release"), style: .done, target: self, action: #selector(rightItemClick))
        navigationItem.rightBarButtonItem = righrItem//UIBarButtonItem(customView: rightButton)
        
        title = "头条"
        view.addSubview(tableview)
        tableview.delegate = viewModel
        tableview.dataSource = viewModel
        
        tableview.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        
        tableview.addPullRefresh {[unowned self ] in
            self.viewModel.getData()
        }
        
        tableview.addPushRefresh {
            self.viewModel.getMoreData()
        }
    }


    override func bindEvent() {
//        rightButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
//            let vc = ViewController()//ZJHeadTopicPostViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }).disposed(by: disposeBag)
        viewModel.jumpSubject.subscribe(onNext: { (type) in
            switch type{
            case .push(let vc,let  anmi):
                self.navigationController?.pushViewController(vc, animated: anmi)
            case .show(let vc,_ ):
                self.show(vc, sender: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
        
        viewModel.reloadPublish.subscribe(onNext: {[unowned self] (count,getMore) in
            if getMore{
                self.tableview.stopPushRefreshEver()
                if count == 0{
                    self.tableview.removePushRefresh()//.stopPushRefreshEver(<#T##ever: Bool##Bool#>)
                }
            }else{
                
                self.tableview.stopPullRefreshEver()
            }
            self.tableview.zj_reloadData(count: count)
        }).disposed(by: disposeBag)
        
    }

}
//extension


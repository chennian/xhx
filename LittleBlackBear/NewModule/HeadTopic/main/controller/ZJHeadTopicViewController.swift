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
    }

    let tableview = SNBaseTableView().then{
        $0.register(ZJHeadTopicCell.self)
        $0.backgroundColor = Color(0xf5f5f5)
    }
    let rightButton = UIButton().then{
        $0.setImage(UIImage(named : "headline_release"), for: .normal)
    }
    override func viewAppear(_ animated: Bool) {
        super.viewAppear(animated)
        viewModel.getData()
    }
    let viewModel = ZJHeadTopicViewModel()
    override func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        title = "头条"
        view.addSubview(tableview)
        tableview.delegate = viewModel
        tableview.dataSource = viewModel
        
        tableview.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
    }


    override func bindEvent() {
        rightButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            let vc = ViewController()//ZJHeadTopicPostViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
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
        
        viewModel.reloadPublish.subscribe(onNext: {[unowned self] (count) in
            self.tableview.zj_reloadData(count: count)
        }).disposed(by: disposeBag)
        
    }

}
//extension


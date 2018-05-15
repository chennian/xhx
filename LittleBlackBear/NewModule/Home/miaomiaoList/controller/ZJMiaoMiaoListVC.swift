//
//  ZJMiaoMiaoListVC.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 12/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJMiaoMiaoListVC: SNBaseViewController {

    var shopId : String = ""{
        didSet{
            viewModel.reuquestData(shopid: shopId)
        }
    }

    private lazy var mainView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: fit(342), height: fit(362))
        layout.minimumLineSpacing = fit(20)
        let obj = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        obj.backgroundColor = Color(0xf5f5f5)
        obj.register(ZJMiaomiaoCollectionCell.self, forCellWithReuseIdentifier: cellIdentify(ZJMiaomiaoCollectionCell.self))
        obj.contentInset = UIEdgeInsetsMake(fit(20), fit(20), fit(20), fit(20))
        return obj
    }()

    
    let viewModel = ZJMiaomiaoListViewModel()
   
    
    override func setupView() {
        title = "秒秒商品"
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        mainView.delegate = viewModel
        mainView.dataSource = viewModel
    }
    
    override func bindEvent() {
        viewModel.reloadPub.subscribe(onNext: { () in
            self.mainView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.jumpSubject.subscribe(onNext: { (type) in
            switch type{
            case .push(let vc,let anmi):
                self.navigationController?.pushViewController(vc, animated: anmi)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }

}

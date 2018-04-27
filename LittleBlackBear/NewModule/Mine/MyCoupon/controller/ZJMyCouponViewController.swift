//
//  ZJMyCouponViewController.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 26/4/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

enum ZJMyCouponType : Int{
    case unused = 2
    case used = 1
    case dayOff = 3
}
class ZJMyCouponViewController: SNBaseViewController {

    var cuuentTableType : ZJMyCouponType?
    let viewModel = ZJMyCouponViewModel()
    
    let headerV = ZJMyCouponListHeader()
    let mainScrollerView = UIScrollView().then({
        $0.contentSize = CGSize(width: ScreenW * 3, height: 0)
        $0.backgroundColor = .white
        $0.isPagingEnabled = true
        $0.bounces = false
    })
    let unusedTableview = ZJMyCouponTableview.view(type: .unused).then({
        $0.register(ZJCouponCell.self)
        $0.separatorStyle = .none
//        $0.backgroundColor = .red
    })
    let usedTableview = ZJMyCouponTableview.view(type: .used).then({
        $0.register(ZJCouponCell.self)
        $0.separatorStyle = .none
//        $0.backgroundColor = .blue
    })
    let dayOffTableview = ZJMyCouponTableview.view(type: .dayOff).then({
        $0.register(ZJCouponCell.self)
        $0.separatorStyle = .none
//        $0.backgroundColor = .green
    })
//    override func viewAppear(_ animated: Bool) {
//        super.viewAppear(animated)
//        UIApplication.shared.statusBarStyle = .default
        
//        navigationController?.navigationBar.setBackgroundImage(createImageBy(color: UIColor.white), for: UIBarMetrics.default)
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:Color(0x313131),NSAttributedStringKey.font:Font(36)]
//    }


    
}
extension ZJMyCouponViewController : UIScrollViewDelegate{
    ///  动画
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        //centerX - fit(256)
        // x - screenw / screenw * fit(256)
//        let totalLineOffset : CGFloat = ScreenW - fit(40) - fit(90)
        let centerX = ( x - ScreenW) / ScreenW * fit(256) + view.centerX// + fit(65) + v
        headerV.updateLineConstraints(centerX: centerX)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let selectINdex = Int(x / ScreenW)
        
        var type : ZJMyCouponType = .used
        if selectINdex == 0{
            type = .unused
        }else if selectINdex == 1{
            type = .used
        }else {
            type = .dayOff
        }
        
        
        headerV.setCurrentSelect(type: type)
        
        self.viewModel.tryToGetInfo(type: type)
        self.cuuentTableType =  type
    }
    
    override func bindEvent() {
        headerV.selectType.asObservable().subscribe(onNext: {[unowned self] (type) in
            self.viewModel.tryToGetInfo(type: type)
            self.cuuentTableType =  type
            
            var x : CGFloat = 0.0
            switch type{
            case .used:
                x = 1
            case .unused:
                x = 0
            case .dayOff:
                x = 2
            }
            self.mainScrollerView.setContentOffset(CGPoint(x: ScreenW * x, y: 0), animated: false)
        }).disposed(by: disposeBag)
        
        viewModel.jumpSubject.asObserver().subscribe(onNext: {[unowned self] (type) in
            switch type{
            case .push(let vc ,let anmi):
                self.navigationController?.pushViewController(vc, animated: anmi)
            case .present(let vc,let anmi):
                self.present(vc, animated: anmi, completion: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
        viewModel.reloadPublish.subscribe(onNext: {[unowned self] (type,count) in

            switch type{
            case .unused:
                self.unusedTableview.zj_reloadData(count: count)
//                self.allTableV.mj_header.endRefreshing()
            case .used:
                self.usedTableview.zj_reloadData(count: count)
//                self.waitPayTableV.mj_header.endRefreshing()
            case .dayOff:
                self.dayOffTableview.zj_reloadData(count: count)
//                self.waitMailTableV.mj_header.endRefreshing()
            
            }
        }).disposed(by: disposeBag)
        
    }
    @objc func popViewController(){
        navigationController?.popViewController(animated: true)
    }
}
extension ZJMyCouponViewController{
    override func setupView() {
//        navigationController?.navigationBar.shadowImage = shaowImg
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"map_return1")?.withRenderingMode(.alwaysOriginal),style: .plain,target: self, action: #selector(popViewController))
        navigationItem.title = "卡券列表"
        view.addSubview(headerV)
        view.addSubview(mainScrollerView)
        mainScrollerView.addSubview(unusedTableview)
        mainScrollerView.addSubview(usedTableview)
        mainScrollerView.addSubview(dayOffTableview)
        mainScrollerView.delegate = self
        viewModel.tryToGetInfo(type: ZJMyCouponType.unused)
        headerV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.snEqualTo(20)
            make.height.snEqualTo(80)
        }
        mainScrollerView.snp.makeConstraints { (make) in
            make.top.equalTo(headerV.snp.bottom).snOffset(1)
            make.left.right.bottom.equalToSuperview()
        }
        unusedTableview.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        usedTableview.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.top.equalToSuperview()
            make.left.snEqualTo(unusedTableview.snp.right)
        }
        dayOffTableview.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.top.equalToSuperview()
            make.left.snEqualTo(usedTableview.snp.right)
        }
        unusedTableview.delegate = viewModel
        unusedTableview.dataSource = viewModel
        
        usedTableview.delegate = viewModel
        usedTableview.dataSource = viewModel
        
        dayOffTableview.delegate = viewModel
        dayOffTableview.dataSource = viewModel
        
        viewModel.getData()
        
    }
}



class ZJMyCouponTableview: SNBaseTableView {
    
    var type : ZJMyCouponType = .unused
    
    
    
    class func view(type : ZJMyCouponType) -> ZJMyCouponTableview{
        
        let v = ZJMyCouponTableview()
        v.type = type
        return v
    }
    
    
    var currentPage : Int = 1
}


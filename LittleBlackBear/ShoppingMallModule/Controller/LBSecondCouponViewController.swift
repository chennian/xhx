//
//  LBSecondCouponViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/10.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
private let Identifier = "LBSecondCouponViewController"
class LBSecondCouponViewController: UIViewController {

    var markType = "1" // 1 秒秒 2团团
    var city:String = ""
    fileprivate let tableView = UITableView()
    fileprivate var secondCellItem:[LBMerMarkListModel] = [LBMerMarkListModel]()
    fileprivate var groupCellItem:[LBGroupMmerMarkList] = [LBGroupMmerMarkList]()
    fileprivate var pageNum = 1
    fileprivate var pages = 1
    fileprivate let mercId = LBKeychain.get(CURRENT_MERC_ID)
    
	fileprivate var disPlayLink:CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        tableView.addPullRefresh {[weak self] in
            guard let strongSelf  = self else{return}

            guard strongSelf.pageNum < strongSelf.pages else{
                strongSelf.tableView.stopPullRefreshEver(true)
                return
            }
            strongSelf.pageNum += 1
            strongSelf.loadData()

        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
		disPlayLink = CADisplayLink(target: self,
										selector: #selector(mainCalculateTimer(_ :)))
		disPlayLink!.add(to: RunLoop.current, forMode: .commonModes)
        disPlayLink!.isPaused = false
        disPlayLink!.frameInterval = 1
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
		if disPlayLink != nil{
			disPlayLink!.invalidate()
		}
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    private func setupUI(){
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: nil,
                                                          views: ["tableView":tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: nil,
                                                          views: ["tableView":tableView]))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.rowHeight = 200
        tableView.register(LBMoreSecondCouponCell.self, forCellReuseIdentifier: Identifier)
        
        
    }
    
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		
//        let tableView = scrollView as! UITableView
//        let visibleCells = tableView.visibleCells.flatMap{String(describing: $0.classForCoder)}
//        guard let disPlayLink = disPlayLink else { return  }
//        if visibleCells.contains(String(describing:LBMoreSecondCouponCell.self)){
//            disPlayLink.isPaused = false
//            disPlayLink.frameInterval = 1
//        }else{
//            
//            if disPlayLink.isPaused == false{
//                disPlayLink.isPaused = true
//            }
//        }
		
		
	}

}

/// tableViewDelegate , tableViewDataSource
extension LBSecondCouponViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return markType == "1" ?secondCellItem.count:groupCellItem.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath) as! LBMoreSecondCouponCell
        
        if markType == "1"{
            cell.secondModel = secondCellItem[indexPath.section]
        }else{
            cell.groupModel = groupCellItem[indexPath.section]
        }
        
        cell.buttonTag = indexPath.section
        cell.selectionStyle = .none
        
        // 领取卡券
        cell.getCouponAction = {[weak self](button,markId) in
            guard let strongSelf = self else { return }
            
            guard LBKeychain.get(ISLOGIN) == LOGIN_TRUE else {
                strongSelf.showAlertView(message: "请先登录",actionTitles: ["取消","确定"],handler: {[weak self] (action ) in
                    
                    guard let strongSelf = self else {return}
                    guard action.title == "确定" else{return}
                    
                    strongSelf.presentLoginViewController({
                        
                    }, nil)
                    
                })
                return
            }
            
            strongSelf.getCouponRequire(markId: markId, mercId: strongSelf.mercId, completionHandler: { (result, text) in
                if result == true {
//                    button.isEnabled = false
                    strongSelf.loadData()
                    strongSelf.showAlertView("恭喜您，领取成功！", "确定", nil)
                }else{
                    strongSelf.showAlertView(text, "确定", nil)
                }
            })
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = LBSecondCouponDetailViewController()
        
        if markType == "1"{
             viewController.markId = secondCellItem[indexPath.section].id
        }else{
            viewController.markId = groupCellItem[indexPath.section].id
        }
        
        viewController.getCouponSuccessAction = {[weak self] in
            guard let strongSelf = self else { return }
            strongSelf.loadData()
        }
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }

}
extension LBSecondCouponViewController:LBCouponrenster{
    
}
extension LBSecondCouponViewController{
    
  fileprivate func loadData() {
    
        markType = navigationItem.title == "秒秒" ?"1":"2"
        let parameters = lb_md5Parameter(parameter: ["pageNum":pageNum,
                                                     "pageSize":"20",
                                                     "mercId":mercId,
                                                     "markType":markType,
                                                     "city":city])
    
        LBHttpService.LB_Request(.getMerMarkList, method: .get, parameters: parameters, success: {[weak self](json) in
            self?.tableView.stopPullRefreshEver()
            guard let strongSelf = self else{ return}
            if strongSelf.markType == "1"{// 秒秒
                
                guard strongSelf.secondCellItem.count < json["detail"]["total"].intValue else{return}
                strongSelf.pages = json["detail"]["pages"].intValue
                json["detail"]["list"].arrayValue.forEach{
                    strongSelf.secondCellItem.append(LBMerMarkListModel(json: $0))
                }
                
            }else{// 团团
                
                guard strongSelf.groupCellItem.count < json["detail"]["total"].intValue else{return}
                strongSelf.pages = json["detail"]["pages"].intValue
                json["detail"]["list"].arrayValue.forEach{
                    strongSelf.groupCellItem.append(LBGroupMmerMarkList(json: $0))
                }
            }
            strongSelf.tableView.reloadData()
            
        }, failure: {[weak self] (failItem) in
            
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(failItem.message, "确定", nil)
            strongSelf.tableView.stopPullRefreshEver()

        }) {[weak self] (error) in
            
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)
            strongSelf.tableView.stopPullRefreshEver()

        }
    }
}
extension LBSecondCouponViewController{
    
    
    func mainCalculateTimer(_ displayLink:CADisplayLink){
        
        DispatchQueue.main.async {[weak self] in
            guard let strongSelf = self else{return}
            for cell in strongSelf.tableView.visibleCells {
                
                if cell.isKind(of: LBMoreSecondCouponCell.self){
                    
                    let indexPath =  strongSelf.tableView.indexPath(for: cell)
                    if strongSelf.markType == "1"{// 秒秒
                        
                        let model = strongSelf.secondCellItem[indexPath!.section]
                        (cell as! LBMoreSecondCouponCell).calculationCurrentTime(model.validEndDate + " " + "23:59:59")
                        
                    }else{// 团团
                        
                        let model = strongSelf.groupCellItem[indexPath!.section]
                        (cell as! LBMoreSecondCouponCell).calculationCurrentTime(model.validEndDate + " " + "23:59:59")
                        
                    }
                }
            }
        }
    }
    

}

extension LBSecondCouponViewController:LBPresentLoginViewControllerProtocol{}










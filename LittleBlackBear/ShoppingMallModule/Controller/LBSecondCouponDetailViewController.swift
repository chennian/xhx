//
//  LBSecondCouponDetailViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/11.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

private let Identifier = "LBSecondCouponDetailViewController"
class LBSecondCouponDetailViewController: UIViewController {
    
    var markId:String = ""
    
    var getCouponSuccessAction:(()->())?
    var hadCouponAction:Bool = false{
        didSet{
            footerView.button_isHidden = hadCouponAction
        }
    }
    fileprivate var cellItem:[LBSecondCouponDetailCellType] = [LBSecondCouponDetailCellType]()
    fileprivate var pageNum = 0
    fileprivate var pages = 0
    fileprivate let mercId = LBKeychain.get(CURRENT_MERC_ID)
    
    fileprivate let tableView = UITableView()
    fileprivate let footerView = LBCouponDetailFooterView()
    fileprivate lazy var disPlayLink:CADisplayLink = {
        let disPlayLink = CADisplayLink(target: self,
                                        selector: #selector(mainCalculateTimer))
        disPlayLink.add(to: RunLoop.current, forMode: .defaultRunLoopMode)
        disPlayLink.isPaused = false

        return disPlayLink
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        disPlayLink.isPaused = false

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disPlayLink.invalidate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    private func setupUI(){
        
        tableView.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|",
                                                           options: NSLayoutFormatOptions.alignAllCenterX,
                                                           metrics: nil,
                                                           views: ["tableView":tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|",
                                                           options: NSLayoutFormatOptions.alignAllCenterY,
                                                           metrics: nil,
                                                           views: ["tableView":tableView]))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        LBSecondCouponDetailCellFactory.registerApplyTableViewCell(tableView)
        tableView.tableFooterView = footerView
        
        
        footerView.clickGetCouponAction = {[weak self](button) in
            guard let strongSelf = self  else {return}
            
            strongSelf.getCouponRequire(markId: strongSelf.markId, mercId: strongSelf.mercId, completionHandler: { (result, text) in
                
                if result == true {
                    
                    guard let action = strongSelf.getCouponSuccessAction else{return}
                    action()
                    button.isEnabled = false
                    strongSelf.showAlertView("恭喜您，领取成功！", "确定", nil)
                    
                }else{
                    strongSelf.showAlertView(text, "确定", nil)
                }
            })
        }
        
        
    }
    
    
    
}
extension LBSecondCouponDetailViewController:LBCouponrenster{}
/// tableViewDelegate , tableViewDataSource
extension LBSecondCouponDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LBSecondCouponDetailCellFactory.dequeueReusableCell(withTableView: tableView, indexPath: indexPath, cellItems: cellItem)
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellItem[indexPath.row] {
        case .cutDownCell(_):
            return 45
        case .explainCell(let model,_):
            return 250 + model.textH
        case .commCell(_, _):
            return 50
        case .shopCell(_):
            return 112.5
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch cellItem[indexPath.row] {
        case .commCell(let model , let text):
            
            if text == "查看店铺详情"{
                
                guard model.orgcode.count > 0 else{return}
                guard model.mercId.count > 0 else{return}
                
                let viewController = LBShoppingMallDetailViewController()
                viewController.orgCode = model.orgcode
                viewController.mercId = model.mercId
                navigationController?.pushViewController(viewController, animated: true)
            }
            
        default:break
        }
        
    }
}

extension LBSecondCouponDetailViewController{
    
    fileprivate func loadData() {
        
        let parameters = lb_md5Parameter(parameter: [
            "markId":markId,
            "mercId":mercId])
        
        LBLoadingView.loading.show(false)
        
        LBHttpService.LB_Request(.getMyMarkCardDtl, method: .post, parameters: parameters, success: {[weak self](json) in
            guard let strongSelf = self else{return}
            
            let model = LBSecondCouponDetailModel(json: json["detail"])
            strongSelf.navigationItem.title = model.markInfo.markTitle 
            strongSelf.cellItem.append(.cutDownCell(model.markInfo))
            strongSelf.cellItem.append(.explainCell(model.markInfo,model.headImgUrl))
            strongSelf.cellItem.append(.commCell(model.markInfo, ""))
            model.commList.forEach{strongSelf.cellItem.append(.shopCell($0))}
            
            if strongSelf.hadCouponAction == false{// 游戏卡券无法查看店铺详情
                strongSelf.cellItem.append(.commCell(model.markInfo, "查看店铺详情"))
            }
            
            strongSelf.tableView.reloadData()
            strongSelf.tableView.stopPullRefreshEver()
            
            LBLoadingView.loading.dissmiss()
            
            }, failure: {[weak self] (failItem) in
                
                guard let strongSelf = self else{return}
                
                strongSelf.showAlertView(failItem.message, "确定", nil)
                strongSelf.tableView.stopPullRefreshEver()
                
                LBLoadingView.loading.dissmiss()

                
        }) {[weak self] (error) in
            
            LBLoadingView.loading.dissmiss()
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)
            strongSelf.tableView.stopPullRefreshEver()
            
        }
    }
}

extension LBSecondCouponDetailViewController{

    func mainCalculateTimer(){
        DispatchQueue.main.async {[weak self] in
            guard let strongSelf = self else{return}
            for cell in strongSelf.tableView.visibleCells {
                if cell.isKind(of: LBSecondCouponDetailCutDownCell.self){
                    
                    let indexPath =  strongSelf.tableView.indexPath(for: cell)
                    switch strongSelf.cellItem[indexPath!.section]{
                    case .cutDownCell(let model):
                        (cell as! LBSecondCouponDetailCutDownCell).calculationCurrentTime(model.validEndDate + " " + "23:59:59")

                    default:break
                    }
                    
                }
            }
        }
    }
    

}


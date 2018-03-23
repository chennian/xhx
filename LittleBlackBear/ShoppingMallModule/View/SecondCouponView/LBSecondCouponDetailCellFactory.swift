//
//  LBSecondCouponDetailCellFactory.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/11.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
enum LBSecondCouponDetailCellType {
    case cutDownCell(LBSecondCouponDetailMarkInfoModel)
    case explainCell(LBSecondCouponDetailMarkInfoModel,String)
    case shopCell(LBSecondCouponDetailCommListModel)
    case commCell(LBSecondCouponDetailMarkInfoModel,String)
}
class LBSecondCouponDetailCellFactory{
    
    
    class func registerApplyTableViewCell(_ tableView: UITableView) {
        register(tableView, cellClass: LBSecondCouponDetailCutDownCell.self)
        register(tableView, cellClass: LBSecondCouponDetailExplainCell.self)
        register(tableView, cellClass: LBCouponDetailCommCell.self)
        register(tableView, cellClass: LBCouponDetailShopCell.self)
        register(tableView, cellClass: LBShoppingDetailShopCell.self)
    }
    
    class func dequeueReusableCell(withTableView tableView: UITableView, indexPath: IndexPath, cellItems: [LBSecondCouponDetailCellType]) -> UITableViewCell {
        switch cellItems[indexPath.row] {
        case .cutDownCell(let model):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSecondCouponDetailCutDownCell.self)
            cell.model = model
            return cell
        case .explainCell(let model,let url):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSecondCouponDetailExplainCell.self)
            cell.model  = model
            cell.imgUrl = url
            return cell
        case .commCell(let model, let text):
            let cell  = dequeueReusableCell(withTableView: tableView, cellClass: LBCouponDetailCommCell.self)
            cell.cellType = .commCell(model, text)
            return cell
        case .shopCell(let model):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBCouponDetailShopCell.self)
            cell.model = model
            return cell
        }
    }
    
    class func dequeueReusableCell(withTableView tableView: UITableView, cellType: LBSecondCouponDetailCellType) -> UITableViewCell? {
        switch cellType {
        case .cutDownCell(let model):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSecondCouponDetailCutDownCell.self)
            cell.model = model
            return cell
        case .explainCell(let model,let url):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSecondCouponDetailExplainCell.self)
            cell.model  = model
            cell.imgUrl = url
            return cell
        case .commCell(let model,let text):
            let cell  = dequeueReusableCell(withTableView: tableView, cellClass: LBCouponDetailCommCell.self)
            cell.cellType = .commCell(model, text)
            return cell
        case .shopCell(let model):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBCouponDetailShopCell.self)
            cell.model = model
            return cell
        }
    }
    
    
    fileprivate class func register<T:UITableViewCell>(_ tableView: UITableView, cellClass: T.Type) {
        let Identifier = String(describing:cellClass)
        tableView.register(cellClass.self, forCellReuseIdentifier: Identifier)
    }
    
    fileprivate class func dequeueReusableCell<Cell: UITableViewCell>(withTableView tableView: UITableView,cellClass:Cell.Type) -> Cell{
        let Identifier = String(describing:cellClass)
        return tableView.dequeueReusableCell(withIdentifier: Identifier) as! Cell
    }
    
}

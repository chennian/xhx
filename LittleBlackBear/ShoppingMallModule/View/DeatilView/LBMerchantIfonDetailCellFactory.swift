//
//  LBShoppingDetailCellFactory.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/13.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
enum merChantInfoCellTye {
    
    case mixCell(LBHomeMerchantModel)
    case images(UIViewController,[imgListModel])
    case distance(LBHomeMerchantModel)
    case appraise(LBCommentListModel<commentImageListModel>)
    case common(String,LBHomeMerchantModel,String)
    case comment(commentImageListModel)
    case shopingCell(LBShopsGoodsModel)
}
class LBMerchantIfonDetailCellFactory {

    
    class func registerApplyTableViewCell(_ tableView: UITableView) {
        register(tableView, cellClass: LBDistanceCell.self)
        register(tableView, cellClass: LBAppraiseCell.self)
        register(tableView, cellClass: LBCustomerCell.self)
        register(tableView, cellClass: LBShoppingMallMixDetailCell.self)
        register(tableView, cellClass: LBMercInfoImageTableViewCell.self)
        register(tableView, cellClass: LBShowCommentCell.self)
        register(tableView, cellClass: LBShoppingDetailShopCell.self)


    }
    
    class func dequeueReusableCell(withTableView tableView: UITableView, indexPath: IndexPath, cellItems: [merChantInfoCellTye]) -> UITableViewCell {
        
        switch cellItems[indexPath.row] {
            
        case let .images(VC,models):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBMercInfoImageTableViewCell.self)
			cell.imageUrls = models
			cell.presentVC = VC
            return cell
        case let .mixCell(type):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBShoppingMallMixDetailCell.self)
            cell.cellType = .mixCell(type)
            return cell
        case let .distance(model):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBDistanceCell.self)
            cell.model = model
            return cell
        case let .appraise(model):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBAppraiseCell.self)
            cell.model = model
            return cell
        case let .common(text,model,key):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBCustomerCell.self)
            cell.setupData(text: text, model: model, key: key)
            return cell
        case let .comment(model):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBShowCommentCell.self)
            cell.model = model
            return cell
        case .shopingCell(let model):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBShoppingDetailShopCell.self)
            cell.model = model
            return cell
        }
    }
    
    class func dequeueReusableCell(withTableView tableView: UITableView, cellType: merChantInfoCellTye) -> UITableViewCell? {
        switch cellType {
        case let .images(VC, models):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBMercInfoImageTableViewCell.self)
			cell.imageUrls = models
			cell.presentVC = VC
            return cell
        case let .mixCell(type):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBShoppingMallMixDetailCell.self)
            cell.cellType = .mixCell(type)
            return cell
        case .distance(_):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBDistanceCell.self)
            return cell
        case let .appraise(model):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBAppraiseCell.self)
            cell.model = model
            return cell
        case let .common(text,model,key):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBCustomerCell.self)
            cell.setupData(text: text, model: model, key: key)
            return cell
        case let .comment(model):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBShowCommentCell.self)
            cell.model = model
            return cell
        case .shopingCell(let model):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBShoppingDetailShopCell.self)
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

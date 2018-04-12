//
//  LBShoppingTableViewCellFactory.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/12/11.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

enum shoppingCellTye {
    /// title
    case title(String,String)
	/// 复杂 cell
    case mixCell(LBMerInfosModel)
	/// banner图
    case image([String])
    /// 团团
    case groupCoupons(LBGroupMmerMarkList)
    
    
    
    case newGropuCoupons(ZJHomeGroupModel)
    
    case newMiaomiaoCoupons([ZJHomeMiaoMiaoModel])
    
	/// 查看更多
    case button(String,String)
	/// 秒秒
    case secondCoupons(LBMerMarkListModel)
	
    
    //<-------->
    ///空格
    case space(cellHight : CGFloat ,color : UIColor)
    ///商家分类
    case merchantClass([LBCatasModel])
    ///新秒秒
    case newSecondCoupons([LBMerMarkListModel])
}

/// 产生cell工厂
class LBShoppingTableViewCellFactory {
    
    class func registerApplyTableViewCell(_ tableView: UITableView) {
        register(tableView, cellClass: LBShoppingMixedCell.self)
        register(tableView, cellClass: LBShoppingButtonCell.self)
        register(tableView, cellClass: LBShoppingImageCell.self)
        register(tableView, cellClass: LBShoppingLabelCell.self)
        register(tableView, cellClass: LBSecondCouponTableViewCell.self)
    }
    
    class func dequeueReusableCell(withTableView tableView: UITableView, indexPath: IndexPath, cellItems: [shoppingCellTye]) -> UITableViewCell {
		guard indexPath.row < cellItems.count else {return UITableViewCell()}
        switch cellItems[indexPath.row] {
            
        case let .title(text,_):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBShoppingLabelCell.self)
            cell.title_text = text
            return cell
        case let .image(list):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBShoppingImageCell.self)
            cell.cellType = .image(list)
            return cell
        case let .mixCell(type):
            
            let cell : ZJHomeMerchantCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = type
//            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBShoppingMixedCell.self)
            cell.model = type
            return cell
//        case .secondCoupons(let model):
//            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSecondCouponTableViewCell.self)
//            cell.secondCouponModel = model
//            return cell
//        case .newSecondCoupons(let models):
//            let cell : ZJHomeSeckillCell = tableView.dequeueReusableCell(forIndexPath: indexPath)//ZJHomeSeckillCell
//            cell.models = models
//            
//            return cell
        case .merchantClass(let models):
            let cell : ZJHomeClassCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.models = models
            return cell
        case .groupCoupons(let model):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSecondCouponTableViewCell.self)
            cell.groupCouponModel = model
            return cell
        default:
            let cell : ZJSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        }
    }
    
    class func dequeueReusableCell(withTableView tableView: UITableView, cellType: shoppingCellTye) -> UITableViewCell? {
        switch cellType {
        case let .title(text,_):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBShoppingLabelCell.self)
            cell.title_text = text
            return cell
        case let .image(list):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBShoppingImageCell.self)
            cell.cellType = .image(list)
            return cell
        case let .button(type,text):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBShoppingButtonCell.self)
//            cell.cellType = .button(type,text)
            return cell
        case let.mixCell(type):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBShoppingMixedCell.self)
            cell.cellType = .mixCell(type)
            return cell
        case .secondCoupons(let model):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSecondCouponTableViewCell.self)
            cell.secondCouponModel = model
            return cell
        case .groupCoupons(let model):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSecondCouponTableViewCell.self)
            cell.groupCouponModel = model
            return cell
        default:
            let cell : ZJSpaceCell = dequeueReusableCell(withTableView: tableView, cellClass: ZJSpaceCell.self)
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


//
//  LBMerchantApplyTableViewCellFactory.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

enum ApplyTableViewCellType {
    case common(CommonTableViewCellType)
    case image(ImageTableViewCellType)
    case button(ButtonTableViewCellType)
}


class LBMerchantApplyTableViewCellFactory {
    class func registerApplyTableViewCell(_ tableView: UITableView) {
        register(tableView, cellClass: CommonTableViewCell.self)
        register(tableView, cellClass: ImageTableViewCell.self)
        register(tableView, cellClass: ButtonTableViewCell.self)
    }
    
    class func dequeueReusableCell(withTableView tableView: UITableView, indexPath: IndexPath, cellItems: [ApplyTableViewCellType], cellContentDict: [IndexPath]) -> LBMerchantApplyTableViewCell? {
        
        switch cellItems[indexPath.row] {
			
        case let .common(type):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: CommonTableViewCell.self)
			
            cell?.myType = type
            return cell
        case let .image(type):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: ImageTableViewCell.self)
            cell?.myType = type
            return cell
        case let .button(type):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: ButtonTableViewCell.self)
            cell?.myType = type
            return cell
        }
    }
    
    class func dequeueReusableCell(withTableView tableView: UITableView, type: ApplyTableViewCellType) -> LBMerchantApplyTableViewCell? {
        switch type {
        case let .common(type):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: CommonTableViewCell.self)
            cell?.myType = type
            return cell
        case let .image(type):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: ImageTableViewCell.self)
            cell?.myType = type
            return cell
        case let .button(type):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: ButtonTableViewCell.self)
            cell?.myType = type
            return cell
        }
    }
    
    
    fileprivate class func register<T:LBMerchantApplyTableViewCell>(_ tableView: UITableView, cellClass: T.Type) where T: ApplyTableViewCellProtocol {
		Print(cellClass.indentifier)
		
        tableView.register(cellClass.self, forCellReuseIdentifier: cellClass.indentifier)
    }
    
    fileprivate class func dequeueReusableCell<Cell: LBMerchantApplyTableViewCell>(withTableView tableView: UITableView,  cellClass: Cell.Type) -> Cell? where Cell: ApplyTableViewCellProtocol {
        return tableView.dequeueReusableCell(withIdentifier: cellClass.indentifier) as? Cell
    }
    
}

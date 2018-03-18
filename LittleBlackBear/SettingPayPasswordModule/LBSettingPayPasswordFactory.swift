//
//  LBSettingPayPasswordFactory.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/29.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
enum LBInputType{
    case button(title: String, height: CGFloat)
    case input(label:String,placeHolder:String)
}
class LBSettingPayPasswordFactory {
    
    class func registerApplyTableViewCell(_ tableView: UITableView) {
        register(tableView, cellClass: LBInputTableViewCell.self)
        register(tableView, cellClass: LBSettingButtonCell.self)
    }
    
    class func dequeueReusableCell(withTableView tableView: UITableView, indexPath: IndexPath, cellItems: [LBInputType]) -> UITableViewCell {
        switch  cellItems[indexPath.section] {
        case let.input(label: text, placeHolder: _):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBInputTableViewCell.self)
            cell.cellType = .input(label: text, placeHolder: text)
            return cell
        case .button(let title, _):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSettingButtonCell.self)
            cell.title = title
            return cell
        }
    }
    
    class func dequeueReusableCell(withTableView tableView: UITableView, cellType: LBInputType) -> UITableViewCell? {
        switch cellType {
        case  .input(let text ,let placeHolder):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBInputTableViewCell.self)
            cell.cellType = .input(label: text, placeHolder: placeHolder)
            return cell
        case .button(let title, _):
        let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSettingButtonCell.self)
        cell.title = title
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

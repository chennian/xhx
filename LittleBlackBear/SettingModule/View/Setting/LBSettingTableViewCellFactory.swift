//
//  LBSettingTableViewCellFactory.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/19.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

enum LBSettingCellType {
    case commitButton(String)
    case bindAcoountImage(String,[String])
    case `switch`(String,Bool)
    case rightLabel(String,String,UIColor)
    case comm(String)
}

class LBSettingTableViewCellFactory {
    class func registerApplyTableViewCell(_ tableView: UITableView) {
        register(tableView, cellClass: LBSettingCell.self)
        register(tableView, cellClass: LBSwitchCell.self)
        register(tableView, cellClass: LBSettingButtonCell.self)
    }
    
    class func dequeueReusableCell(withTableView tableView: UITableView, indexPath: IndexPath, cellItems: [LBSettingCellType]) -> UITableViewCell {
        switch  cellItems[indexPath.section] {
        case let .comm(text):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSettingCell.self)
            cell.cellType = .comm(text)
            return cell
        case let .rightLabel(text0, text1, color):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSettingCell.self)
            cell.cellType = .rightLabel(text0, text1, color)
            return cell
        case let .commitButton(title):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSettingButtonCell.self)
            cell.cellType = .commitButton(title)
            return cell
        case let .bindAcoountImage(text,strings):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSettingCell.self)
            cell.cellType = .bindAcoountImage(text,strings)
            return cell
        case let .switch(text,status):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSwitchCell.self)
            cell.cellType = .switch(text,status)
            return cell
        }
    }
    
    class func dequeueReusableCell(withTableView tableView: UITableView, cellType: LBSettingCellType) -> UITableViewCell? {
        switch cellType {
        case let .comm(text):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSettingCell.self)
            cell.cellType = .comm(text)
            return cell
        case let .rightLabel(text0, text1, color):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSettingCell.self)
            cell.cellType = .rightLabel(text0, text1, color)
            return cell
        case let .commitButton(title):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSettingButtonCell.self)
            cell.cellType = .commitButton(title)
            return cell
        case let .bindAcoountImage(text,strings):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSettingCell.self)
            cell.cellType = .bindAcoountImage(text,strings)
            return cell
        case let .switch(text,status):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: LBSwitchCell.self)
            cell.cellType = .switch(text,status)
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

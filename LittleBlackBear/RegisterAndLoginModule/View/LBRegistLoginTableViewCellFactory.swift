//
//  LBRegistLoginTableViewCellFactory.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/23.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

enum LBRegistLoginCellType {
	case button(title: String, height: CGFloat)
	case input(imgName:String,placeHolder:String)
	case verifInput(imgName:String,placeHolder:String)
}
enum LBRegistLoginCellIndentifierType:String{
	
	case textFielTableViewCell = "textFielCellIndentifier"
	case commitButtonTableViewCell = "ButtonTableViewCell"
	case registerProtocolButtonCell = "registerProtocolButtonCell"
	case verifBtnTableViewCell  = "verificationButtonTableViewCell"

}
class LBRegistLoginTableViewCellFactory{
	
	class func registerTableViewCell(_ tableView: UITableView) {
		
		register(tableView, cellClass: LBRegistLoginCell.self, Identifier: .textFielTableViewCell)
		register(tableView, cellClass: LBRegistLoginCell.self, Identifier: .commitButtonTableViewCell)
		register(tableView, cellClass: LBRegistLoginCell.self, Identifier: .verifBtnTableViewCell)
		register(tableView, cellClass: LBRegistLoginCell.self, Identifier: .registerProtocolButtonCell)

	}
	
	class func dequeueReusableCell(withTableView tableView: UITableView, indexPath: IndexPath, cellItems: [LBRegistLoginCellType], cellContentDict: [IndexPath]) -> LBRegistLoginCell? {
		switch cellItems[indexPath.row] {
			
		case let .input(imgName: imgName, placeHolder: placeHolder):
			let cell = dequeueReusableCell(withTableView: tableView, Identifier: .textFielTableViewCell)
			cell?.selfType = .input(imgName: imgName, placeHolder: placeHolder)
			return cell
		case let .verifInput(imgName: imgName, placeHolder: placeHolder):
			let cell = dequeueReusableCell(withTableView: tableView, Identifier: .textFielTableViewCell)
			cell?.selfType = .verifInput(imgName: imgName, placeHolder: placeHolder)
			return cell
        case let .button(title: title, height:height):
			let cell = dequeueReusableCell(withTableView: tableView, Identifier: .commitButtonTableViewCell)
			cell?.selfType = .button(title: title, height: height)
			 return cell

		}
	}
	
	class func dequeueReusableCell(withTableView tableView: UITableView, type: LBRegistLoginCellType) -> LBRegistLoginCell?{
		
		switch type {
		case let .input(imgName: imgName, placeHolder: placeHolder):
			let cell = dequeueReusableCell(withTableView: tableView, Identifier: .textFielTableViewCell)
			cell?.selfType = .input(imgName: imgName, placeHolder: placeHolder)
			return cell
		case let .verifInput(imgName: imgName, placeHolder: placeHolder):
			let cell = dequeueReusableCell(withTableView: tableView, Identifier: .textFielTableViewCell)
			cell?.selfType = .verifInput(imgName: imgName, placeHolder: placeHolder)
			return cell
		case let .button(title: title, height: height):
			let cell = dequeueReusableCell(withTableView: tableView, Identifier: .commitButtonTableViewCell)
            cell?.selfType = .button(title: title, height: height)
			return cell
	
		}
	}
	
	fileprivate class func register<T:LBRegistLoginCell>(_ tableView: UITableView,cellClass:T.Type, Identifier: LBRegistLoginCellIndentifierType) {
		tableView.register(cellClass.self, forCellReuseIdentifier: "\(Identifier.rawValue)")
	}
	
	fileprivate class func dequeueReusableCell<Cell: LBRegistLoginCell>(withTableView tableView: UITableView,  Identifier:LBRegistLoginCellIndentifierType) -> Cell? {
		return tableView.dequeueReusableCell(withIdentifier: Identifier.rawValue) as? Cell
	}
	
}

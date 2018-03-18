//
//  ToolBarView.swift
//  BaiXiangPay
//
//  Created by 蘇崢 on 2017/5/2.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
protocol ToolBarViewDelegate:NSObjectProtocol {
	func dissMissPickView()
}
open class ToolBarView: UIView {
	
	weak  var delegate:ToolBarViewDelegate?
	typealias CustomClosures = (_ titleLabel: UILabel, _ cancleBtn: UIButton, _ doneBtn: UIButton) -> Void
	public typealias BtnAction = () -> Void
	
	open var title = "请选择" {
		didSet {
			titleLabel.text = title
		}
	}

	
	open var doneAction: BtnAction?
	open var cancelAction: BtnAction?
	// 上下分割线
	fileprivate lazy var contentView: UIView = {
		let content = UIView()
		content.backgroundColor = TINT_COLOR
		return content
	}()
	// 文本框
	fileprivate lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = UIColor.black
		label.textAlignment = .center
		return label
	}()
	
	// 取消按钮
	fileprivate lazy var cancleBtn: UIButton = {
		let btn = UIButton()
		btn.setTitle("取消", for: UIControlState())
		btn.setTitleColor(white, for: UIControlState())
		return btn
	}()
	
	// 完成按钮
	fileprivate lazy var doneBtn: UIButton = {
		let donebtn = UIButton()
		donebtn.setTitle("完成", for: UIControlState())
		donebtn.setTitleColor(white, for: .normal)
		return donebtn
	}()
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()

	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	fileprivate func commonInit() {
	
		backgroundColor = UIColor.lightText
		addSubview(contentView)
		contentView.addSubview(doneBtn)
		contentView.addSubview(titleLabel)
		
		doneBtn.addTarget(self, action: #selector(self.doneBtnOnClick(_:)), for: .touchUpInside)
		cancleBtn.addTarget(self, action: #selector(self.cancelBtnOnClick(_:)), for: .touchUpInside)
	}
	
	func doneBtnOnClick(_ sender: UIButton) {
		delegate?.dissMissPickView()
		doneAction?()
	}
	func cancelBtnOnClick(_ sender: UIButton) {
		cancelAction?()
		delegate?.dissMissPickView()

	}
	
	override open func layoutSubviews() {
		super.layoutSubviews()
		let margin = 15.0
		let contentHeight = Double(bounds.size.height) - 2.0
		contentView.frame = CGRect(x: 0.0, y: 1.0, width: Double(bounds.size.width), height: contentHeight)
		let btnWidth = contentHeight
		
		cancleBtn.frame = CGRect(x: margin, y: 0.0, width: btnWidth, height: btnWidth)
		doneBtn.frame = CGRect(x: Double(bounds.size.width) - btnWidth - margin, y: 0.0, width: btnWidth, height: btnWidth)
		let titleX = Double(cancleBtn.frame.maxX) + margin
		let titleW = Double(bounds.size.width) - titleX - btnWidth - margin
		
		
		titleLabel.frame = CGRect(x: titleX, y: 0.0, width: titleW, height: btnWidth)
	}
	
	
}

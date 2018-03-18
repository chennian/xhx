//
//  LBMerchantApplyFinishViewController.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/22.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBMerchantApplyFinishViewController: LBMerchantApplyBaseViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "提交成功"
		headViewStyle = .none(topImage: "merchantsApply4")
		configSubView()
	}
	
}
extension LBMerchantApplyFinishViewController{
	
	func configSubView() {
		
		let iconImageView = UIImageView(image: UIImage(named: "applyFinish"))
		let successLabel = UILabel()
		let descLabel  = UILabel()
		let button = UIButton()
		
		iconImageView.translatesAutoresizingMaskIntoConstraints = false
		successLabel.translatesAutoresizingMaskIntoConstraints  = false
		descLabel.translatesAutoresizingMaskIntoConstraints = false
		button.translatesAutoresizingMaskIntoConstraints = false
		
		successLabel.textColor = COLOR_fc8439
		successLabel.font = FONT_32PX
		successLabel.text = "恭喜您！提交成功!"
		
		descLabel.textColor = COLOR_999999
		descLabel.font = FONT_28PX
		descLabel.text = "我们会尽快完成审核"
		
		button.setTitle("确定", for: .normal)
		button.titleLabel?.font = FONT_32PX
		button.setTitleColor(COLOR_222222, for: .normal)
		button.backgroundColor = COLOR_ededed
		button.layer.cornerRadius = 5
		button.layer.masksToBounds = true
		button.layer.borderWidth = 0.5
		button.layer.borderColor = COLOR_9C9C9C.cgColor
		
		tableView.backgroundColor = UIColor.white
		tableView.addSubview(iconImageView)
		tableView.addSubview(successLabel)
		tableView.addSubview(button)
		tableView.addSubview(descLabel)
		
		tableView.addConstraint(BXLayoutConstraintMake(iconImageView, .top, .equal,tableView.tableHeaderView,.bottom,60))
		tableView.addConstraint(BXLayoutConstraintMake(iconImageView, .centerX, .equal,tableView,.centerX))
		tableView.addConstraint(BXLayoutConstraintMake(iconImageView, .width, .equal,nil,.width,85))
		tableView.addConstraint(BXLayoutConstraintMake(iconImageView, .height, .equal,nil,.height,85))
		
		tableView.addConstraint(BXLayoutConstraintMake(successLabel, .top, .equal,iconImageView,.bottom,30))
		tableView.addConstraint(BXLayoutConstraintMake(successLabel, .centerX, .equal,iconImageView,.centerX))
		
		tableView.addConstraint(BXLayoutConstraintMake(descLabel, .top, .equal,successLabel,.bottom,30))
		tableView.addConstraint(BXLayoutConstraintMake(descLabel, .centerX, .equal,iconImageView,.centerX))
		
		
		
		tableView.addConstraint(BXLayoutConstraintMake(button, .top, .equal,descLabel,.bottom,47))
		tableView.addConstraint(BXLayoutConstraintMake(button, .centerX, .equal,tableView,.centerX))
		tableView.addConstraint(BXLayoutConstraintMake(button, .width, .equal,nil,.width,320))
		tableView.addConstraint(BXLayoutConstraintMake(button, .height, .equal,nil,.height,45))
        
        button.addTarget( self, action: #selector(finishAction(_ :)), for: .touchUpInside)
        
	}
    
    func finishAction(_ button:UIButton)  {
        navigationController?.popToRootViewController(animated: true)
    }
	
}

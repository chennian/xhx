//
//  ZJHeadTopicDetailVC.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 18/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJHeadTopicDetailVC: SNBaseViewController {
    
    var model : ZJHeadTopicCellModel?{
        didSet{
            viewModel.getData(id: model!.id,type : .common)//.topicModel = model!
            
//            toolBar.likeButton.isSelected = model!.praise//.set(share: model!.forwardNum, like: model!.real_praise)
            self.toolBar.likeButton.setSelect(selected: model!.praise, img: "headline_praise")
        }
    }
    
    var beginEdit : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //SinglePhotoPreviewViewController

    let tableView = SNBaseTableView.init(frame: CGRect.zero, style: UITableViewStyle.plain).then{
        $0.register(ZJHeadTopicMainContentCell.self)
        $0.register(ZJHeadTopicCommonCell.self)
        $0.register(ZJHeadTopicShareCell.self)
        $0.register(ZJSpaceCell.self)
    }
    
    let toolBar = ZJHeadTopicToolBar()
    
    let viewModel = ZJHeadTopicDetailViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if beginEdit{
            
            toolBar.commonBtn.tv.becomeFirstResponder()
        }
    }
    override func setupView() {
        title = "头条"
        view.addSubview(tableView)
        view.addSubview(toolBar)
        toolBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-LL_TabbarSafeBottomMargin)
            make.height.snEqualTo(110)
        }
       
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(toolBar.snp.top)
        }
    }
    override func bindEvent() {
        viewModel.reloadPublish.subscribe(onNext: {[unowned self] (section ,_) in
            self.tableView.reloadSections(section, animationStyle: UITableViewRowAnimation.none)
        }).disposed(by: disposeBag)
        
        toolBar.replayClick.subscribe(onNext: { (content) in
            self.viewModel.replay(content: content)
//            self.viewModel.getData(id: self.model!.id)
        }).disposed(by: disposeBag)
        
        viewModel.jumpSubject.subscribe(onNext: { (type) in
            switch type{
            case .show(let vc, _):
                self.show(vc, sender: nil)
            default:
                break
            }
            
        }).disposed(by: disposeBag)
        
        toolBar.likeButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: {[unowned self] () in
            self.toolBar.likeButton.setSelect(selected: !self.toolBar.likeButton.isSelected, img: "headline_praise")//.isSelected = !self.toolBar.likeButton.isSelected
            self.viewModel.setLike(id: self.model!.id, btn: self.toolBar.likeButton)
        }).disposed(by: disposeBag)
    }

}

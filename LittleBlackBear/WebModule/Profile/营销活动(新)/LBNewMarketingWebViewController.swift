//
//  LBNewMarketingWebViewController.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/17.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class LBNewMarketingWebViewController: UIViewController {
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
//        $0.register(LBNewMarketHead.self)
        $0.register(LBNewMarketCellTableViewCell.self)
        $0.register(ZJSpaceCell.self)
        $0.separatorStyle = .none
    }
    
    var cellModelMiao:[ZJHomeMiaoMiaoModel] = []
    var cellModelGroup:[ZJHomeGroupModel] = []
    
    var recordNumber:Int = 0

    let heade = LBNewMarketHead()
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadData()
        setupUI()
        bindEvent()
        loadDataGroup()
        view.backgroundColor = color_bg_gray_f5
    }


    func setupUI() {
        setNavigaytionBar()
    
        self.title = "营销活动"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(heade)
        heade.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.snEqualTo(90)
        }
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.snEqualTo(heade.snp.bottom).snOffset(20)//.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    func loadDataGroup(){
        
        SNRequest(requestType:API.getTuanTuanList(mercId: LBKeychain.get(CURRENT_MERC_ID), size: 6, page: 0), modelType: [ZJHomeGroupModel.self]).subscribe(onNext: { (result) in
            //       print(result)
            switch result{
            case .success(let models):
                self.cellModelGroup = models
                print(self.cellModelGroup)
                self.tableView.reloadData()
            case .fail(_,let msg):
                ZJLog(messagr: msg)
            default:
                break
            }
        }).disposed(by: dispoisBag)
        
    }
    
    func loadDataMiao(){
        
        SNRequest(requestType:API.getMiaoMiaoList(mercId: LBKeychain.get(CURRENT_MERC_ID), size: 6, page: 0), modelType: [ZJHomeMiaoMiaoModel.self]).subscribe(onNext: { (result) in
//       print(result)
            switch result{
            case .success(let models):
                self.cellModelMiao = models
                print(self.cellModelMiao)
                self.tableView.reloadData()
            case .fail(_,let msg):
                ZJLog(messagr: msg)
            default:
                break
            }
        }).disposed(by: dispoisBag)
        
    }
    func bindEvent(){
        heade.btnClickPub.subscribe(onNext: { (type) in
            switch type{
            case .pin:
                self.recordNumber = 0
                self.loadDataGroup()
                break
            case .tuan:
                self.recordNumber = 1

                self.loadDataMiao()
                break
            case .game:
                self.recordNumber = 2

                self.cellModelMiao.removeAll()
                self.cellModelGroup.removeAll()
                self.tableView.reloadData()
                
                break
                
            }

        }).disposed(by: dispoisBag)
    }
    let dispoisBag = DisposeBag()
    func setNavigaytionBar() {
        
        let button = UIButton(frame:CGRect(x:0, y:0, width:50, height:30))
        
        button.setTitle("新增", for: UIControlState.normal)
        
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        
        button.addTarget(self, action: #selector(showMnue), for: UIControlEvents.touchUpInside)
        
        let item = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem=item
    }
    
    func showMnue(sender:Any){
        self.showXYMenu(sender: sender, type: .XYMenuRightNormal, isNav: false)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        loadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}

extension LBNewMarketingWebViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if recordNumber == 0{
            return self.cellModelGroup.count
        }else if recordNumber == 1{
            return self.cellModelMiao.count
        }else{
            return 0
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LBNewMarketCellTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        if recordNumber == 0{
            cell.groupModel = self.cellModelGroup
        }else{
            cell.miaomiaoModel = self.cellModelMiao
            
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //判断类型 heard 100  内容500
        return fit(500)
//        if indexPath.row == 0{
//            return fit(100)
//
//        }else if indexPath.row == 1{
//            return fit(16)
//
//        }else{
//            
//
//        }
    }
    
}

extension UIViewController {
    
    func showMessage(index: Int, titles: [String]) {
        let title = titles[index - 1]
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showXYMenu(sender: Any, type: XYMenuType, isNav: Bool) {
        let images = ["code", "selected"]
        let titles = ["团 团", "秒 秒"]
        if let senderView = sender as? UIView {
            senderView.xy_showXYMenu(images: images, titles: titles, type: type, closure: { [unowned self] (index) in
//                self.showMessage(index: index, titles: titles)
                if index == 1{
                    self.navigationController?.pushViewController(LBAddGroupController(), animated: true)
                }else{
                    self.navigationController?.pushViewController(LBAddSeckillController(), animated: true)
                    
                }
            })
        }
        
    }
}

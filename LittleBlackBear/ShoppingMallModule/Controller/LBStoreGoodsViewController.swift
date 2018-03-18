//
//  LBStoreGoodsViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
private let Identifier1 = "LBStoreLeftTableViewCell"
private let Identifier2 = "LBStoreRightTableViewCell"

class LBStoreGoodsViewController: UIViewController {
    
    var orgCode:String = ""{
        didSet{
            guard orgCode.count > 0 else{return}
            queryGoodsTypes(orgCode)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75) {[weak self] in
                guard let strongSelf = self else{return}
                LBLoadingView.loading.dissmiss()
                strongSelf.leftTableView.reloadData()
                strongSelf.rightTableView.reloadData()
            }
        }
    }

    fileprivate var types:[GoodsTypsModel] = []
    fileprivate var goods:[LBShopsGoodsModel] = []
    fileprivate var goodsModelList:[LBShopsGoodsModelList] = []

    fileprivate var selectIndex = 0
    fileprivate var isScrollDown = true
    fileprivate var lastOffsetY : CGFloat = 0.0
    
    fileprivate let leftTableView = UITableView()
    fileprivate let rightTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LBLoadingView.loading.show(false)
        setupUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupUI(){
        
        view.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(leftTableView)
        view.addSubview(rightTableView)
        
        leftTableView.translatesAutoresizingMaskIntoConstraints = false
        rightTableView.translatesAutoresizingMaskIntoConstraints = false
        
        leftTableView.estimatedSectionFooterHeight = 0
        leftTableView.separatorStyle = .none
        leftTableView.estimatedSectionHeaderHeight = 0
        leftTableView.sectionHeaderHeight = 0
        leftTableView.rowHeight = 60
        
        rightTableView.estimatedSectionHeaderHeight = 0
        rightTableView.sectionHeaderHeight = 35
        rightTableView.rowHeight = 115
        
        leftTableView.delegate = self
        leftTableView.dataSource = self
        
        rightTableView.delegate = self
        rightTableView.dataSource = self
        
        
        let H_VisualFormat = "H:|[leftTableView(84)]-2-[rightTableView]|"
        let V_VisualFormat1 = "V:|-10-[leftTableView]|"
        let V_VisualFormat2 = "V:|-10-[rightTableView]|"
        let views = ["leftTableView":leftTableView,"rightTableView":rightTableView]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: H_VisualFormat,
                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: V_VisualFormat1,
                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["leftTableView":leftTableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: V_VisualFormat2,
                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["rightTableView":rightTableView]))
        
        leftTableView.register(LBStoreLeftTableViewCell.self, forCellReuseIdentifier: Identifier1)
        rightTableView.register(LBStoreRightTableViewCell.self, forCellReuseIdentifier: Identifier2)

        
    }
    
}

extension LBStoreGoodsViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == leftTableView{
            return 1
        }
        return types.count > 0 ?types.count:0
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == leftTableView{
            return types.count > 0 ?types.count:0
        }
        
        guard  goods.count > 0 else {return 0 }
        return section < goods.count ?goods[section].list.count:goods.last!.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)

        if tableView == leftTableView{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier1, for: indexPath) as!LBStoreLeftTableViewCell
            cell.label_text = types[indexPath.row].typeName
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier2, for: indexPath) as!LBStoreRightTableViewCell
        cell.selectionStyle = .none
        let model:LBShopsGoodsModel = goods[indexPath.section]
        cell.imgUrl = model.list[indexPath.row].mainImg.imgUrl
        cell.name = model.list[indexPath.row].commoName
        cell.price = model.list[indexPath.row].commoPrice
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if leftTableView == tableView {
            return nil
        }
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.width, height: 35))
        label.backgroundColor = COLOR_ffffff
        label.text = "  " + types[section].typeName
        label.font = FONT_28PX
        label.textColor = COLOR_222222
        
        return label
    }
    

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        if (rightTableView == tableView)
            && !isScrollDown
            && (rightTableView.isDragging || rightTableView.isDecelerating) {
            selectRow(index: section)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {

        if (rightTableView == tableView)
            && isScrollDown
            && (rightTableView.isDragging || rightTableView.isDecelerating) {
            selectRow(index: section + 1)
        }
    }
    

    private func selectRow(index : Int) {
        leftTableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .top)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if leftTableView == tableView {
            selectIndex = indexPath.row
            self.scrollToTop(section: selectIndex, animated: true)
            leftTableView.scrollToRow(at: IndexPath(row: selectIndex, section: 0), at: .top, animated: true)
        }else{
//            let showGoodsView = LBShowGoodsView()
//            showGoodsView.contentList = goodsModelList
//            UIApplication.shared.keyWindow?.addSubview(showGoodsView)
        }
    }
    
    fileprivate func scrollToTop(section: Int, animated: Bool) {
        
        let headerRect = rightTableView.rect(forSection:section)
        let topOfHeader = CGPoint(x: 0, y: headerRect.origin.y - rightTableView.contentInset.top)
        rightTableView.setContentOffset(topOfHeader, animated: animated)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let tableView = scrollView as! UITableView
        if rightTableView == tableView {
            
            isScrollDown = lastOffsetY < scrollView.contentOffset.y
            lastOffsetY = scrollView.contentOffset.y
        
        }
    }
    
}

extension LBStoreGoodsViewController{
    
    func queryGoodsTypes(_ orgCode:String) {
        
        let parameters:[String:Any] = lb_md5Parameter(parameter: ["orgcode":orgCode])
        
        LBHttpService.LB_Request(.goods_type, method: .get , parameters: parameters, success: {[weak self] (json) in
            
            guard let strongSelf = self else{return}
            strongSelf.types = json["detail"].arrayValue.flatMap{GoodsTypsModel(json: $0)}
            strongSelf.types.forEach{
                strongSelf.loadShopsGoodsData($0.id,$0.orgCode)
            }
            
        }, failure: { (failItme) in
            
            Print(failItme )
            
        }) { (error) in
            
            Print(error)
            
        }
    }
    
    func loadShopsGoodsData(_ typeId:Int,_ orgCode:String)  {
        
        let parameters:[String:Any] = lb_md5Parameter(parameter: ["orgcode":orgCode,
                                                     "goodsStatus":1,
                                                     "typeId":typeId,
                                                     "pageNum":1,
                                                     "pageSize":"20"])
  
        LBHttpService.LB_Request(.goods, method: .get, parameters: parameters, success: {[weak self](json) in
            
            guard let strongSelf = self else{return}
            let model = LBShopsGoodsModel(json: json["detail"])
            strongSelf.goods.append(model)
            model.list.forEach{strongSelf.goodsModelList.append($0)}
            }, failure: {(failItem) in
    
                Print(failItem)
                
        }) { (error) in
            Print(error)
            
        }
    }
}




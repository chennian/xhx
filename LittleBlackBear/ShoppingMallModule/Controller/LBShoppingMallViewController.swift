//
//  LBShoppingMallViewController.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/10/26.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class LBShoppingMallViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    // 优优商家 分页
    var pageNum = 1
    var pages = 1
    
    var zjPostItem : [shoppingCellTye] = []
    
    
    var shoppingModel:LBShoppingModel?
    lazy var cellItem:[shoppingCellTye] = [shoppingCellTye]()
    
    fileprivate var  city = LBKeychain.get(LOCATION_CITY_KEY)
    fileprivate var  lng = LBKeychain.get(longiduteKey)
    fileprivate var  lat = LBKeychain.get(latitudeKey)
    fileprivate var shopName = ""
    
    // CADisplayLink
    //    fileprivate var disPlayLink:CADisplayLink?
    
    var fistRun = true
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(ZJSpaceCell.self)
        $0.register(ZJHomeSeckillCell.self)
        $0.register(ZJHomeClassCell.self)
        $0.register(ZJHomeGroupCell.self)
        $0.register(ZJHomeMerchantCell.self)
        //ZJHomeSeckillCell
        $0.separatorStyle = .none
    }
    //    fileprivate let headerView = LBShoppingHeaderView()
    fileprivate lazy var searchBar = LBShoppingSearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
//        SZLocationManager.shareUserInfonManager.startUpLocation()
        
        self.loadfirstData()
//        SZLocationManager.shareUserInfonManager.getLoaction.asObservable().skip(1).subscribe(onNext: { (lat,lng) in
//            self.loadfirstData()
//        }).disposed(by: disposeBag)
        
//        tableView.addPullRefresh {[unowned self ] in
//            guard self.pageNum < self.pages else{
//                self.tableView.stopPullRefreshEver()
//                return
//            }
//            self.cellItem.removeAll()
//            self.loadData()
//        }
        
        
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        loadData()
        //        disPlayLink = CADisplayLink(target: self,
        //                                        selector: #selector(mainCalculateTimer(_ :)))
        //        disPlayLink!.add(to: RunLoop.current, forMode:.commonModes)
        //
        //        disPlayLink!.isPaused = false
        
        navigationController?.navigationBar.addSubview(searchBar)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        searchBar.removeFromSuperview()
        //        if disPlayLink != nil{
        //            disPlayLink!.invalidate()
        //
        //        }
    }
    

    
    fileprivate func setupUI() {
        
        view.addSubview(tableView)
        
        automaticallyAdjustsScrollViewInsets = false
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|",
        //                                                           options: NSLayoutFormatOptions.alignAllCenterY,
        //                                                           metrics: nil,
        //                                                           views: ["tableView": tableView]))
        //        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|",
        //                                                           options: NSLayoutFormatOptions.alignAllCenterX,
        //                                                           metrics: nil,
        //                                                           views: ["tableView": tableView]))
        tableView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        //        tableView.tableHeaderView = headerView
        //        headerView.delegate = self
        LBShoppingTableViewCellFactory.registerApplyTableViewCell(tableView)
    }
    
    fileprivate func configSearchView()  {
        // 切换城市
        searchBar.clickLocationBtnAction = {[weak self](btn) in
            
            guard let strongSelf = self else {return}
            strongSelf.city = (btn.titleLabel?.text)!
            // 切换城市重新赋值
            strongSelf.pages = 1
            strongSelf.pageNum = 1
//            strongSelf.cellItem.removeAll()
            
            let viewController = LBCityListViewController()
            viewController.selectCity  = { city in
                
                strongSelf.city = city
                btn.setTitle(city, for: .normal)
                let mercId = LBKeychain.get(CURRENT_MERC_ID)
                
                let pageSize = 10
                // 根据城市名称检索城市中心经纬度
                LBMapDistrictSearch.searchManager.searchCity(city: city, district: nil,completion: {
                    strongSelf.lng = "\($0.longitude)"
                    strongSelf.lat = "\($0.latitude)"
                    strongSelf.city = city
                    let paramert:[String:Any] = ["mercId":mercId,
                                                 "city":city,
                                                 "pageSize":pageSize,
                                                 "lng":strongSelf.lng,
                                                 "lat": strongSelf.lat]
                    
                    strongSelf.requiredMainIndexData(paramert: lb_md5Parameter(parameter: paramert),
                                                     compeletionHandler: { (model) in
                                                        strongSelf.shoppingModel = model
                                                        strongSelf.tableView.reloadData()
                                                        //                        strongSelf.headerView.reloadData()
                    }, failCompelectionHandler: {
                        
                    })
                    
                })
            }
            strongSelf.navigationController?.pushViewController(viewController, animated: true)
        }
        
        // 店铺名搜索
        searchBar.searchAction = { [weak self](shopName) in
            
            
            guard shopName.count > 0 else {return}
            guard let strongSelf = self else {return}
            
            // 店铺名搜索 重新赋值
            strongSelf.pages = 1
            strongSelf.pageNum = 1
            strongSelf.cellItem.removeAll()
            
            let mercId = LBKeychain.get(CURRENT_MERC_ID)
            strongSelf.shopName = shopName
            let paramert:[String:Any] = ["mercId":mercId,
                                         "city":strongSelf.city,
                                         "pageSize":"10",
                                         "lng":strongSelf.lng,
                                         "lat":strongSelf.lat,
                                         "merShortName":shopName]
            
            strongSelf.requiredMainIndexData(paramert: lb_md5Parameter(parameter: paramert),
                                             compeletionHandler: { (model) in
                                                strongSelf.shoppingModel = model
                                                strongSelf.tableView.reloadData()
                                                //                strongSelf.headerView.reloadData()
                                                
            }, failCompelectionHandler: nil)
            
        }
        
    }
    
    func didSelectClass(merid : String ,id : String,name : String){
//        let viewController = LBShoppingNextViewController()
//        viewController.title = name//shoppingModel?.catas[indexPath.row].subCataName
//        viewController.paramert = ["city":city,
//                                   "pageSize":10,
//                                   "mercId":merid,
//                                   "subCataId":id,
//                                   "lat":lat,
//                                   "lng":lng]
        
        let vc = ZJSearchShopByCateVC()
        vc.cate = name
        navigationController?.pushViewController(vc, animated: true)
    }
//    func didSelectMiaoMiao(id : String){
//        let viewController = LBSecondCouponDetailViewController()
//        viewController.markId = id
//        viewController.getCouponSuccessAction = {[weak self] in
//            guard let strongSelf = self else{return}
//            strongSelf.loadData()
//        }
//        navigationController?.pushViewController(viewController, animated: true)
//    }
    
    
    func didSelecteMore(name : String){
        if name == "秒秒"||name == "团团"{

            let viewController = LBSecondCouponViewController()
            viewController.title = name
            viewController.city = city
            navigationController?.pushViewController(viewController, animated: true)
        }else{
            guard pageNum < pages else{return}
            pageNum += 1
//            loadData()
        }
    }
    
}
// MARK: UITableViewDelegate  UITableViewDataSource
extension LBShoppingMallViewController:UITableViewDelegate,UITableViewDataSource,
LBPresentLoginViewControllerProtocol{
    
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return shoppingModel?.detail.count ?? 0
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell  = LBShoppingTableViewCellFactory.dequeueReusableCell(withTableView: tableView, indexPath: indexPath, cellItems: cellItem)
        //        cell.selectionStyle = .none
        //        cell.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0)
        //        cell.currentIndexPath = indexPath
        //
        //        return cell
//        ZJLog(messagr: cellItem)
        switch cellItem[indexPath.row] {
        
        case let .title(text,_):
            let cell : LBShoppingLabelCell = tableView.dequeueReusableCell(forIndexPath: indexPath)//= dequeueReusableCell(withTableView: tableView, cellClass: LBShoppingLabelCell.self)
            cell.title_text = text
            cell.didSelectMore.subscribe(onNext: {[unowned self] (title) in
                self.didSelecteMore(name: title)
            }).disposed(by: cell.disposeBag)
            return cell
        case let .image(list):
            let cell : LBShoppingImageCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.cellType = .image(list)
            return cell
        case .shopCell(let type):
            let cell : ZJHomeMerchantCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = type
            return cell
//        case let .mixCell(type):
//            let cell : ZJHomeMerchantCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
//            cell.model = type
//            return cell
        case .newMiaomiaoCoupons(let models ):
            let cell : ZJHomeSeckillCell = tableView.dequeueReusableCell(forIndexPath: indexPath)//ZJHomeSeckillCell
            cell.models = models
            cell.didSelected.subscribe(onNext: {[unowned self] (model) in
                //                self.didSelectMiaoMiao(id: model.id)
                let viewController = LBShopDetailsController()
                viewController.miaomiaoModel = model
                self.navigationController?.pushViewController(viewController, animated: true)
            }).disposed(by: cell.disposeBag)
            return cell
        case .merchantClass(let models):
            let cell : ZJHomeClassCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.models = models
            cell.didSelectPublish.asObserver().subscribe(onNext: {[unowned self] (merid,id,name) in
                self.didSelectClass(merid: merid, id: id, name: name)
            }).disposed(by: cell.disposeBag)
            return cell
        case .newGropuCoupons(let model):
            let cell : ZJHomeGroupCell = tableView.dequeueReusableCell(forIndexPath: indexPath)//dequeueReusableCell(withTableView: tableView, cellClass: LBSecondCouponTableViewCell.self)
            cell.model = model
            return cell
        case .space(_,let color):
            let cell : ZJSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.backgroundColor = color
            return cell
        default:
            let cell : ZJSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        }
    }
    
    /// 当用户停止滚动时才刷新UI
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
//        let tableView = scrollView as! UITableView
//        let visibleCells = tableView.visibleCells.flatMap{String(describing: $0.classForCoder)}
        
    
//        let describing = String(describing:LBSecondCouponTableViewCell.self)
//        if visibleCells.contains(describing.){
        
            //            disPlayLink!.isPaused = false
            //            disPlayLink!.frameInterval = 1
            
//        }else{
            
            //            if disPlayLink!.isPaused == false{
            //                disPlayLink!.isPaused = true
            //            }
//        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.row < cellItem.count else {return 0}
        switch cellItem[indexPath.row] {
            
        case .shopCell:
            return fit(495)//adjustSizeWithUiDesign(attribute: 600, UiDesignWidth: 1080)//fit(312)
        case .title(_):
            return fit(90)
        case  .image(_):
            return fit(200)
        case .secondCoupons(_):
            return 165
        case .newSecondCoupons:
            return fit(435)
        case .newMiaomiaoCoupons:
            return fit(435)
        case .newGropuCoupons:
            return fit(312)
        case .merchantClass:
            return fit(385)
        case .groupCoupons:
            return fit(432)
        case .space(let cellHight, _):
            return cellHight
        default:
            return fit(20)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.row < cellItem.count else {return }
        
        switch cellItem[indexPath.row] {
        case let .shopCell(model):
            
            let viewController = ZJShopDetailVC()
//            viewController.orgCode = model.orgcode
            viewController.shopid = model.shop_id
            navigationController?.pushViewController(viewController, animated: true)
            
            //        case .secondCoupons(let model):
            //
            //            let viewController = LBSecondCouponDetailViewController()
            //            viewController.markId = model.id
            //            viewController.getCouponSuccessAction = {[weak self] in
            //                guard let strongSelf = self else{return}
            //                strongSelf.loadData()
            //            }
            //            navigationController?.pushViewController(viewController, animated: true)
            
        case .newGropuCoupons(let model):
            let viewController = LBShopDetailsController()
            viewController.tuantuanModel = model//.markId = model.id
            //            viewController.getCouponSuccessAction = {[weak self] in
            //                guard let strongSelf = self else{return}
            //                strongSelf.loadData()
            //            }
            navigationController?.pushViewController(viewController, animated: true)
            
        default:
            break
        }
        
    }
}
// MARK: LBShoppingHeaderViewDelegate
extension LBShoppingMallViewController:LBShoppingHeaderViewDelegate{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingModel?.catas.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, _ pageView: UIPageControl, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if shoppingModel != nil,shoppingModel!.catas.count > 8 {
            pageView.isHidden = true
            pageView.numberOfPages = ((shoppingModel?.catas.count)!%8)
            
        }else{
            pageView.isHidden = true
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LBShoppingHeaderCollectionViewCell", for: indexPath) as! LBShoppingHeaderCollectionViewCell
        let model:LBCatasModel = shoppingModel!.catas[indexPath.row]
        cell.titleLabel_text = model.subCataName
        let imgUrl = IS_IPHONEX ?model.iconBigIos:model.iconMidIos
        cell.imageUrl = imgUrl
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mercId = shoppingModel!.catas[indexPath.row].mercid
        let subCataId = shoppingModel!.catas[indexPath.row].id
        let viewController = LBShoppingNextViewController()
        viewController.title = shoppingModel?.catas[indexPath.row].subCataName
        viewController.paramert = ["city":city,
                                   "pageSize":10,
                                   "mercId":mercId,
                                   "subCataId":subCataId,
                                   "lat":lat,
                                   "lng":lng]
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView, _ pageView: UIPageControl) {
        pageView.currentPage = Int(scrollView.contentOffset.x / KSCREEN_WIDTH)
    }
    
    
    
}
/// 首次数据加载失败时，点击重新加载数据
extension LBShoppingMallViewController{
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        for touch in touches {
//            if touch.view == self.view {
//                loadData()
//                setupUI()
//                configSearchView()
//            }
//        }
//    }
}
// MARK: loadData
extension LBShoppingMallViewController:LBShoppingHttpServer{
    
    func loadfirstData()  {
        
        if !fistRun{ return }
        fistRun = false
        zjPostItem.removeAll()
    
        
        SNRequest(requestType: API.getMiaoMiaoList(mercId: "", size: 2, page: 0), modelType: [ZJHomeMiaoMiaoModel.self]).subscribe(onNext: { (result) in
            switch result{
            case.success(let models):
                //                if self.zjPostItem.count != 0 {
                //                    self.oldGetData()
                //                }
                if models.count == 0 {
                    self.zjPostItem.append(.space(cellHight : fit(0) ,color : Color(0xf5f5f5)))
                    self.oldGetData()
                    return
                    
                }
                let item = shoppingCellTye.newMiaomiaoCoupons(models)
                
                self.zjPostItem.insert(item, at: 0)
                self.zjPostItem.insert(.title("秒秒",""),at :0)
                self.zjPostItem.insert(.space(cellHight : fit(20) ,color : Color(0xf5f5f5)),at :0)
                
                //                ZJLog(messagr: self.zjPostItem.count)
                //                if self.zjPostItem.count > 2{
                //                    self.oldGetData()
                //                }
                self.oldGetData()
            case .fail(_,let msg):
                ZJLog(messagr: msg)
                self.oldGetData()
            default:
//                break
                self.oldGetData()
            }
        }).disposed(by: disposeBag)
        
        
        
    }
    
    func oldGetData(){
        let  mercId = LBKeychain.get(CURRENT_MERC_ID)
        if city.isChinese() == false  {
            /// default深圳
            city = "深圳市"
            lng = "114.047870066526"
            lat = "22.6008299566074"
        }
        let paramert:[String:Any] = ["mercId":mercId,
                                     "city":city,
                                     "pageSize":"10",
                                     "lng":lng,
                                     "lat":lat,
                                     "pageNum":pageNum,
                                     "merShortName":shopName]
        
        requiredMainIndexData(paramert: lb_md5Parameter(parameter: paramert),
                              compeletionHandler: {[weak self] (model) in
                                guard let strongSelf = self else {return}
                                
                                strongSelf.shoppingModel = model
                                //                                print(self?.cellItem)
                                //                                ZJLog(messagr: self?.cellItem)
                                strongSelf.configSearchView()
                                strongSelf.setupUI()
                                strongSelf.getPerfectShop()
//                             getPerfectShop()
                                
        }) {[weak self] in
            
            guard let strongSelf  = self else{return}
            strongSelf.getPerfectShop()
            strongSelf.tableView.stopPullRefreshEver()
            
        }
        
    }
    
    
    func getPerfectShop(){
        SNRequest(requestType: API.getPerfectShop(page: "1"), modelType: [ZJperfectShopModel.self]).subscribe(onNext: { (res) in
            switch res{
            case .success(let models):
//                let shops = models.map({ (mode) -> shoppingCellTye in
//                    let type = shoppingCellTye.shopCell(mode)//mixCell(mode)
//                    return type
//                })
//                self.cellItem.append(contentsOf: shops)

                models.forEach({ (mode) in
                    let type = shoppingCellTye.shopCell(mode)//mixCell(mode)
                    self.cellItem.append(type)
                })
                
                self.tableView.reloadData()
                //            strongSelf.headerView.reloadData()
//                self.tableView.stopPullRefreshEver()
            case .fail:
                SZHUD("商家列表获取失败", type: .error, callBack: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
//        Alamofire.request("http://tang11ers.tpddns.cn:8014/api/perfectStore", method: .post, parameters: ["page":"1"], encoding: URLEncoding.default, headers: nil).response { (res) in
//            ZJLog(messagr: res)
//        }
        
    }
    
    /// 定时器
    //    func mainCalculateTimer(_ disPlayLink:CADisplayLink){
    //
    //        DispatchQueue.main.async {[weak self] in
    //            guard let strongSelf = self else{return}
    //
    //            for cell in strongSelf.tableView.visibleCells {
    //                if cell.isKind(of: LBSecondCouponTableViewCell.self){
    //
    //                    guard let indexPath =  strongSelf.tableView.indexPath(for: cell),
    //                        indexPath.row < strongSelf.cellItem.count else{return}
    //                    switch strongSelf.cellItem[indexPath.row] {
    //                    case .secondCoupons(let model):
    //                        (cell as! LBSecondCouponTableViewCell).calculationCurrentTime(model.validEndDate + " " + "23:59:59")
    //                    case .groupCoupons(let model):
    //                        (cell as! LBSecondCouponTableViewCell).calculationCurrentTime(model.validEndDate + " " + "23:59:59")
    //                    default:break
    //                    }
    //                }
    //            }
    //        }
    //    }
    
}



/*
 "shop_id": "135",
 "category": null,
 "shopName": "我在",
 "phone": null,
 "logo": null,
 "tab": null,
 "latitude": null,
 "longitude": null,
 "add_time": "2018-05-09 07:55:45"
 */

import SwiftyJSON
class ZJperfectShopModel : SNSwiftyJSONAble{
    var shop_id : String
    var category : String
    var shopName : String
    var phone : String
    var logo : String
    var tab : String
    var latitude : String
    var longitude : String
    var add_time : String
    var distance : String
    var banner : String
    required init?(jsonData: JSON) {
        shop_id = jsonData["shop_id"].stringValue
        category = jsonData["category"].stringValue
        shopName = jsonData["shopName"].stringValue
        phone = jsonData["shop_phoned"].stringValue
        logo = jsonData["logo"].stringValue
        tab = jsonData["tab"].stringValue
        latitude = jsonData["latitude"].stringValue
        longitude = jsonData["longitude"].stringValue
        add_time = jsonData["add_time"].stringValue
        banner = jsonData["banner"].stringValue
        
        let currentLocation = CLLocation(latitude: (LBKeychain.get(latitudeKey) as NSString).doubleValue, longitude: (LBKeychain.get(longiduteKey) as NSString).doubleValue )
        let targetLocation = CLLocation(latitude: (latitude as NSString).doubleValue, longitude:(longitude as NSString).doubleValue)
        distance = String(format: "%.2f", currentLocation.distance(from: targetLocation) / 1000.0)//currentLocation.distance(from: targetLocation)
        
    }
}

import Alamofire

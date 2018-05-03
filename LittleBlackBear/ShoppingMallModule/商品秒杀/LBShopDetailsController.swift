//
//  LBShopDetailsController.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/17.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift
/// banner模型
// 图片数组 、活动倒计时
struct ZJActgivityDetailBannerCellModel {
    var imgArray : [String]
    var endTime : String?
    
}
/// 名称价格模型
// 名称价格 已销数量
struct ZJActgivityDetailNameCellModel{
    var name : String
    var price : String
    var count : String
    
}
///商家信息模型
// 头像 、商家名、地址、电话、距离、标签
struct ZJActgivityDetailMerchantCellModel {
    var icon : String
    var name : String
    var addredd : String
    var phone : String
    var distance : String
    var lab : String
    
}
/// 团团信息模型
//结束时间、总需人数、当前人数、是否有活动
struct ZJActgivityDetailTuantuanInfoCellModel {
    
    var hasActivity : Bool = false
    
    var needPerson : String
    
}
enum ZJActgivityDetailCellType {
    case banner(model :ZJActgivityDetailBannerCellModel)
    case nameAndPRice(model :ZJActgivityDetailNameCellModel)
    case space(height : CGFloat ,color : UIColor)
    case description(content : String)
    case merchant(model : ZJActgivityDetailMerchantCellModel)
    case tuantuan(model : ZJActgivityDetailTuantuanInfoCellModel)
}

class ZJActgivityDetailCellModel {
    var type : ZJActgivityDetailCellType = .space(height : 0.0 ,color : Color(0xf5f5f5)){
        didSet{
            switch type {
            case .banner:
                cellHeight = fit(504)
            case .nameAndPRice:
                cellHeight = fit(210)
            case .space(let height ,_):
                cellHeight = height
            case .merchant:
                cellHeight = fit(230)
            case .tuantuan(let model):
                cellHeight = model.hasActivity ? fit(235) : fit(192)
            case .description(let content):
                //fit（130）
                let size = countWidth(text: content, size: CGSize(width: fit(710), height: CGFloat.greatestFiniteMagnitude), font: Font(30))//countWidth(text: content, font: Font(30))
                cellHeight = fit(130) + size.height
                //            default:
                //                cellHeight = fit(0)
            }
        }
    }
    var cellHeight : CGFloat = 0.0
}
class LBShopDetailsController: UIViewController ,LBPresentLoginViewControllerProtocol{
    //秒秒接口模型ZJHomeMiaoMiaoModel  团团接口模型ZJHomeGroupModel
    var id : String = ""
    var miaomiaoModel : ZJHomeMiaoMiaoModel? {
        didSet {
            //            self.title = "秒秒"
            
            bottomButton.setTitle("立即领取", for: .normal)
            cellModel.removeAll()
            let headModel = ZJActgivityDetailCellModel()
            headModel.type = .banner(model: ZJActgivityDetailBannerCellModel.init(imgArray:  anayliseImgs(imgs: miaomiaoModel!.detailImg), endTime: miaomiaoModel!.endTime))
            
            let nameAndPriceModel = ZJActgivityDetailCellModel()
            nameAndPriceModel.type = .nameAndPRice(model: ZJActgivityDetailNameCellModel.init(name: miaomiaoModel!.name, price: miaomiaoModel!.price, count: miaomiaoModel!.popularity))
            
            let descriptionModel = ZJActgivityDetailCellModel()
            descriptionModel.type = .description(content:  miaomiaoModel!.description)
            
            let merchantModel = ZJActgivityDetailCellModel()
            merchantModel.type = .merchant(model: ZJActgivityDetailMerchantCellModel.init(icon: miaomiaoModel!.mainImg, name: miaomiaoModel!.shopName, addredd: miaomiaoModel!.merAddress, phone: miaomiaoModel!.phone, distance: "5km", lab: miaomiaoModel!.merLabel))
            
            let spcae = ZJActgivityDetailCellModel() ;spcae.type = .space(height: fit(20), color: Color(0xf5f5f5))
            
            cellModel = [headModel,nameAndPriceModel,spcae,descriptionModel,spcae,merchantModel,spcae]
            id = miaomiaoModel!.id
            tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(createImageBy(color: .white), for: .default)
        self.navigationController?.navigationBar.shadowImage = UINavigationController().navigationBar.shadowImage
        
        
    }
    
//    viewwi
    
    
    
    var tuantuanModel : ZJHomeGroupModel?{
        didSet{
            //            self.title = "团团"
            id = tuantuanModel!.id
            cellModel.removeAll()
            bottomButton.setTitle("发起拼团", for: .normal)
            let headModel = ZJActgivityDetailCellModel()
            headModel.type = .banner(model: ZJActgivityDetailBannerCellModel.init(imgArray:  anayliseImgs(imgs: tuantuanModel!.detailImg), endTime: nil))
            
            let nameAndPriceModel = ZJActgivityDetailCellModel()
            nameAndPriceModel.type = .nameAndPRice(model: ZJActgivityDetailNameCellModel.init(name: tuantuanModel!.name, price: tuantuanModel!.price, count: tuantuanModel!.popularity))
            
            let tuantuaninfoModel = ZJActgivityDetailCellModel()
            tuantuaninfoModel.type = .tuantuan(model: ZJActgivityDetailTuantuanInfoCellModel.init(hasActivity: false,needPerson: tuantuanModel!.enterNum))
            
            let descriptionModel = ZJActgivityDetailCellModel()
            descriptionModel.type = .description(content:  tuantuanModel!.description)
            
            let merchantModel = ZJActgivityDetailCellModel()
            merchantModel.type = .merchant(model: ZJActgivityDetailMerchantCellModel.init(icon: tuantuanModel!.mainImg, name: tuantuanModel!.shopName, addredd: tuantuanModel!.merAddress, phone: tuantuanModel!.phone, distance: "5km", lab: tuantuanModel!.merLabel))
            
            
            let spcae = ZJActgivityDetailCellModel() ;spcae.type = .space(height: fit(20), color: Color(0xf5f5f5))
            
            cellModel = [headModel,nameAndPriceModel,spcae,tuantuaninfoModel,spcae,descriptionModel,spcae,merchantModel,spcae]
            tableView.reloadData()
        }
    }
    
    
    @objc func bottomButtonClick(){
        if LBKeychain.get(ISLOGIN) == LOGIN_TRUE{
            //请求接口
            SNRequestBool(requestType: API.getConpoun(coupon_id: id)).subscribe(onNext: {[unowned self] (result) in
                switch result{
                case .bool:
                    let vc = ZJGetCouponVC()
                    vc.transitioningDelegate = self.manager
                    vc.modalPresentationStyle = .custom
                    self.manager.presentFrame = CGRect(x: (ScreenW - fit(578)) * 0.5, y: fit(253), width: fit(578), height: fit(640))
                    vc.goToMyCouponList.subscribe(onNext: { () in
                        self.navigationController?.pushViewController(ZJMyCouponViewController(), animated: true)
                    }).disposed(by: self.disposbag)
                    self.present(vc, animated: true, completion: nil)
                case .fail(_,let msg):
                    SZHUD(msg ?? "", type: .error, callBack: nil)
                default:
                    break
                }
            }).disposed(by: disposbag)
            
            
        }else{
//            prs
            let viewController = LBLoginViewController()
            viewController.loginSuccessHanlder = {

                viewController.dismiss(animated: true, completion: nil)
            }
            
            present(LBNavigationController(rootViewController:viewController), animated: true, completion: nil)
        }
    }
    
    let manager = DDZPickerViewManager()
    
    var cellModel : [ZJActgivityDetailCellModel] = []
    
    fileprivate let tableView:UITableView = SNBaseTableView().then{
        //          $0.backgroundColor = color_bg_gray_f5
        $0.register(LBShopCroupSliderCell.self)
        $0.register(LBShopGoodNameCell.self)
        $0.register(LBDescriptionCell.self)
        $0.register(LBShopDescriptionCell.self)
        $0.register(LBShopBottonCell.self)
        $0.register(LBShopGroupCell.self)
        $0.register(ZJSpaceCell.self)
        //        $0.separatorStyle = .none
    }
    
    var cellHeight:CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        loadData()
        setupUI()
    }
    
    
    let bottomButton = UIButton().then{
        $0.layer.cornerRadius = fit(4)
        $0.titleLabel?.font = Font(30)
        $0.backgroundColor = Color(0x272424)
    }
    
    func anayliseImgs(imgs : String) -> [String]{
        
        
        var imgStr : [String] = []
        
        var Str = imgs
        
        while Str.contains("|") {
            let rang = (Str as NSString).range(of: "|")
            let img = (Str as NSString).substring(to: rang.location)
            
            imgStr.append(img)
            Str = (Str as NSString).substring(from: rang.location + 1)
        }
        
        imgStr.append(Str)
        
        return imgStr
        
        
    }
    let disposbag = DisposeBag()
    
    let backBtn = UIButton().then({
        $0.setBackgroundImage(UIImage(named:"map_return"), for: .normal)
    })
    
    
    func setupUI() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        
        
        
        
        
        
        //        self.title = "新建团团"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        self.view.addSubview(bottomButton)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(-LL_StatusBarAndNavigationBarHeight)
            make.bottom.equalTo(bottomButton.snp.top).snOffset(-10)
            make.right.equalToSuperview()
        }
        bottomButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().snOffset(-10)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(700)
            make.height.snEqualTo(100)
        }
        backBtn.addTap(self, action: #selector(backPop))
        
        
        bottomButton.addTarget(self, action: #selector(bottomButtonClick), for: .touchUpInside)
    }
    @objc func backPop(){
        self.navigationController?.popViewController(animated: true)
    }
    func  loadData(){
        let paramert:[String:String] = ["":"","":""]
        LBHttpService.LB_Request(.activity, method: .post, parameters: lb_md5Parameter(parameter: paramert), headers: nil, success: {[weak self] (json) in
            
            print(json)
            }, failure: { (failItem) in
        }) { (error) in
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        loadData()
        navigationController?.navigationBar.setBackgroundImage(createImageBy(color: UIColor.rgbColorWith(hex: 0x000000, alpha: 0.0001)), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    
    
}

extension LBShopDetailsController:UITableViewDelegate,UITableViewDataSource{
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return 1
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //case
        
        
        switch cellModel[indexPath.row].type {
        case .banner(let model):
            let cell : LBShopCroupSliderCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = model
            return cell
        case .nameAndPRice(let model):
            let cell : LBShopGoodNameCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = model
            return cell
        case .space(_,let color):
            let cell : ZJSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.backgroundColor = color
            return cell
        case .tuantuan(let model):
            let cell : LBShopGroupCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = model
            return cell
        case .merchant(let model):
            let cell : LBShopDescriptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = model
            return cell
        case .description(let content):
            let cell : LBDescriptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.descriptionDetail.text = content
            return cell
        }
        
        
        //
        //        if indexPath.row == 0{
        //            let cell : LBShopGoodNameCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        //            cellHeight = cell.lableHeight + 125
        //            return cell
        //
        //        }else if indexPath.row == 1{
        //            let cell : ZJSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        //            return cell
        //
        //        }else if indexPath.row == 2{
        //            let cell : LBShopGroupCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        //            return cell
        //
        //        }else if indexPath.row == 3{
        //             let cell : ZJSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        //            return cell
        //
        //        }else if indexPath.row == 4{
        //             let cell : LBDescriptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        //            return cell
        //
        //        }else if indexPath.row == 5{
        //            let cell : ZJSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        //            return cell
        //
        //        }else if indexPath.row == 6{
        //            let cell :LBShopDescriptionCell  = tableView.dequeueReusableCell(forIndexPath: indexPath)
        //            return cell
        //        }else if indexPath.row == 7{
        //            let cell : ZJSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        //            return cell
        //        }else {
        //            let cell : LBShopBottonCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        //            cell.submitBoutton.setTitle("立即跟团", for: UIControlState.normal)
        //            return cell
        //        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //case
        
        return cellModel[indexPath.row].cellHeight
    }
    
}


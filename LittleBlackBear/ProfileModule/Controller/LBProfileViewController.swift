//
//  LBProfileViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/5.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBProfileViewController: UITableViewController {
    fileprivate let reuseIdentifier = "LBProfileViewController"
    
    fileprivate var currentIndexPath:IndexPath?
    
    typealias PickedImageHandle = (UIImage) -> ()
    fileprivate var imagePickerFinishHandle: PickedImageHandle?
    
    fileprivate var data = [[String]]()
    fileprivate var titltes = [String]()
    fileprivate var images = [[String]]()
    
    fileprivate lazy var headerView = LBProfileHeaderView()
    fileprivate lazy var footerView = LBPriofileFooterView()
    
    
    
    fileprivate var listControllers:[[Any]] = [[Any]]()
    
    
    let mercAlertView = LBMercApplyAlterView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "我的"
        view.backgroundColor = COLOR_e6e6e6
        setupUI()
        merchantStatus()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"setting")?.withRenderingMode(.alwaysOriginal),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rightItemAction))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIApplication.shared.setStatusBarStyle(.default, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(COLOR_e60013), for: .default)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:COLOR_ffffff,NSFontAttributeName:UIFont.boldSystemFont(ofSize: 16*default_scale)]
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor.white), for: .default)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.black,
                                                                   NSFontAttributeName:UIFont.boldSystemFont(ofSize: 16*default_scale)]
        
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
        closeAction()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupUI() {
        
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
        tableView.register(LBProfileTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        
        headerView.isRefreshData = true
        headerView.uploadIconImageAction={[weak self](imageView) in
            
            guard let strongSelf = self else{return}
            
            guard LBKeychain.get(ISLOGIN) == LOGIN_TRUE else {
                
                strongSelf.showAlertView(message: "请先登录!", actionTitles: ["取消","确定"], handler: { (action) in
                    if action.title == "确定"{
                        strongSelf.presentLoginViewController({
                            strongSelf.merchantStatus()
                            strongSelf.headerView.isRefreshData = true
                            strongSelf.tableView.reloadData()
                        }, nil)
                    }
                })
                return
            }
            
            strongSelf.showPhotoPickerView(finishHandel: { (image) in
                
                
                
                imageView.image = image
                
                
                let date = NSDate()
                let dateFormatter = DateFormatter()
                let timestamp = Int(round(date.timeIntervalSince1970))
                dateFormatter.dateFormat = "yyyyMMdd"
                let floderDate = dateFormatter.string(from: date as Date)
                
                let md5Str = "\(timestamp)"
                let objecKey = "\((floderDate as NSString).substring(to: 4))/" + "\((floderDate as NSString).substring(from: 4))/" + "\((str: md5Str ))".md5() + ".jpg"
                let path = frontUrl + objecKey
                
                let manager = DDZOssManager()
                
                manager.uploadImg(objectKey: objecKey, image: image.compressImage(image: image)!,imageName:"userIcon",bucketName: BucketName, endPoint: EndPoint,path:path){[weak self] (success) in
                    if success{
                        
                        let parameters = lb_md5Parameter(parameter: ["mercNum":LBKeychain.get(CURRENT_MERC_ID),"headUrl":path])
                        LBHttpService.LB_Request(.updateHeadImg, method: .post, parameters: parameters, success: { (_) in
                            strongSelf.showAlertView("上传成功!", "确定", nil)
                            
                        }, failure: { (failtItem) in
                            strongSelf.showAlertView(failtItem.message, "确定", nil)
                        }, requestError: { (_) in
                            strongSelf.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)
                        })
                    }else{
                        SZHUD("图片上传失败", type: .error, callBack: nil)
                        return
                    }
                }
            })
            
        }
        
        footerView.applyAction = {[weak self] (btn) in
            guard let strongSelf = self else { return }
            
            guard LBKeychain.get(ISLOGIN) == LOGIN_TRUE else {
                
                strongSelf.showAlertView(message: "请先登录!", actionTitles: ["取消","确定"], handler: { (action) in
                    if action.title == "确定"{
                        strongSelf.presentLoginViewController({
                            strongSelf.merchantStatus()
                            strongSelf.headerView.isRefreshData = true
                            strongSelf.tableView.reloadData()
                        }, nil)
                    }
                })
                return
            }
            
            if LBKeychain.get(ISMERC) == TRUE{
                let viewController = LBMerchantApplyTypeViewController()
                viewController.isOtherApply = .otherApply
                strongSelf.navigationController?.pushViewController(viewController, animated: true)
            }else{
                strongSelf.view.addSubview(strongSelf.mercAlertView)
                strongSelf.mercAlertView.delegate = strongSelf
            }
        }
        
    }
    
    func rightItemAction(){
        
        let viewController = LBSettingViewController()
        viewController.loginSuccessHanlder = {[weak self]in
            guard let `self` = self else{return}
            self.merchantStatus()
            self.headerView.isRefreshData = true
            self.tableView.reloadData()
        }
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    fileprivate func merchantStatus() {
        
        data.removeAll()
        titltes.removeAll()
        images.removeAll()
        listControllers.removeAll()
        
        data = [["我的钱包","我的积分","我的足迹","我的关注",
                 "分享","我的头条","我的卡券"]]
        titltes = ["用户中心"]
        images = [["my_wellat","my_ integral","my_foot_mark","my_attention",
                   "share_normal","my_news","my_card_ coupons"]]
        listControllers = [[NSStringFromClass(LBMyWalletWebViewController.self),
                            NSStringFromClass(LBIntegralWebViewController.self),
                            NSStringFromClass(LBMyFootMarkWebViewController.self),
                            NSStringFromClass(LBMyAttentionWebViewController.self),
                            
                            NSStringFromClass(LBShareRQCodeViewController.self),
                            NSStringFromClass(ZJHeadTopicManageVC.self),
                            NSStringFromClass(LBMyCouponWebViewController.self),
                            
                            ]]
        let isMerc = LBKeychain.get(ISMERC)
        let isAgent = LBKeychain.get(ISAGENT)
        
        if isAgent == TRUE, isMerc == TRUE {
            
            data.insert(["我的商家","我的代理","交易管理","我的收益",], at: 0)
            images.insert( ["my_merchant","my_agent","changeManger",
                            "my_icome",], at: 0)
            titltes.insert("运营中心", at: 0)
            //ZJAccoutBookServiceVC
            listControllers.insert( [NSStringFromClass(LBMyMerchantWebViewController.self),
                                     NSStringFromClass(LBMyAngencyWebViewController.self),
                                     NSStringFromClass(LBExchangeWebViewController.self),
                NSStringFromClass(ZJAccoutBookServiceVC.self)],at: 0)
        
            data.insert(["收款码","我的账本","营销","流量管理",
                         "店铺管理","我的商品","店铺卡券","店铺红包"], at: 1)
            titltes.insert("商户中心", at: 1)
            
            images.insert([
                "money_code","my_account_book","marketing","my_fans",
                "shop_manage","my_shopping","shop_card","shop_redPacket"], at: 1)
            
            listControllers.insert([
                //ZJMerchantAccountBookVC。 LBMyAcountBookWebViewController
                NSStringFromClass(ZJPyErcodeVC.self),
                NSStringFromClass(ZJMerchantAccountBookVC.self),
                NSStringFromClass(LBNewMarketingWebViewController.self),
                NSStringFromClass(ZJMyMemberVC.self),//ZJMyMemberVC。LBFansWebViewController
                
                NSStringFromClass(LBMyStoreManagemetWebViewController.self),
                NSStringFromClass(LBShoppingWebViewController.self),
                NSStringFromClass(LBshoppingCouponsWebViewController.self),
                NSStringFromClass(LBShopRedPacketWebViewController.self),
//                NSStringFromClass(LBMyIcomeWebViewController.self),
                
                ], at: 1)
        }
        
        if isMerc == TRUE,isAgent == FALSE {
            
            data.insert(["收款码","我的账本","营销","流量管理",
                         "店铺管理","我的商品","店铺卡券","店铺红包"], at: 0)
            titltes.insert("商户中心", at: 0)
            
            images.insert([
                "money_code","my_account_book","marketing","my_fans",
                "shop_manage","my_shopping","shop_card","shop_redPacket",
                "my_icome",], at: 0)
            
            listControllers.insert([
                
                NSStringFromClass(ZJPyErcodeVC.self),
                NSStringFromClass(ZJMerchantAccountBookVC.self),
                NSStringFromClass(LBNewMarketingWebViewController.self),
                NSStringFromClass(ZJMyMemberVC.self),
                
                NSStringFromClass(LBMyStoreManagemetWebViewController.self),
                NSStringFromClass(LBShoppingWebViewController.self),
                NSStringFromClass(LBshoppingCouponsWebViewController.self),
                NSStringFromClass(LBShopRedPacketWebViewController.self),
//                NSStringFromClass(LBMyIcomeWebViewController.self),

                ], at: 0)
            
        }
        
        footerView.buttonTitle = isMerc == TRUE ?"帮人申请成为商家":"申请成为商家"
    }
    
}
// MARK: - Table view data source
extension LBProfileViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        currentIndexPath = indexPath
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LBProfileTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell._indexPath = indexPath
        cell.label_text = titltes[indexPath.section]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50*AUTOSIZE_Y + calculateCellHight(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    private func calculateCellHight(indexPath: IndexPath)-> CGFloat  {
        let count  = data[indexPath.section].count
        if count <= 4 {
            return 91.5
        }
        if count > 4 && count <= 8 {
            return 91.5 * 2
        }
        if count > 8 && count <= 16 {
            return 91.5 * 3
        }
        if count > 16 && count <= 32 {
            return 91.5 * 4
        }
        if count > 32 && count <= 64 {
            return 91.5 * 5
        }
        return 0
    }
    
    
}
/// LBProfileTableViewCellDelegate
extension LBProfileViewController:LBProfileTableViewCellDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  !(currentIndexPath != nil) ? 0:data[(currentIndexPath?.section)!].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LBProfileCollectionCell", for: indexPath) as! LBProfileCollectionCell
        guard currentIndexPath != nil else {
            return cell
        }
        
        cell.titleLabel_text = data[(currentIndexPath?.section)!][indexPath.row]
        cell.imageName = images[(currentIndexPath?.section)!][indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, tableViewIndePath: IndexPath, didSelectItemAt indexPath: IndexPath) {
        
        let viewController = NSClassFromString(listControllers[tableViewIndePath.section][indexPath.row] as! String) as! UIViewController.Type
        guard LBKeychain.get(ISLOGIN) == LOGIN_TRUE else {
            
            showAlertView(message: "请先登录!", actionTitles: ["取消","确定"], handler: {[weak self] (action) in
                guard let strongSelf = self else{return}
                if action.title == "确定"{
                    strongSelf.presentLoginViewController({
                        strongSelf.merchantStatus()
                        strongSelf.headerView.isRefreshData = true
                        strongSelf.tableView.reloadData()
                        collectionView.reloadData()
                    }, nil)
                }
            })
            return
        }
        
//        if data[indexPath.section][indexPath.row] == "营销" {
//            return
//        }
        
        
        
        navigationController?.pushViewController(viewController.init(), animated: true )
    }
    
}

// MARK: LBMercApplyAlterViewDelegate
extension LBProfileViewController:LBMercApplyAlterViewDelegate{
    
    func closeAction() {
        mercAlertView.removeFromSuperview()
    }
    func selfApplyAction(_ button: UIButton) {
        let viewController = LBMerchantApplyTypeViewController()
        viewController.isOtherApply = .selfApply
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    func otherApplyAction(_ btn: UIButton) {
        let viewController = LBMerchantApplyTypeViewController()
        viewController.isOtherApply = .otherApply
        navigationController?.pushViewController(viewController, animated: true)
    }
}
/// showPhotoPickerView
extension LBProfileViewController {
    
    fileprivate func showPhotoPickerView(finishHandel: @escaping PickedImageHandle) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action0 = UIAlertAction(title: "拍照", style: .default) {[weak self] (_)  in
            self?.showImagePickerController(sourceType: .camera, finishHandel: finishHandel)
        }
        let action1 = UIAlertAction(title: "相册", style: .default) {[weak self] (_)  in
            self?.showImagePickerController(sourceType: .photoLibrary, finishHandel: finishHandel)
        }
        let action2 = UIAlertAction(title: "取消", style: .cancel) {(_)  in
        }
        alertController.addAction(action0)
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showImagePickerController(sourceType: UIImagePickerControllerSourceType, finishHandel: @escaping PickedImageHandle) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = false
        self.imagePickerFinishHandle = finishHandel
        present(imagePicker, animated: true, completion: nil)
    }
}
/// 上传图片
extension LBProfileViewController{
    
    fileprivate func uploadmerchantImageInfo(image:UIImage,imgName:String,parameters: [String:Any]?=nil,success:@escaping ((String)->())){
        
        let parm = lb_md5Parameter(parameter: parameters)
        LBHttpService.LB_uploadSingleImage(.shopPicUpload, image, imgName, parameters: parm as! [String : String], success: { (json) in
            success(json["PICURL"].stringValue)
        }, failure: { (failItem) in
            UIAlertView(title: "提示", message: failItem.message, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
        }) { (error) in
            UIAlertView(title: "提示", message: error.localizedDescription , delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
            
        }
    }
    
}

extension LBProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        self.imagePickerFinishHandle?(image)
        picker.dismiss(animated: true, completion: nil)
    }
}
extension LBProfileViewController:LBPresentLoginViewControllerProtocol{}

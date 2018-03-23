//
//  LBShoppingMallDetailViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/13.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBShoppingMallDetailViewController: UIViewController {
    
    var orgCode = ""
    var mercId = ""
    fileprivate var shopName:String = ""
    fileprivate var mercInfoModel:LBHomeMerchantModel?
    fileprivate var commentItem:LBCommentListModel<commentImageListModel>?
    fileprivate var cellItem:[merChantInfoCellTye] = []

    fileprivate var imageItems:[IndexPath:imageListModel] = [:]
    fileprivate var thumbnailView:UIImageView?
    fileprivate var photos:[String] = []
    fileprivate let shareView = BXShareView()
    
    fileprivate let tableView:UITableView = UITableView()

    
    fileprivate lazy var rightItem:(UIView,UIButton) = {
        
        let view = UIView(frame: CGRect(x: KSCREEN_WIDTH-60,
                                        y: 20,
                                        width: 60,
                                        height: 44))
        
        view.backgroundColor = UIColor.white

        let button  = UIButton(frame: view.bounds)
        button.setTitle("关注", for: .normal)
        button.setTitle("已关注", for: .selected)
        button.titleLabel?.font = FONT_28PX
        button.setTitleColor(COLOR_e60013, for: .normal)
        button.setTitleColor(COLOR_9C9C9C, for: .selected)
    
        button.addTarget(self, action: #selector(attentionAction(_ :)), for: .touchUpInside)
        view.addSubview(button)
        
        return (view,button)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationItem.title = "商家详情"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightItem.0)
        requiredMercInfo()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: ["tableView": tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["tableView": tableView]))
        LBMerchantIfonDetailCellFactory.registerApplyTableViewCell(tableView)
    
        
    }
    
    func attentionAction(_ button:UIButton)  {
        
        guard LBKeychain.get(ISLOGIN) == LOGIN_TRUE else {
            
            showAlertView(message: "请先登录",actionTitles: ["取消","确定"],handler: {[weak self] (action ) in
                
                guard let strongSelf = self else {return}
                guard action.title == "确定" else{return}

                            strongSelf.presentLoginViewController({
                                
                            }, nil)

            })
            return
        }
        // 关注
        if  button.isSelected == false {
            LBHttpService.LB_Request(.favourite,
                                     method: .post,
                                     parameters: ["orgcode":orgCode,
                                                  "mercid":LBKeychain.get(CURRENT_MERC_ID)],
                                     success: { (json) in
                                        button.isSelected = !button.isSelected

            }, failure: {[weak self] (failItem) in
                guard let strongSelf  = self else{return}
                strongSelf.showAlertView(failItem.message, "确定", nil)
                
            }) {[weak self] (erroro) in
                guard let strongSelf = self else{return}
                strongSelf.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)
            }
            
        }else{
            // 取消关注
            LBHttpService.LB_Request(.favourite_delete,
                                     method: .post,
                                     parameters: ["orgcode":orgCode,
                                                  "mercid":LBKeychain.get(CURRENT_MERC_ID)],
                                     success: { (json) in
                                        button.isSelected = !button.isSelected

            }, failure: {[weak self] (failItem) in
                guard let strongSelf  = self else{return}
                strongSelf.showAlertView(failItem.message, "确定", nil)
                
            }) {[weak self] (erroro) in
                guard let strongSelf = self else{return}
                strongSelf.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)
            }
        }
        

      
    }
    
}
// MARK: UITableViewDelegate  UITableViewDataSource
extension LBShoppingMallDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellItem.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellItem[indexPath.row] {
        case let .comment(model):
            
            let cell:LBShowCommentCell = LBMerchantIfonDetailCellFactory.dequeueReusableCell(withTableView: tableView, indexPath: indexPath, cellItems: cellItem) as! LBShowCommentCell
            cell.model = model
            cell.selectionStyle = .none
            cell.showPotoBrowser = {[weak self](imageView)in
                guard let strongSelf = self else{return}
                strongSelf.photos.removeAll()
                let browser = PhotoBrowser(showByViewController: strongSelf, delegate: strongSelf)
                browser.pageControlDelegate = PhotoBrowserDefaultPageControlDelegate(numberOfPages: model.imageList.count)
                strongSelf.thumbnailView = imageView
                strongSelf.photos = model.imageList
                browser.show(index: imageView.tag)
                
            }
            
            cell.currentIndexPath = indexPath
            return cell
            
        default:
            let cell  = LBMerchantIfonDetailCellFactory.dequeueReusableCell(withTableView: tableView, indexPath: indexPath, cellItems: cellItem)
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0)
            cell.currentIndexPath = indexPath
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch cellItem[indexPath.row] {
        case let .images(_,models):
			return models.count > 0 ?200.0:0
        case .mixCell(let model):
            shopName = model.merShopName
            return 120
        case .common(let title ,let model,_):
            if title == "顾客须知"{
                return model.noticeH + 60
            }
           return model.explanH + 60
        case let .comment(model):
            var imageH:CGFloat = 0
            if model.imageList.count == 1{
                let imageView = UIImageView()
                imageView.kf.setImage(with: URL(string:model.imageList[0]))
                if let image = imageView.image,image.size.height > 0{
                    imageH = image.onlyOneImageForHeight()
                }
                return imageH + model.textH + 60+10
            }else{
                return model.cellHeight
            }
        case .shopingCell(_):
            return 190
        default:
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        switch cellItem[indexPath.row] {
            
        case .mixCell(let model):
            if model.merContactTel.count > 0{
                let webView = UIWebView()
                webView.loadRequest(URLRequest(url: URL(string:"tel://"+model.merContactTel)!))
                view.addSubview(webView)
            }
      
        case .appraise(let model):
            
            let viewController = LBCommentListViewController()
            viewController.model = model
            viewController.associationId = orgCode
            navigationController?.pushViewController(viewController, animated: true)
            
        case .distance(let model):
            
            let coordinate = CLLocationCoordinate2DMake(model.lat, model.lng)
            showAlertView(message: "请选择导航方式", actionTitles: ["苹果地图","百度地图","高德地图","取消"], handler: { (action) in
                guard let title = action.title,title != "取消" else{return}
                LBMapNavigationManger.manger.navigationActionWithCoordinate(coordinate:coordinate,type: title)
            })

        case .shopingCell(_):
            
            let viewController = LBStoreGoodsViewController()
            viewController.orgCode = orgCode
            viewController.title = shopName
            navigationController?.pushViewController(viewController, animated: true)
            
        default:
            break
        }
    }
}

// MARK: loadData
extension LBShoppingMallDetailViewController:LBHomeMerchantHttpServer{
 
    func requiredMercInfo(){
        let userId:String = LBKeychain.get(CURRENT_MERC_ID)
        merIntroQuery(orgCode: orgCode, mercId:mercId,userId:userId) { [weak self](model) in
            guard let strongSelf = self else{return}
            strongSelf.mercInfoModel = model
            strongSelf.cellItem = [.images(strongSelf,model.imgList),
                                   .mixCell(model),
                                   .distance(model),
                                   .common("客户介绍",model,"merExplain"),
                                   .common("顾客须知",model,"merNotice")
            ]
        
            strongSelf.rightItem.1.isSelected =  model.favouriteStatus == 1 ?true:false
            strongSelf.loadCommentList()
            strongSelf.setupUI()
        }
    }
    
}

extension LBShoppingMallDetailViewController:LBCommentListPresent{
    
    fileprivate func loadCommentList() {
        requireCommentList(pageNum: 1,
                           pageSize: "10",
                           associationId: orgCode) {[weak self] (model) in
                            guard let strongSelf = self else{return}
                            
                            
                            var i = strongSelf.cellItem.count - 2
                            strongSelf.cellItem.insert(.appraise(model), at: i)
    
                            // 插入最新三条 评价内容
                            i = strongSelf.cellItem.count - 2
                            let maxCount = i + 2
                            model.list.forEach{
                                if i > maxCount {return}
                                strongSelf.cellItem.insert(.comment($0), at: i)
                                i += 1
                            }
                    
                            strongSelf.commentItem = model
                            
                            strongSelf.loadShopsGoodsData()
                            strongSelf.tableView.reloadData()

        }
    }
}

/// 商家评价

//MARK: 查询商品
extension LBShoppingMallDetailViewController{
    

    func loadShopsGoodsData()  {
        
        let parameters = lb_md5Parameter(parameter: ["orgcode":orgCode,
                                                     "goodsStatus":1,
                                                     "pageNum":1,
                                                     "pageSize":"10"])
        LBHttpService.LB_Request(.goods, method: .get, parameters: parameters, success: {[weak self](json) in

            guard let strongSelf = self else{return}
            let model = LBShopsGoodsModel(json: json["detail"])
            guard model.list.count > 0 else{return}
            // zj 增店铺商品
//            strongSelf.cellItem.append(.shopingCell(model))
            strongSelf.tableView.reloadData()
            
        }, failure: { (failItem) in
                Print(failItem)

        }) { (error) in
            Print(error)

        }
    }
    
}
/// 查看评价
// 实现浏览器代理协议
extension LBShoppingMallDetailViewController: PhotoBrowserDelegate {
    
    
    func numberOfPhotos(in photoBrowser: PhotoBrowser) -> Int {
        return photos.count
    }
    
    /// 缩放起始视图
    func photoBrowser(_ photoBrowser: PhotoBrowser, thumbnailViewForIndex index: Int) -> UIView? {
        return thumbnailView
    }
    
    func photoBrowser(_ photoBrowser: PhotoBrowser, thumbnailImageForIndex index: Int) -> UIImage? {
        return thumbnailView?.image
    }
    
    /// 高清图
    func photoBrowser(_ photoBrowser: PhotoBrowser, highQualityUrlForIndex index: Int) -> URL? {
        return URL(string:photos[index])
    }
    
    
    /// 长按图片
    func photoBrowser(_ photoBrowser: PhotoBrowser, didLongPressForIndex index: Int, image: UIImage) {
        longPressAction(photoBrowser,image)
    }
    
    func longPressAction(_ viewController:PhotoBrowser,_ image:UIImage) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle:.actionSheet)
        let shareAction = UIAlertAction(title: "分享", style: .default, handler: { _ in
            UIApplication.shared.keyWindow?.addSubview(self.shareView)
            self.shareView.delegate = self
        })
        
        let saveAction = UIAlertAction(title: "保存图片", style: .default, handler: { (_) in
            BXSaveImageManager.shareSaveImage.saveImage(image)
            
        })
        let cancelAction = UIAlertAction(title: "取消", style: .default, handler: nil)
        
        alertController.addAction(shareAction)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        viewController.present(alertController, animated: true, completion: nil)
        
    }
}

extension LBShoppingMallDetailViewController:BXShareViewDelegate{
	
    func sendWXSecneSession() {
        guard let image = thumbnailView?.image,image.size.height > 0 else { return }
        let suscees = WXManager.shareManager.sendImageContent(image, WXSceneSession)
        if suscees {
            showAlertView("分享成功", "确定", nil)
        }
        UIView.animate(withDuration: 0.5) {
            self.shareView.removeFromSuperview()
        }
    }
    
    func sendWXSecneTimeline() {
        guard let image = thumbnailView?.image,image.size.height > 0 else { return }
        let suscees = WXManager.shareManager.sendImageContent(image, WXSceneTimeline)
        if suscees {
            showAlertView("分享成功", "确定", nil)
        }
        UIView.animate(withDuration: 0.5) { self.shareView.removeFromSuperview()}
    }
    
    
}
extension LBShoppingMallDetailViewController:LBPresentLoginViewControllerProtocol{}


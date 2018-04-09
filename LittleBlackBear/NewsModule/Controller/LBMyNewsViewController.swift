//
//  LBNewsViewController.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/10/26.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBMyNewsViewController: UITableViewController {
    fileprivate let reuseIdentifier = "LBProfileViewController"
    fileprivate let reuseIdentifier1 = "LBProfileViewController1"
    
    var priseButtonSelectTypes:[Int:Bool] = [Int:Bool]()
    
    fileprivate enum cellType {
        case game
        case news(imageListModel)
    }
    
    fileprivate var pageNum = 1
    fileprivate var pages = 1
    // 记录game个数量
    fileprivate var gameCount:Int = 0
    fileprivate var cellItem:[cellType] = []
    fileprivate var imageItems:[IndexPath:imageListModel] = [:]
    fileprivate var thumbnailView:UIImageView?
    fileprivate var photos:[String] = []
    fileprivate let shareView = BXShareView()
    
    //    var imageItems:[(filePath:String,imageView:UIImageView)] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requireNewsData()
//        tableView.reloadData()

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "我的头条"
        tableView.estimatedRowHeight = ScreenH
        let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action:#selector(publishNews))//此处使用的图标UIBarButtonSystemItem是一个枚举.大家可以尝试一下其他值出来是什么
        self.navigationItem.rightBarButtonItem=item
        
        configTableView()
        requireNewsData()
        
        tableView.addPullRefresh {[weak self] in
            
            guard let strongSelf = self else{return}
            
            guard strongSelf.pageNum < strongSelf.pages else{
                strongSelf.tableView.stopPullRefreshEver()
                return
            }
            strongSelf.pageNum  += 1
            strongSelf.requireNewsData()
        }
        
        tableView.addPushRefresh {[weak self] in
            
            guard let strongSelf = self else{return}
            guard strongSelf.pageNum < strongSelf.pages else{
                strongSelf.tableView.stopPushRefreshEver()
                return
            }
            strongSelf.pageNum  += 1
            strongSelf.requireNewsData()
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
                requireNewsData()
//        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configTableView() {
        
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.register(LBNewsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.register(LBShowGameCouponCell.self, forCellReuseIdentifier: reuseIdentifier1)
        if cellItem.isEmpty {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        }
        
    }
    func publishNews(){
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated:false)
        
    }
    
}
// MARK: - Table view data source & delegate
extension LBMyNewsViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return  cellItem.count != 0 ?cellItem.count : 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        switch cellItem [indexPath.section]{
        case .game:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! LBShowGameCouponCell
            cell.selectionStyle = .none
            return cell
            
        case .news(let model):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LBNewsTableViewCell
            cell.selectionStyle = .none
            cell.model = model
            imageItems[indexPath] = model
            /// 点赞
            cell.clickThumbBtnAction = {[weak self](button,cell) in
                guard let strongSelf = self else { return }
                strongSelf.thumbPraiseAction(model,cell,indexPath.section)
            }
            /// showPotoBrowser
            cell.showPotoBrowser = {[weak self](imageView)in
                guard let strongSelf = self else{return}
                strongSelf.showPotoBrowser(model, imageView, indexPath)
                
            }
            cell.praiseButtonIsSelected = priseButtonSelectTypes[indexPath.section]
            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch cellItem[indexPath.section] {
        case .game:
            return 260*AUTOSIZE_Y
        case .news(let model):
            
            var imageH:CGFloat = 0
            if model.imageList.count == 1{
                let imageView = UIImageView()
                imageView.kf.setImage(with: URL(string:model.imageList[0]))
                if let image = imageView.image,image.size.height > 0{
                    imageH = image.onlyOneImageForHeight()
                }
                return imageH + model.textH + 90
            }
            
            return  model.cellHeight
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cellItem[indexPath.section] {
        case .game:
            let view = LBGameBoxView()
            view.shakeAnimationCompletionHandler = {[weak self](boxImgView) in
                guard let strongSelf = self else{return}
                strongSelf.getGameCoupon(success: { (model) in
                    view.removeFromSuperview()
                    let couponView  = LBGameCouponView()
                    couponView.model = model
                    couponView.showShopDeatil = {
                        
                    }
                    couponView.showGameCouponDetail = {
                        let viewController = LBSecondCouponDetailViewController()
                        viewController.markId = model.id
                        viewController.hadCouponAction = true
                        couponView.removeFromSuperview()
                        strongSelf.navigationController?.pushViewController(viewController, animated: true)
                        
                    }
                    UIApplication.shared.keyWindow?.addSubview(couponView)
                }, fail: {
                    boxImgView.isUserInteractionEnabled = false
                    boxImgView.image = UIImage(named:"treasureBox_have_non")
                })
                
            }
            UIApplication.shared.keyWindow?.addSubview(view)
            break
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
}

extension LBMyNewsViewController{
    // MARK: 点赞
    func thumbPraiseAction(_ model:imageListModel,_ cell:LBNewsTableViewCell,_ index:Int) {
        guard LBKeychain.get(TOKEN) != "" else {
            showAlertView(message: "请先登录!",actionTitles: ["取消","确定"],handler: {[weak self] (action) in
                guard let strongSelf = self else{return}
                if action.title == "确定"{
                    strongSelf.presentLoginViewController({}, nil)
                }
            })
            return
        }
        praiseAction(mercId: LBKeychain.get(CURRENT_MERC_ID),
                     id: model.id,
                     index:index)
        cell.praiseButtonIsSelected = true
    }
    // MARK: showPotoBrowser
    func showPotoBrowser(_ model:imageListModel,_ imageView:UIImageView,_ indexPath:IndexPath){
        photos.removeAll()
        let browser = PhotoBrowser(showByViewController: self, delegate: self)
        browser.pageControlDelegate = PhotoBrowserDefaultPageControlDelegate(numberOfPages: model.imageList.count)
        thumbnailView = imageView
        photos = (imageItems[indexPath]?.imageList)!
        browser.show(index: imageView.tag)
    }
}
// MARK:requireNewsData
extension LBMyNewsViewController:LBNewsHttpServer{
    fileprivate func requireNewsData() {
        
        requireNewsList(pageNum: pageNum, pageSize: "10") {[weak self] (model) in
            guard let strongSelf = self else{return}
            
            guard strongSelf.cellItem.count - strongSelf.gameCount < model.total else{return}
            strongSelf.pages = model.pages
            
            model.list.forEach{strongSelf.cellItem.append(.news($0))}
            
            // 建立temp 接收 imageListModle
            var tempCellItem:[imageListModel] = [imageListModel]()
            strongSelf.cellItem.forEach{
                switch $0{
                case .news(let model):
                    tempCellItem.append(model)
                case .game:break
                }
            }
            
            //根据时间来排序
            let list = tempCellItem.sorted(by:{$0.publishTime>$1.publishTime})
            
            //  过滤 game
            guard list.count == tempCellItem.count else {return}
            strongSelf.gameCount  = 0
            strongSelf.cellItem.removeAll()
            strongSelf.imageItems.removeAll()
            
            list.forEach{strongSelf.cellItem.append(.news($0))}
            
            // 每5条mews插游戏卡券
            for i in 1...list.count{
                if i % 5 == 0,i+strongSelf.gameCount<strongSelf.cellItem.count{
                    
                    strongSelf.cellItem.insert(.game, at: i+strongSelf.gameCount)
                    strongSelf.gameCount += 1
                }
                if i % 5 == 0,i+strongSelf.gameCount==strongSelf.cellItem.count{
                    
                    strongSelf.cellItem.append(.game)
                    strongSelf.gameCount += 1
                }
            }
            
            strongSelf.tableView.reloadData()
            
        }
    }
    
}
//MARK: 实现浏览器代理协议
extension LBMyNewsViewController: PhotoBrowserDelegate {
    
    
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
// MARK: 分享
extension LBMyNewsViewController:BXShareViewDelegate{
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
// 登录协议
extension LBMyNewsViewController:LBPresentLoginViewControllerProtocol{
}



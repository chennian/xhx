//
//  LBCommentListViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/28.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBCommentListViewController: UITableViewController {
    
    var model:LBCommentListModel<commentImageListModel>?
    var associationId:String = ""
    fileprivate var cellItem:[commentImageListModel] = [commentImageListModel]()
    fileprivate let reuseIdentifier = "LBCommentListViewController"
    fileprivate var pageNum = 1
    fileprivate var pages = 1

    fileprivate var imgListModel:[String] = [String]()

    fileprivate var imageItems:[IndexPath:imageListModel] = [:]
    fileprivate var thumbnailView:UIImageView?
    fileprivate var photos:[String] = []
    fileprivate let shareView = BXShareView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "点评"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(clickCommentAction))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName:FONT_32PX,
                                                                   NSForegroundColorAttributeName:COLOR_e60013],
                                                                  for: .normal)
        
        configTableView()
        reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configTableView() {
        
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.register(LBShowCommentCell.self, forCellReuseIdentifier: reuseIdentifier)
        
    }
    
    func clickCommentAction() {
        
        guard LBKeychain.get(TOKEN) != "" else {
            
            showAlertView(message: "请先登录",actionTitles: ["取消","确定"],handler: {[weak self] (action ) in
                
                guard let strongSelf = self else {return}
                guard action.title == "确定" else{return}
                
                strongSelf.presentLoginViewController({
                    
                }, nil)
                
            })
            return
        }
        
        let viewController = LBCommentViewController()
        viewController.orgCode = associationId
        viewController.pubishCompetionHandler = {[weak self] in
            guard let strongSelf = self  else {return}
            strongSelf.loadCommentList()
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func reloadData() {
        
        tableView.addPullRefresh {[weak self] in
            guard let strongSelf = self else{return}
        
            guard strongSelf.pageNum < strongSelf.pages else{
                strongSelf.tableView.stopPullRefreshEver()
                return
            }
            
            strongSelf.pageNum += 1
            strongSelf.loadCommentList()
            
        }
        
        tableView.addPushRefresh {[weak self] in
            guard let strongSelf = self else{return}
            
            
            guard strongSelf.pageNum < strongSelf.pages else{
                strongSelf.tableView.stopPushRefreshEver()
                return
            }
            
            strongSelf.pageNum += 1
            strongSelf.loadCommentList()
            
        }
    }
    
}
extension LBCommentListViewController{
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if cellItem.count > 0 {
            return cellItem.count
        }
        return((model != nil) ? (model?.list.count)! : 0)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LBShowCommentCell
        
        cell.selectionStyle = .none
        let item:commentImageListModel = cellItem.count > 0 ?cellItem[indexPath.section]:model!.list[indexPath.section]
        cell.model = item
        
        cell.currentIndexPath = indexPath
        /// showPotoBrowser
        cell.showPotoBrowser = {[weak self](imageView)in
            guard let strongSelf = self else{return}
            strongSelf.photos.removeAll()
            let browser = PhotoBrowser(showByViewController: strongSelf, delegate: strongSelf)
            browser.pageControlDelegate = PhotoBrowserDefaultPageControlDelegate(numberOfPages: (cell.model?.imageList.count)!)
            strongSelf.thumbnailView = imageView
            strongSelf.photos = item.imageList
            browser.show(index: imageView.tag)
            
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if cellItem.count > 0 {
            let model = cellItem[indexPath.section]
            return setCellHeight(model)
        }
        
        return setCellHeight(model!.list[indexPath.section])
    }
    func setCellHeight(_ model:commentImageListModel)->CGFloat{
    
        var imageH:CGFloat = 0
        if model.imageList.count == 1{
            let imageView = UIImageView()
            imageView.kf.setImage(with: URL(string:model.imageList[0]))
            if let image = imageView.image,image.size.height > 0{
                imageH = image.onlyOneImageForHeight()
            }
            return imageH + model.textH + 60+10
        }
        return model.cellHeight 
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
}
extension LBCommentListViewController:LBCommentListPresent{
    
    fileprivate func loadCommentList() {
        
        requireCommentList(pageNum: pageNum,
                           pageSize: "10",
                           associationId: associationId) {[weak self] (model) in
                            guard let strongSelf = self else{return}
                            strongSelf.pages = model.pages
                            model.list.forEach{strongSelf.cellItem.append($0)}
                            strongSelf.tableView.reloadData()
                            strongSelf.tableView.stopPullRefreshEver()
                            strongSelf.tableView.stopPushRefreshEver()

        }
    }
}
// 实现浏览器代理协议
extension LBCommentListViewController: PhotoBrowserDelegate {
    
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

extension LBCommentListViewController:BXShareViewDelegate{
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

extension LBCommentListViewController:LBPresentLoginViewControllerProtocol{
    
}

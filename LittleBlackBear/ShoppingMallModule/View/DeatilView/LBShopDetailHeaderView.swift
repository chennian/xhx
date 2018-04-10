//
//  LBShopDetailHeaderView.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2018/2/3.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBShopDetailHeaderView: UIView {
    
    var imageUrls:[imgListModel] = []{
        didSet{
            guard imageUrls.count > 0 else {return}
            creatImageView(imageUrls)
            let contentW = KSCREEN_WIDTH*CGFloat(imageUrls.count)
            scrollView.contentSize = CGSize(width: contentW , height: 0)
            
            pageView.isHidden = false
            
            pageView.currentPageIndicatorTintColor = UIColor.white
            pageView.pageIndicatorTintColor = COLOR_99aab5
            pageView.currentPage = 0
            
            pageView.numberOfPages = imageUrls.count
        }
    }
    
    var presentVC:UIViewController?{
        didSet{
            guard let vc = presentVC else { return }
            self.presentedPotoVC = vc
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 200)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var presentedPotoVC:UIViewController?
    fileprivate let scrollView = UIScrollView()
    fileprivate let pageView = UIPageControl()
    fileprivate let shareView = BXShareView()
    fileprivate var photos:[String] = []
    fileprivate var thumbnailView:UIImageView?
    private func setupUI(){
        
        addSubview(scrollView)
        addSubview(pageView)
        
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.delegate = self
        pageView.isHidden = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        pageView.translatesAutoresizingMaskIntoConstraints = false
        
        //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|",
        //                                                     options: .alignAllCenterX,
        //                                                     metrics: nil,
        //                                                     views: ["scrollView":scrollView]))
        //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|",
        //                                                     options: .alignAllCenterY,
        //                                                     metrics: nil,
        //                                                     views: ["scrollView":scrollView]))
        scrollView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        
        addConstraint(BXLayoutConstraintMake(pageView, .right, .equal,self,.right,-20))
        addConstraint(BXLayoutConstraintMake(pageView, .bottom,.equal,self,.bottom,-30))
        addConstraint(BXLayoutConstraintMake(pageView, .height, .equal,nil,.height,5))
    }
    
    private func creatImageView(_ imageUrls:[imgListModel])  {
        
        var collectionViews:[UIView] = [UIView]()
        var toItem:UIView = scrollView
        var attr: NSLayoutAttribute = .left
        var index = 0
        photos.removeAll()
        imageUrls.forEach{
            
            guard $0.imgUrl.isURLFormate() else{return}
            
            let imageView = UIImageView()
            
            //                imageView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(imageView)
            
            let left = CGFloat(index) * ScreenW
            imageView.snp.makeConstraints({ (make) in
                make.size.equalToSuperview()
                make.top.equalToSuperview()
                make.left.equalTo(left)
            })
            if let nextItem = collectionViews.last{
                toItem = nextItem
                attr = .right
            }
            //                scrollView.addConstraint(BXLayoutConstraintMake(imageView, .left, .equal,toItem, attr))
            //                scrollView.addConstraint(BXLayoutConstraintMake(imageView, .top,  .equal,scrollView,.top))
            //                scrollView.addConstraint(BXLayoutConstraintMake(imageView, .width,.equal,nil,.width,KSCREEN_WIDTH))
            //                scrollView.addConstraint(BXLayoutConstraintMake(imageView, .height,.equal,nil,.height,200))
            collectionViews.append(imageView)
            
            imageView.kf.setImage(with:  URL(string:$0.imgUrl),
                                  placeholder:nil ,
                                  options: nil,
                                  progressBlock: nil ,
                                  completionHandler: { (image, _, _, _) in
                                    
                                    guard image != nil,image!.size.height > 0 else{return}
                                    //                    let size:CGSize = CGSize(width: KSCREEN_WIDTH, height: 200)
                                    //                                        imageView.image = image!.croppingImage(size)
                                    imageView.contentMode = .scaleAspectFill
            })
            
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                  action:#selector(showImage(_:))))
            
            imageView.tag = index
            photos.append($0.imgUrl)
            thumbnailView = imageView
            
            index += 1
            
        }
    }
    
    func showImage(_ tap:UITapGestureRecognizer)  {
        guard let presentVC = presentedPotoVC,let index = tap.view?.tag else { return  }
        let browser = PhotoBrowser(showByViewController: presentVC, delegate: self)
        browser.pageControlDelegate = PhotoBrowserDefaultPageControlDelegate(numberOfPages:photos.count)
        browser.show(index:index)
    }
    
}
extension LBShopDetailHeaderView:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x+0.5)/Int(KSCREEN_WIDTH)
        pageView.currentPage = index
        
        
    }
    
}
extension LBShopDetailHeaderView: PhotoBrowserDelegate {
    
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

extension LBShopDetailHeaderView:BXShareViewDelegate{
    func sendWXSecneSession() {
        guard let image = thumbnailView?.image,image.size.height > 0 else { return }
        let suscees = WXManager.shareManager.sendImageContent(image, WXSceneSession)
        if suscees {
        }
        UIView.animate(withDuration: 0.5) {
            self.shareView.removeFromSuperview()
        }
    }
    
    func sendWXSecneTimeline() {
        guard let image = thumbnailView?.image,image.size.height > 0 else { return }
        let suscees = WXManager.shareManager.sendImageContent(image, WXSceneTimeline)
        if suscees {
        }
        UIView.animate(withDuration: 0.5) { self.shareView.removeFromSuperview()}
    }
    
    
}

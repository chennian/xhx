//
//  SinglePhotoPreviewViewController.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/16.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import Photos

class SinglePhotoPreviewViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,PhotoPreviewCellDelegate {
    
    var selectImages:[PhotoImageModel]?
    
    private var collectionView: UICollectionView?
    private let cellIdentifier = "cellIdentifier"
    var currentPage: Int = 0
    
    weak var sourceDelegate: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "back", style: .plain, target: self, action: nil)
        
        self.configNavigationBar()
        self.configCollectionView()
    }
    
    private func configNavigationBar(){
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(SinglePhotoPreviewViewController.eventRemoveImage))
    }
    
    /**
     * 删除预览图片操作
     */
    func eventRemoveImage(){
        let element = self.selectImages?.remove(at: self.currentPage)
        self.updatePageTitle()
        self.sourceDelegate?.removeElement(element: element)
        
        if (self.selectImages?.count)! > 0{
            self.collectionView?.reloadData()
        } else {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor.white), for: .default)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black,
                                                                   NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 16*default_scale)]
        
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor.rgb(16, 16, 16)), for: .default)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:COLOR_ffffff,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 16*default_scale)]
        
        self.collectionView?.setContentOffset(CGPoint(x: CGFloat(self.currentPage) * self.view.bounds.width, y: 0), animated: false)
        self.updatePageTitle()
    }
    
    private func updatePageTitle(){
        self.title =  String(self.currentPage+1) + "/" + String(self.selectImages!.count)
    }
    
    func configCollectionView(){
        self.automaticallyAdjustsScrollViewInsets = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width:self.view.frame.width,height: self.view.frame.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView!.isPagingEnabled = true
        self.collectionView!.scrollsToTop = false
        self.collectionView!.showsHorizontalScrollIndicator = false
        self.collectionView!.contentOffset = CGPoint(x:0, y: 0)
        self.collectionView!.contentSize = CGSize(width: self.view.bounds.width * CGFloat(self.selectImages!.count), height: self.view.bounds.height)
        
        self.view.addSubview(self.collectionView!)
        self.collectionView!.register(PhotoPreviewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
    }
    
    // MARK: -  collectionView dataSource delagate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectImages!.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! PhotoPreviewCell
        cell.delegate = self
        if let asset = self.selectImages?[indexPath.row] {
            cell.renderModel(asset: asset.data!)
        }
        
        return cell
    }
    
    // MARK: -  Photo Preview Cell Delegate
    func onImageSingleTap() {
        let status = !UIApplication.shared.isStatusBarHidden
//        UIApplication.shared.setStatusBarHidden(status, with: .slide)
        self.navigationController?.setNavigationBarHidden(status, animated: true)
    }
    
    // MARK: -  scroll page
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        self.currentPage = Int(offset.x / self.view.bounds.width)
        self.updatePageTitle()
    }
    
}


//
//  LBShoppingHeaderView.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/10/26.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
protocol LBShoppingHeaderViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView,_ pageView:UIPageControl, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView,_ pageView:UIPageControl)
}

class LBShoppingHeaderView:UIView{
    
    var delegate:LBShoppingHeaderViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 197*AUTOSIZE_Y)
        setupUI()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let pageControlView = UIPageControl()

    let collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let itemW:CGFloat = (KSCREEN_WIDTH-10*(5+1))/5
        layout.itemSize = CGSize(width:itemW, height: (KSCREEN_WIDTH-10*5)/5)
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
   
        collectionView.register(LBShoppingHeaderCollectionViewCell.self, forCellWithReuseIdentifier: "LBShoppingHeaderCollectionViewCell")
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    
   private func setupUI(){
    
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false


        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|",
                                                     options:NSLayoutFormatOptions.alignAllCenterX,
                                                     metrics: nil,
                                                     views: ["collectionView":collectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-20-|",
                                                     options: NSLayoutFormatOptions.alignAllCenterY,
                                                     metrics: nil,
                                                     views: ["collectionView":collectionView]))
        
        
        
        addSubview(pageControlView)
        pageControlView.translatesAutoresizingMaskIntoConstraints = false
        pageControlView.currentPageIndicatorTintColor = UIColor.white
        pageControlView.pageIndicatorTintColor = COLOR_999999
        pageControlView.currentPageIndicatorTintColor = COLOR_e60013
        pageControlView.currentPage = 0
        
        addConstraint(BXLayoutConstraintMake(pageControlView, .centerX, .equal,self,.centerX))
        addConstraint(BXLayoutConstraintMake(pageControlView, .bottom,.equal,self,.bottom,-10))
        addConstraint(BXLayoutConstraintMake(pageControlView, .height, .equal,nil,.height,5))
        
    }
    
    func reloadData(){
        collectionView.reloadData()
    }
}
extension LBShoppingHeaderView:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (delegate?.numberOfSections(in:collectionView))!
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (delegate?.collectionView(collectionView ,numberOfItemsInSection:section))!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (delegate?.collectionView(collectionView,pageControlView,cellForItemAt:indexPath))!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
}


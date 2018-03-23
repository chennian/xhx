//
//  ZJHomeClassCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class ZJHomeClassCell: SNBaseTableViewCell {
    
    let didSelectPublish = PublishSubject<(String,String,String)>()

    private lazy var goodClassesView : UICollectionView = {
        let layout = LXFChatEmotionCollectionLayout()
//        layout.itemSize = CGSize(width: fit(90), height: fit(127))
//        layout.minimumInteritemSpacing = fit(48)
//
//        layout.minimumLineSpacing = fit(34)
//
//        layout.scrollDirection = .horizontal
//        layout.scrollDirection = .horizontal
        
        let obj = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        obj.contentInset = UIEdgeInsetsMake(fit(40), fit(3), fit(40), fit(3))
        obj.delegate = self
        obj.dataSource = self
//        obj.isScrollEnabled = false
        obj.backgroundColor = .white
        obj.isPagingEnabled = true
        obj.register(BMGoodClassesCollectionCell.self, forCellWithReuseIdentifier: cellIdentify( BMGoodClassesCollectionCell.self))
        return obj
    }()
    // 185 133   52  532
    let pageControl = UIPageControl().then({
        $0.currentPageIndicatorTintColor = Color(0xff0000)
        $0.pageIndicatorTintColor = Color(0xe4e4e4)
            })
    override func setupView() {
        hidLine()
        
        contentView.addSubview(goodClassesView)
        goodClassesView.snp.makeConstraints { (make) in
            make.left.snEqualTo(16)
            make.right.equalToSuperview().snOffset(-16)
            make.top.bottom.equalToSuperview()
            
        }
        contentView.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().snOffset(13)
        }
    }
    
    var models : [LBCatasModel] = []{
        didSet{
            pageControl.numberOfPages = (models.count + 9 ) / 10 
            pageControl.currentPage = 0

        }
    }
    
}
extension ZJHomeClassCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentify( BMGoodClassesCollectionCell.self), for: indexPath) as! BMGoodClassesCollectionCell
        
        /*
         if shoppingModel != nil,shoppingModel!.catas.count > 8 {
         pageView.isHidden = true
         pageView.numberOfPages = ((shoppingModel?.catas.count)!%8)
         
         }else{
         pageView.isHidden = true
         }
         */
        cell.model = models[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        
        didSelectPublish.onNext((model.mercid , model.id,model.subCataName))
//        let type : BMPageJumpType = PageJumpTypeType(fast_way: model.fast_way, jump_id: model.jump_id, site_url: model.site_url,name : model.name)
//        self.didSelectPub.onNext(type)
    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        
        pageControl.currentPage = Int((offsetX  + ScreenW * 0.5 ) / ScreenW)
    }
    
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        let offsetX = scrollView.contentOffset.x
//
//        pageControl.currentPage = Int(offsetX / ScreenW)
//    }
}





class BMGoodClassesCollectionCell: UICollectionViewCell {
    
    var model : LBCatasModel?{
        didSet{
            cellIcon.kf.setImage(with: URL(string : model!.iconMidIos))
//            cellIcon.image = Image(model!.localName)
            cellLab.text = model!.subCataName
            
        }
    }
    
    
    
    let cellIcon = UIImageView().then{
        $0.contentMode = .scaleAspectFit
    }
    let cellLab = UILabel().then{
        $0.textColor = Color(0x404040)
        $0.font = Font(24)
        $0.textAlignment = .center
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension BMGoodClassesCollectionCell {
    func setupView(){
        
        contentView.addSubview(cellLab)
        contentView.addSubview(cellIcon)
        //184 176
        cellIcon.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.snEqualToSuperview()
            make.width.height.snEqualTo(95)
        }
        cellLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(cellIcon.snp.bottom).offset(fit(8))
//            make.bottom.equalToSuperview()//.snOffset(-30)
        }
    }
}








let kEmotionCellNumberOfOneRow = 5
let kEmotionCellRow = 2

class LXFChatEmotionCollectionLayout: UICollectionViewFlowLayout {
    // 保存所有item
    fileprivate var attributesArr: [UICollectionViewLayoutAttributes] = []
    
    // MARK:- 重新布局
    override func prepare() {
        super.prepare()
        
//        let itemWH: CGFloat = ScreenW / CGFloat(kEmotionCellNumberOfOneRow)
        
        // 设置itemSize
        itemSize = CGSize(width: fit(140), height: fit(127))
//        minimumLineSpacing = fit(0)
//        minimumInteritemSpacing = fit(108)
        scrollDirection = .horizontal
//
//        // 设置collectionView属性
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = true
////        let insertMargin = (collectionView!.bounds.height - 3 * itemWH) * 0.5
        collectionView?.contentInset = UIEdgeInsetsMake(fit(43), fit(10), fit(54), fit(0.01))
        
        
        
        var page = 0
        let itemsCount = collectionView?.numberOfItems(inSection: 0) ?? 0
        for itemIndex in 0..<itemsCount {
            let indexPath = IndexPath(item: itemIndex, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            page = itemIndex / (kEmotionCellNumberOfOneRow * kEmotionCellRow)
            // 通过一系列计算, 得到x, y值
            var x : CGFloat = 0.0
            if page == 0 {
                
                x = fit(140) * CGFloat(itemIndex % Int(kEmotionCellNumberOfOneRow)) + (CGFloat(page) * ScreenW)
            }else if page == 1{
                x = fit(140) * CGFloat(itemIndex % Int(kEmotionCellNumberOfOneRow)) + (CGFloat(page) * ScreenW) - fit(23)
            }
            
            let y = fit(127 + 34) * CGFloat((itemIndex - page * kEmotionCellRow * kEmotionCellNumberOfOneRow) / kEmotionCellNumberOfOneRow)
            
            attributes.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
            // 把每一个新的属性保存起来
            attributesArr.append(attributes)
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var rectAttributes: [UICollectionViewLayoutAttributes] = []
        _ = attributesArr.map({
            if rect.contains($0.frame) {
                rectAttributes.append($0)
            }
        })
        return rectAttributes
    }
    

    
    
}

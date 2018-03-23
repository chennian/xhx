//
//  ZJPostHeadTopicViewController.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 19/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift

enum ZJPostHeadTopicMulityImagesCellClickType {
    case addNew(asset : [Any])
    case showBigPhoto(imgs : [Any],index : Int)
}
class ZJPostHeadTopicMulityImagesView: SNBaseView {

    var addNewPicture = PublishSubject<ZJPostHeadTopicMulityImagesCellClickType>()
    var imgArray : [UIImage] = []{
        didSet{
            collection.reloadData()
        }
    }
    
    var imgSelect : [Any] = []
    
    private lazy var collection : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: fit(228), height: fit(228))
        layout.minimumInteritemSpacing = fit(13)
        layout.minimumLineSpacing = fit(13)
        let obj = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        obj.contentInset = UIEdgeInsetsMake(0, fit(20), 0, fit(20))
        obj.backgroundColor = .white
        obj.register(ZJHeadTopicImageCell.self, forCellWithReuseIdentifier: cellIdentify(ZJHeadTopicImageCell.self))
        return obj
    }()
    
    
    
    override func setupView() {
        addSubview(collection)
        collection.dataSource = self
        collection.delegate = self
        collection.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
}

extension ZJPostHeadTopicMulityImagesView : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return min(6, imgArray.count + 1)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell : ZJHeadTopicImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentify(ZJHeadTopicImageCell.self), for: indexPath) as! ZJHeadTopicImageCell
        if indexPath.row == imgArray.count && imgArray.count <= 5{
//            cell.imgV.image = UIImage(named:"image_select")
            cell.imgV.image = nil
        }else{
            
            cell.imgV.image = imgArray[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if imgArray.count <= 5 && indexPath.row == imgArray.count{
            addNewPicture.onNext(ZJPostHeadTopicMulityImagesCellClickType.addNew(asset: self.imgSelect))
            //            cell.imgV.image = UIImage(named:"image_select")
        }else{
            addNewPicture.onNext(.showBigPhoto(imgs: imgSelect, index: indexPath.row))
        }
    }
}


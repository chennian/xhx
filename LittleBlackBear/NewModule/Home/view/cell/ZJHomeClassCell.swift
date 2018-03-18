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
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: fit(90), height: fit(127))
        layout.minimumInteritemSpacing = fit(48)
        
        layout.minimumLineSpacing = fit(34)
        
//        layout.scrollDirection = .horizontal
        
        let obj = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        obj.contentInset = UIEdgeInsetsMake(fit(40), 0, fit(40), 0)
        obj.delegate = self
        obj.dataSource = self
        obj.isScrollEnabled = false
        obj.backgroundColor = .white
        obj.register(BMGoodClassesCollectionCell.self, forCellWithReuseIdentifier: cellIdentify( BMGoodClassesCollectionCell.self))
        return obj
    }()
    // 185 133   52  532
    
    override func setupView() {
        hidLine()
        contentView.addSubview(goodClassesView)
        goodClassesView.snp.makeConstraints { (make) in
            make.left.snEqualTo(43)
            make.right.equalToSuperview().snOffset(-43)
            make.top.bottom.equalToSuperview()
            
        }
    }
    
    var models : [LBCatasModel] = []
    
}
extension ZJHomeClassCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentify( BMGoodClassesCollectionCell.self), for: indexPath) as! BMGoodClassesCollectionCell
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
        $0.font = Font(26)
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
            make.top.equalTo(cellIcon.snp.bottom).offset(fit(16))
//            make.bottom.equalToSuperview()//.snOffset(-30)
        }
    }
}

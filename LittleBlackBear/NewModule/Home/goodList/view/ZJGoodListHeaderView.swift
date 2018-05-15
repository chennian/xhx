//
//  ZJGoodListHeaderView.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit


class ZJGoodListHeaderMenuModel {
    var text : String
    var isSelected : Bool
    init(text : String ,isSelected : Bool) {
        self.text = text
        self.isSelected = isSelected
    }
}

class ZJGoodListHeaderView: SNBaseView {

    
    func setCates(cates : [String]){
        
        
        testM = cates.map { (name) -> ZJGoodListHeaderMenuModel in
            return ZJGoodListHeaderMenuModel(text: name, isSelected: false)
        }
        if cates.count >= 1{
            
            testM[0].isSelected = true
        }
        
        mainView.reloadData()
        
        
        line.snp.remakeConstraints { (make) in
            make.left.snEqualTo(5)
            make.width.snEqualTo(120)
            make.height.snEqualTo(4)
            make.top.snEqualTo(76)
        }
    }
    var testM : [ZJGoodListHeaderMenuModel] = []
    
    private lazy var mainView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        if #available(iOS 10.0, *) {
            layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        } else {
            layout.estimatedItemSize = CGSize(width: fit(60), height: fit(50))
        }
        
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        let obj = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        obj.contentInset = UIEdgeInsetsMake(fit(10), 0, fit(10), 0)
        obj.register(ZJGoodListMenuCell.self, forCellWithReuseIdentifier: cellIdentify(ZJGoodListMenuCell.self))
        obj.backgroundColor = .white
        obj.showsHorizontalScrollIndicator = false
        
        return obj
    }()
    
    let line = UIView().then({
        $0.backgroundColor = .red
        $0.layer.cornerRadius = fit(1)
    })
    
    override func setupView() {
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
        mainView.addSubview(line)
        mainView.delegate = self
        mainView.dataSource = self
        
        
    }

    
    var currentCell : ZJGoodListMenuCell?

}

extension ZJGoodListHeaderView : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{//UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ZJGoodListMenuCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentify(ZJGoodListMenuCell.self), for: indexPath) as! ZJGoodListMenuCell
        cell.titleLab.text = testM[indexPath.row].text
        cell.titleLab.textColor = testM[indexPath.row].isSelected ? .red : Color(0x444444)
        if testM[indexPath.row].isSelected{
            self.currentCell = cell

        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testM.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 0.01, height: fit(69))
    }



    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if testM[indexPath.row].isSelected {return}
        testM.forEach({$0.isSelected = false})
        testM[indexPath.row].isSelected = true
        let cell = collectionView.cellForItem(at: indexPath) as! ZJGoodListMenuCell
        cell.titleLab.textColor = .red
        currentCell!.titleLab.textColor = Color(0x444444)
        currentCell = cell
        
        line.snp.remakeConstraints { (make) in
            make.centerX.equalTo(cell.centerX)
            make.width.snEqualTo(120)//.snOffset(-70)
            make.height.snEqualTo(4)
            make.top.snEqualTo(76)
        }
        self.needsUpdateConstraints()
        // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
        self.updateConstraintsIfNeeded()
        
        self.layoutIfNeeded()
    }
}



class ZJGoodListMenuCell : UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpVIew()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleLab = UILabel().then({
        $0.textColor = Color(0x444444)
        $0.textAlignment = .center
        $0.font = Font(30)
    })
    func setUpVIew(){
        contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
//            make.size.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().snOffset(-70)
            
        }
    }
}

















class HorizontalCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var dataArray: [String] = [] {
        didSet {
            collectionView.reloadData()
            collectionView.collectionViewLayout.invalidateLayout()
            //collectionView.reloadSections(IndexSet(integersIn: 0...0))
        }
    }
    var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func requestViewData() {
        dataArray = ["0", "1", "22", "333", "4444", "55555", "666666", "7777777", "88888888", "999999999", "10101010101010101010", "A", "1111111111111111111111", "12", "13", "14"]
        print("dataArray.count=", dataArray.count)
    }
    
    private func setUp() {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flowLayout.scrollDirection = .horizontal
        
        //===== CELL 约束自适应 必备条件 1 =====
        if #available(iOS 10.0, *) {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        } else {
            flowLayout.estimatedItemSize = CGSize(width: 15, height: fit(60))
        }
        
        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: ScreenW, height: fit(90)), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsetsMake(0, fit(30), 0, fit(30))
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        self.addSubview(collectionView)
        
        collectionView.register(HorizontalLabelCell.classForCoder(), forCellWithReuseIdentifier: "_cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击了 cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("dataArray.count=", dataArray.count)
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "_cell", for: indexPath) as! HorizontalLabelCell
        cell.title = dataArray[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //===== CELL 计算自适应 必备条件 1 =====
        // return CGSize(dataArray[indexPath.row].widthWithFont(), 48)
        
        //===== CELL 约束自适应 必备条件 2 ===== 宽度或者高度一定要  大于 0 ,否则会出现丢失错误等不可预料问题
        return CGSize(width: 0.001, height: fit(60))
    }
}

class HorizontalLabelCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Font(30)
        label.textAlignment = .center
        label.textColor = UIColor.red
        return label
    }()
    
    var title: String = "" {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.titleLabel)
        
        //===== CELL 约束自适应 必备条件 3 =====
        self.titleLabel.snp.makeConstraints { maker in
            maker.left.top.equalTo(self.contentView)
            maker.width.greaterThanOrEqualTo(5)
            maker.height.greaterThanOrEqualTo(fit(90))
            maker.height.equalTo(self.contentView).priorityLow()
            maker.right.equalTo(self.contentView).priorityLow()
        }
    }
    
    //===== CELL 计算自适应 必备条件 2 ===== 如果没有使用约束,则在这里赋值 subViews frame 大小
    /*override func layoutSubviews() {
     super.layoutSubviews()
     self.titleLabel.frame = self.contentView.frame
     }*/
    
}







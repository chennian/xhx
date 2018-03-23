//
//  LBProfileTableViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/5.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
protocol LBProfileTableViewCellDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView,tableViewIndePath:IndexPath, didSelectItemAt indexPath: IndexPath)
}

class LBProfileTableViewCell:UITableViewCell{
    
    var delegate:LBProfileTableViewCellDelegate?
    
    var label_text:String = ""{
        didSet{
            guard label_text.count > 0 else {return}
            label.text = label_text
        }
    }
    var _indexPath:IndexPath?{
        didSet{
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let sectionView = UIView()
    private let label = UILabel()
    private let lineView = UIView()
    
    lazy var collectionView : UICollectionView = {
        // 每一行显示5个
        let layout = UICollectionViewFlowLayout()
        let itemW:CGFloat = (KSCREEN_WIDTH-10*5)/4
        layout.itemSize = CGSize(width:itemW, height: 72.5)
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(LBProfileCollectionCell.self, forCellWithReuseIdentifier: "LBProfileCollectionCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
    }()
    
    private func setupUI ()  {
        contentView.addSubview(sectionView)
        sectionView.addSubview(label )
        sectionView.addSubview(lineView)
        
        sectionView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        sectionView.backgroundColor = UIColor.white
        label.font = FONT_28PX
        label.textColor = COLOR_222222

        lineView.backgroundColor = COLOR_999999
        
        contentView.addConstraint(BXLayoutConstraintMake(sectionView, .left, .equal,contentView,.left,20))
        contentView.addConstraint(BXLayoutConstraintMake(sectionView, .top, .equal,contentView,.top))
        contentView.addConstraint(BXLayoutConstraintMake(sectionView, .height, .equal,nil,.height,50*AUTOSIZE_Y))
        contentView.addConstraint(BXLayoutConstraintMake(sectionView, .right, .equal,contentView,.right,-20))
        
        
        sectionView.addConstraint(BXLayoutConstraintMake(label, .centerY, .equal,sectionView,.centerY))
        sectionView.addConstraint(BXLayoutConstraintMake(label, .left, .equal,sectionView,.left))
        
  
        
        sectionView.addConstraint(BXLayoutConstraintMake(lineView, .left, .equal,sectionView,.left))
        sectionView.addConstraint(BXLayoutConstraintMake(lineView, .bottom,.equal,sectionView,.bottom))
        sectionView.addConstraint(BXLayoutConstraintMake(lineView, .height,.equal,nil,.height,0.5))
        sectionView.addConstraint(BXLayoutConstraintMake(lineView,.right, .equal,sectionView,.right))
        
        
        contentView.addSubview(collectionView)
        contentView.addConstraint(BXLayoutConstraintMake(collectionView, .left, .equal ,contentView,.left,10))
        contentView.addConstraint(BXLayoutConstraintMake(collectionView, .top, .equal,sectionView,.bottom,20))
        contentView.addConstraint(BXLayoutConstraintMake(collectionView, .bottom, .equal,contentView,.bottom))
        contentView.addConstraint(BXLayoutConstraintMake(collectionView, .right, .equal,contentView,.right,-10))
        
    }
    
    
    
}

extension LBProfileTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (delegate?.numberOfSections(in:collectionView))!
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (delegate?.collectionView(collectionView ,numberOfItemsInSection:section))!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (delegate?.collectionView(collectionView,cellForItemAt:indexPath))!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        delegate?.collectionView(collectionView, tableViewIndePath: _indexPath!, didSelectItemAt: indexPath)
    }
    
}

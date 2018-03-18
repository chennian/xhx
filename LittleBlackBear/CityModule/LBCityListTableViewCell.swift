//
//  LBCityListTableViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/1.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
protocol LBCityListTableViewCellDegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}
class LBCityListTableViewCell: UITableViewCell {
    
    enum initType {
        case location_now// 当前位置
        case hotCity // 热门城市
        case historyCity // 历史收缩
        case `default` // A...Z
    }
    
    var cellType:initType = .`default`{
        didSet{
            switch cellType {
            case .location_now:
                _initLocationCell()
            case .historyCity,.hotCity:
                _initCollectionView()
            case .default:
                _initDeafault()
            }
        }
    }
    var delegate:LBCityListTableViewCellDegate?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    let titleLabel = UILabel()

    
    func _initLocationCell (){
        
        contentView.subviews.forEach{$0.removeFromSuperview()}
        
        let imgview = UIImageView(image: UIImage(named:"locationMark"))
        let label = UILabel()
        contentView.addSubview(imgview)
        contentView.addSubview(label)
        imgview.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "当前位置: " + LBKeychain.get(LOCATION_CITY_KEY)
        label.font = FONT_30PX
        label.textColor = COLOR_222222
        label.textAlignment = .left
        
        contentView.addConstraint(BXLayoutConstraintMake(imgview, .left, .equal,contentView,.left,20))
        contentView.addConstraint(BXLayoutConstraintMake(imgview, .centerY,.equal,contentView,.centerY))
        contentView.addConstraint(BXLayoutConstraintMake(imgview, .width, .equal,nil,.width,15*AUTOSIZE_X))
        contentView.addConstraint(BXLayoutConstraintMake(imgview, .height,.equal,nil,.height,16*AUTOSIZE_Y))
        
        contentView.addConstraint(BXLayoutConstraintMake(label, .left, .equal,imgview,.right,10))
        contentView.addConstraint(BXLayoutConstraintMake(label, .centerY, .equal,contentView,.centerY))
        
    }
    
    func _initCollectionView() {
        contentView.subviews.forEach{$0.removeFromSuperview()}
        let layout = UICollectionViewFlowLayout()
        // margin = 10  tableViewIndex = 50
        layout.itemSize = CGSize(width: (KSCREEN_WIDTH-10*6-50)/3, height: 30)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(LBCityCollectionViewCell.self, forCellWithReuseIdentifier: "LBCityCollectionViewCell")
        collectionView.delegate   = self
        collectionView.dataSource = self
		collectionView.backgroundColor = COLOR_e6e6e6
        contentView.subviews.filter{$0 .isKind(of: UICollectionView.self)}.forEach{$0.removeFromSuperview()}
		contentView.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["collectionView":collectionView]))
		contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["collectionView":collectionView]))
        
    }
    func _initDeafault() {
        contentView.subviews.forEach{$0.removeFromSuperview()}
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["titleLabel":titleLabel]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["titleLabel":titleLabel]))
        
    }
}

extension LBCityListTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (delegate?.numberOfSections(in:collectionView))!
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (delegate?.collectionView( collectionView,numberOfItemsInSection:section))!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (delegate?.collectionView(collectionView,cellForItemAt:indexPath))!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        return (delegate?.collectionView(collectionView,didSelectItemAt:indexPath))!
    }
    
}





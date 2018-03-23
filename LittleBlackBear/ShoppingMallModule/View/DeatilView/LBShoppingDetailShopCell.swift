//
//  LBShoppingDetailShopCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/16.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBShoppingDetailShopCell: UITableViewCell {
    
    
    var model:LBShopsGoodsModel?{
        didSet{
            
            guard model != nil, model!.list.count > 0 else{return}
            
            var collectionViews:[UIView] = [UIView]()
            var toItem:UIView = scrollView
            var attr: NSLayoutAttribute = .left
            model!.list.forEach{
                
                let view = LBShoppingDetailCollectionView()
                scrollView.addSubview(view)
                view.translatesAutoresizingMaskIntoConstraints = false
                
                view.imgUrl = $0.mainImg.imgUrl
                view.title_text = $0.commoName
                view.subTitle_text = "￥" + $0.commoPrice + "元"
                
                if let nextItem = collectionViews.last{
                    toItem = nextItem
                    attr = .right
                }
                
                
                scrollView.addConstraint(BXLayoutConstraintMake(view, .left, .equal,toItem, attr,16.5))
                scrollView.addConstraint(BXLayoutConstraintMake(view, .top, .equal,scrollView,.top))
                scrollView.addConstraint(BXLayoutConstraintMake(view, .width, .equal,nil,.width,100))
                scrollView.addConstraint(BXLayoutConstraintMake(view, .height, .equal,nil,.height,75))
                collectionViews.append(view)
                
            }
            
            let count:CGFloat = CGFloat(model!.list.count)
            scrollView.contentSize = CGSize(width: (100+16.5)*count, height: 0)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let sectionView = UIView()
    private let shopNameLabel = UILabel()
    
    private let accessoryButton:UIButton={
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = FONT_30PX
        button.setTitleColor(COLOR_222222, for: .normal)
        button.setImage(UIImage(named:"blackrightAccessoryIcon"), for: .normal)
        button.setTitle("查看更多", for: .normal)
        button.isUserInteractionEnabled = false 
        guard let imgW = button.imageView?.image?.size.width,
            let lbW  = button.titleLabel?.text?.getSize(15).width
            else{return button}
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -imgW, 0, imgW)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, lbW, 0, -lbW-20)
        return button
    }()
    
    private let scrollView = UIScrollView()
    
    func setupUI() {
        
        contentView.addSubview(sectionView)
        sectionView.addSubview(shopNameLabel)
        sectionView.addSubview(accessoryButton)
        contentView.addSubview(scrollView)
        
        sectionView.translatesAutoresizingMaskIntoConstraints = false
        shopNameLabel.translatesAutoresizingMaskIntoConstraints = false
        accessoryButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.alwaysBounceHorizontal = true
        
        shopNameLabel.text = "店铺商品"
        
        contentView.addConstraint(BXLayoutConstraintMake(sectionView, .left, .equal,contentView,.left))
        contentView.addConstraint(BXLayoutConstraintMake(sectionView, .top, .equal,contentView,.top))
        contentView.addConstraint(BXLayoutConstraintMake(sectionView, .right,.equal,contentView,.right))
        contentView.addConstraint(BXLayoutConstraintMake(sectionView, .height, .equal,nil,.height,30))
        
        contentView.addConstraint(BXLayoutConstraintMake(shopNameLabel, .left, .equal,sectionView,.left,15))
        contentView.addConstraint(BXLayoutConstraintMake(shopNameLabel, .bottom,.equal,sectionView,.bottom))
        
        contentView.addConstraint(BXLayoutConstraintMake(accessoryButton,.right,.equal,sectionView,.right,-20))
        contentView.addConstraint(BXLayoutConstraintMake(accessoryButton,.bottom,.equal,sectionView,.bottom))
        
        contentView.addConstraint(BXLayoutConstraintMake(scrollView, .top, .equal,sectionView,.bottom,17))
        contentView.addConstraint(BXLayoutConstraintMake(scrollView, .left, .equal,contentView,.left))
        contentView.addConstraint(BXLayoutConstraintMake(scrollView, .right, .equal,contentView,.right))
        contentView.addConstraint(BXLayoutConstraintMake(scrollView, .bottom, .equal,contentView,.bottom))
        
    }
    
    
}

class LBShoppingDetailCollectionView: UIView {
    
    var imgUrl:String = ""{
        didSet{
            guard imgUrl.isURLFormate() else {return}
            imgView.kf.setImage(with: URL(string:imgUrl))
        }
    }
    
    var imgName:String = ""{
        didSet{
            guard imgName.count > 0 else {return}
            imgView.image = UIImage(named:imgName)
        }
    }
    
    var title_text:String = ""{
        didSet{
            guard title_text.count > 0 else{return}
            titleLabel.text = title_text
        }
    }
    
    var subTitle_text:String = ""{
        didSet{
            guard subTitle_text.count > 0 else{return}
            subTitleLabel.text = subTitle_text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imgView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    
    func setupUI(){
        
        addSubview(imgView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = FONT_28PX
        titleLabel.textColor = COLOR_222222
        
        subTitleLabel.font = FONT_26PX
        subTitleLabel.textColor = COLOR_9C9C9C
        
        addConstraint(BXLayoutConstraintMake(imgView, .centerX, .equal,self,.centerX))
        addConstraint(BXLayoutConstraintMake(imgView, .top, .equal,self,.top))
        addConstraint(BXLayoutConstraintMake(imgView, .width, .equal,nil,.width,100))
        addConstraint(BXLayoutConstraintMake(imgView, .height, .equal,nil,.height,75))
        addConstraint(BXLayoutConstraintMake(titleLabel,.left, .equal,imgView,.left))
        addConstraint(BXLayoutConstraintMake(titleLabel,.top, .equal,imgView,.bottom,12))
        
        addConstraint(BXLayoutConstraintMake(subTitleLabel,.left, .equal,titleLabel,.left))
        addConstraint(BXLayoutConstraintMake(subTitleLabel,.top, .equal,titleLabel,.bottom,10))
    }
    
}


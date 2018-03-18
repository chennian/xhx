//
//  LBShowGoodsView.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/25.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBShowGoodsView: UIView {
    
    
    var contentList:[LBShopsGoodsModelList] = []{
        didSet{
            guard contentList.count > 0 else {return}
            creatContentViewSubViews(contentList)
            for i in 0..<contentList.count {
                if i == 0{
                    creatImageViews(contentList)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT)
        self.backgroundColor = UIColor.rgb(0, 0, 0, alpha: 0.75)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ contentList:[String],imgList:[String]) {
        self.init()
    }
    
    private let contentScrollView = UIScrollView()
    private let closeButton = UIButton()
    
    
    private func setupUI() {
        
        addSubview(contentScrollView)
        addSubview(closeButton)
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.backgroundColor = COLOR_ffffff
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(named:"x"), for: .normal)
        closeButton.addTarget(self, action: #selector(clickCloseButton(_ :)), for: .touchUpInside)
        
        addConstraint(BXLayoutConstraintMake(contentScrollView,.centerX, .equal,self,.centerX))
        addConstraint(BXLayoutConstraintMake(contentScrollView, .centerY, .equal,self,.centerY))
        addConstraint(BXLayoutConstraintMake(contentScrollView, .width, .equal,nil,.width,320*AUTOSIZE_X))
        addConstraint(BXLayoutConstraintMake(contentScrollView, .height, .equal,nil,.height,435*AUTOSIZE_Y))
 
        addConstraint(BXLayoutConstraintMake(closeButton, .centerX, .equal,contentScrollView,.right))
        addConstraint(BXLayoutConstraintMake(closeButton, .centerY, .equal,contentScrollView,.top))
        
        
    }
    
    private func creatContentViewSubViews(_ models:[LBShopsGoodsModelList]){
        
        var collectionViews:[UIView] = [UIView]()
        var toItem:UIView = contentScrollView
        var attr: NSLayoutAttribute = .left
        models.forEach{
            
            guard $0.mainImg.imgUrl.isURLFormate() else{return}
            
            let view =  initContentView($0)
            view.backgroundColor = COLOR_ffffff
            contentScrollView.addSubview(view)
            
            if let nextItem = collectionViews.last{
                toItem = nextItem
                attr = .right
            }
            
            contentScrollView.addConstraint(BXLayoutConstraintMake(view, .left, .equal,toItem, attr))
            contentScrollView.addConstraint(BXLayoutConstraintMake(view, .top,  .equal,contentScrollView,.top,180*AUTOSIZE_Y))
            contentScrollView.addConstraint(BXLayoutConstraintMake(view, .width,.equal,contentScrollView,.width))
            contentScrollView.addConstraint(BXLayoutConstraintMake(view, .bottom,.equal,contentScrollView,.bottom))
            
            collectionViews.append(view)
       
        }

    }
    
    private func initContentView(_ model:LBShopsGoodsModelList)->UIView{
        
        let contentView = UIView()
        
        let markLabel = UILabel()
        let titleLabel = UILabel()
        let subTitleLabel = UILabel()
        let priceLabel = UILabel()
        let line  = UIView()
        let detailTitle = UILabel()
        let descriptionLabel = UILabel()
        
        markLabel.font = FONT_30PX
        markLabel.textColor = UIColor.white
        markLabel.backgroundColor = COLOR_e60013
        
        titleLabel.text = model.commoName
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = COLOR_222222
        
        subTitleLabel.font = FONT_28PX
        subTitleLabel.textColor = COLOR_999999
        
        priceLabel.text = "￥"+model.commoPrice
        priceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        priceLabel.textColor = COLOR_e60013
        
        line.backgroundColor = COLOR_e6e6e6
        
        detailTitle.font = FONT_30PX
        detailTitle.textColor = COLOR_222222
        
        descriptionLabel.font = FONT_26PX
        descriptionLabel.textColor = COLOR_e6e6e6
        
        contentView.addSubview(markLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(line)
        contentView.addSubview(detailTitle)
        contentView.addSubview(descriptionLabel)
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        markLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false
        detailTitle.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
      
        contentView.addConstraint(BXLayoutConstraintMake(markLabel, .left,.equal,contentView,.left,20))
        contentView.addConstraint(BXLayoutConstraintMake(markLabel, .top, .equal,contentView,.bottom,180*AUTOSIZE_Y))
        contentView.addConstraint(BXLayoutConstraintMake(markLabel, .height, .equal,nil,.height,23))
        
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .left, .equal,markLabel,.right,10))
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .centerY, .equal,markLabel,.centerY))
        
        contentView.addConstraint(BXLayoutConstraintMake(subTitleLabel, .left, .equal,markLabel,.left))
        contentView.addConstraint(BXLayoutConstraintMake(subTitleLabel, .top, .equal,markLabel,.bottom,10))
        
        contentView.addConstraint(BXLayoutConstraintMake(priceLabel, .left, .equal,markLabel,.left))
        contentView.addConstraint(BXLayoutConstraintMake(priceLabel, .top, .equal,markLabel,.bottom,10))
        
        contentView.addConstraint(BXLayoutConstraintMake(line, .top, .equal,priceLabel,.bottom,20))
        contentView.addConstraint(BXLayoutConstraintMake(line, .height, .equal,nil,.height,0.5))
        contentView.addConstraint(BXLayoutConstraintMake(line, .left, .equal,contentView,.left,16))
        contentView.addConstraint(BXLayoutConstraintMake(line, .right, .equal,contentView,.right,-16))
        
        contentView.addConstraint(BXLayoutConstraintMake(detailTitle,.centerX, .equal,contentView,.centerX))
        contentView.addConstraint(BXLayoutConstraintMake(detailTitle, .top, .equal,line,.bottom,15))
        
        contentView.addConstraint(BXLayoutConstraintMake(descriptionLabel, .left,.equal,line,.left))
        contentView.addConstraint(BXLayoutConstraintMake(descriptionLabel, .right, .equal,line,.right))
        contentView.addConstraint(BXLayoutConstraintMake(descriptionLabel, .top, .equal,detailTitle,.bottom,15))
        
        return contentView
    }
    
    
    
    private func creatImageViews(_ imageUrls:[LBShopsGoodsModelList])  {
        
        let imgScrollView = UIScrollView()
        contentScrollView.addSubview(imgScrollView)
        imgScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        contentScrollView.addConstraint(BXLayoutConstraintMake(imgScrollView, .left,.equal,contentScrollView,.left))
        contentScrollView.addConstraint(BXLayoutConstraintMake(imgScrollView, .top, .equal,contentScrollView,.top))
        contentScrollView.addConstraint(BXLayoutConstraintMake(imgScrollView, .right,.equal,contentScrollView, .right))
        contentScrollView.addConstraint(BXLayoutConstraintMake(imgScrollView, .height,.equal,nil,.height,180*AUTOSIZE_Y))
        
        var collectionViews:[UIView] = [UIView]()
        var toItem:UIView = imgScrollView
        var attr: NSLayoutAttribute = .left
        var index = 0
        imageUrls.forEach{
            
            guard $0.mainImg.imgUrl.isURLFormate() else{return}
            
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imgScrollView.addSubview(imageView)
            
            if let nextItem = collectionViews.last{
                toItem = nextItem
                attr = .right
            }
            imgScrollView.addConstraint(BXLayoutConstraintMake(imageView, .left, .equal,toItem, attr))
            imgScrollView.addConstraint(BXLayoutConstraintMake(imageView, .top,  .equal,imgScrollView,.top))
            imgScrollView.addConstraint(BXLayoutConstraintMake(imageView, .width,.equal,imgScrollView,.width))
            imgScrollView.addConstraint(BXLayoutConstraintMake(imageView, .height,.equal,imgScrollView,.height))
            
            collectionViews.append(imageView)
            
            imageView.kf.setImage(with:  URL(string:$0.mainImg.imgUrl),
                                  placeholder:nil ,
                                  options: nil,
                                  progressBlock: nil ,
                                  completionHandler: { (image, _, _, _) in
                                    
                                    guard image != nil,image!.size.height > 0 else{return}
                                    let size:CGSize = CGSize(width: 320*AUTOSIZE_X, height: 180*AUTOSIZE_Y)
                                    imageView.image = image!.croppingImage(size)
            })
            
            
            imageView.tag = index
            
            index += 1
            
        }
    }
    
    func clickCloseButton(_ button:UIButton)  {
        self.removeFromSuperview()
    }
}














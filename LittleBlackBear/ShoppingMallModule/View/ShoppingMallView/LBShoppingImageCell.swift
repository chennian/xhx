//
//  LBShoppingImageCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/11.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
import SDCycleScrollView
class LBShoppingImageCell: UITableViewCell {
    
    var cellType: shoppingCellTye = .image([""]){
        didSet{
            switch cellType {
            case let .image(urls):
                guard urls.count > 0 else {return}
                let view = SDCycleScrollView()
                view.imageURLStringsGroup = urls
                view.translatesAutoresizingMaskIntoConstraints = false
                contentView.subviews.forEach{$0.removeFromSuperview()}
                contentView.addSubview(view)
                contentView.backgroundColor = COLOR_efefef
                contentView.addConstraint(BXLayoutConstraintMake(view, .left, .equal,contentView,.left))
                contentView.addConstraint(BXLayoutConstraintMake(view, .top, .equal,contentView,.top,10))
                contentView.addConstraint(BXLayoutConstraintMake(view, .right, .equal,contentView,.right))
                contentView.addConstraint(BXLayoutConstraintMake(view, .bottom, .equal,contentView,.bottom))
            default:
                break
            }
        }
    }
    var imageName:String = ""{
        didSet{
            guard imageName.count > 0 else {return}
            _imageView.image = UIImage(named:imageName)
        }
    }
    var imgUrl: String = "" {
        didSet{
            guard imgUrl.count > 0,imgUrl.isURLFormate() == true else {return}
            setupUI()
            _imageView.kf.setImage(with: URL(string:imgUrl))
        }
    }
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
    
    
    private let _imageView  = UIImageView()
    func setupUI() {
        _imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(_imageView)
        contentView.addConstraint(BXLayoutConstraintMake(_imageView, .left, .equal,contentView,.left))
        contentView.addConstraint(BXLayoutConstraintMake(_imageView, .top, .equal,contentView,.top))
        contentView.addConstraint(BXLayoutConstraintMake(_imageView, .right, .equal,contentView,.right))
        contentView.addConstraint(BXLayoutConstraintMake(_imageView, .bottom, .equal,contentView,.bottom))
        
    }
    
}

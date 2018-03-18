//
//  LBShoppingTableViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/28.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBShoppingTableViewCell: UITableViewCell {
    
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
	
    private var levelIconImgViews:[String] = [String]()
    private var classesLabels:[String] = ["焖锅","朋友聚餐"]
    private var classesLabelColors:[UIColor] = [COLOR_2dd0cf,COLOR_f67877]
	var model:LBMerInfosModel?{
        didSet{
            guard model != nil else {return}
            titleLabel.text = model?.merShortName ?? ""
            distanceLabel.text = model?.locationLabel
            configMerLevel(model!)
            configMerchantClass(model!)
            setupUI()
        }
    }
    
    private let imgView = UIImageView()
    private let titleLabel = UILabel()
    private let distanceLabel = UILabel()
    
   private func setupUI(){
        
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(distanceLabel)
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imgView.backgroundColor = UIColor.arc4randomColor()
        
        titleLabel.font = FONT_32PX
        titleLabel.textColor = COLOR_222222
        titleLabel.text = "test"
        
        distanceLabel.textColor = COLOR_999999
        distanceLabel.font = FONT_24PX
        distanceLabel.backgroundColor = COLOR_f3f3f3
        distanceLabel.layer.cornerRadius  = 3
        distanceLabel.layer.masksToBounds = true
        setupConstraints()
    }
   private func setupConstraints() {
        
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .left, .equal,contentView,.left,10))
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .centerY, .equal,contentView,.centerY))
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .width,  .equal,nil,.width,110*AUTOSIZE_X))
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .height, .equal,nil,.height,95*AUTOSIZE_Y))
        
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .left, .equal,imgView,.right,10))
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .top,  .equal,imgView,.top,3))
        
        // levelIconImgView
        ({
            var imgeviews = [UIImageView]()
            for imgName in levelIconImgViews {
                let levelIconImgView = UIImageView()
                levelIconImgView.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(levelIconImgView)
                
                var levelIconImgViewToItem = imgView
                if let toItem = imgeviews.last{
                    levelIconImgViewToItem = toItem
                }
                levelIconImgView.image = UIImage(named:imgName)
                imgeviews.append(levelIconImgView)
                contentView.addConstraint(BXLayoutConstraintMake(levelIconImgView, .left, .equal,levelIconImgViewToItem,.right,10))
                contentView.addConstraint(BXLayoutConstraintMake(levelIconImgView, .top,  .equal,titleLabel,.bottom,10))
                
            }
            }())
        
        // classesLabel
        ({
            
            var labels = [UILabel]()
            for i in 0..<classesLabels.count {
                let classesLabel = UILabel()
                classesLabel.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(classesLabel)
                classesLabel.font = FONT_24PX
                
                var labelToItem:UIView = imgView
                if let toItem = labels.last{
                    labelToItem = toItem
                }
                classesLabel.backgroundColor = classesLabelColors[i]
                classesLabel.text = classesLabels[i]
                labels.append(classesLabel)
                contentView.addConstraint(BXLayoutConstraintMake(classesLabel, .left, .equal,labelToItem,.right,10))
                contentView.addConstraint(BXLayoutConstraintMake(classesLabel, .bottom,  .equal,imgView,.bottom))
            }
            }())
    }
   private func configMerchantClass(_ model:LBMerInfosModel){
        guard model.labelName.count > 0 else {return}
        classesLabels = model.labelName.components(separatedBy: ",")
    }
   private func configMerLevel(_ model:LBMerInfosModel) {
        guard model.merLevel.count > 0 else {return}
        switch model.merLevel {
        case "1":
            levelIconImgViews.removeAll()
            levelIconImgViews = ["start"]
        case "2":
            levelIconImgViews.removeAll()
            levelIconImgViews = ["start","start"]
        case "3":
            levelIconImgViews.removeAll()
            levelIconImgViews = ["start","start","start"]
        case "4":
            levelIconImgViews.removeAll()
            levelIconImgViews = ["start","start","start","start"]
        case "5":
            levelIconImgViews.removeAll()
            levelIconImgViews = ["diamond"]
        case "6":
            levelIconImgViews.removeAll()
            levelIconImgViews = ["diamond","diamond"]
        case "7":
            levelIconImgViews.removeAll()
            levelIconImgViews = ["diamond","diamond","diamond"]
        case "8":
            levelIconImgViews.removeAll()
            levelIconImgViews = ["royalCrown"]
        case "9":
            levelIconImgViews.removeAll()
            levelIconImgViews = ["royalCrown","royalCrown"]
        case "10":
            levelIconImgViews.removeAll()
            levelIconImgViews = ["royalCrown","royalCrown","royalCrown"]
        case "11":
            levelIconImgViews.removeAll()
            levelIconImgViews = ["topLevel"]
        default:
            break
        }
    }
}

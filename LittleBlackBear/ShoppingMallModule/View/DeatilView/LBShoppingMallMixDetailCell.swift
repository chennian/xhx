//
//  LBShoppingMixMallDetailCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/13.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBShoppingMallMixDetailCell: UITableViewCell {

    var cellType: merChantInfoCellTye?{
        didSet{
            switch cellType {
            case let .mixCell(model)?:
                if model.headImgUrl.isURLFormate(){
                    imgView.kf.setImage(with: URL(string: model.headImgUrl))

                }else{
                    imgView.image = UIImage(named:"mearchantIcon")

                }
                titleLabel.text = model.merShopName
                configMerLevel(model)
                configMerchantClass(model)
                setupUI()
            default:
                break
            }
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
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var levelIconImgViews:[String] = [String]()
    var classesLabels:[String] = ["焖锅","朋友聚餐"]
    var classesLabelColors:[UIColor] = [COLOR_2dd0cf,COLOR_f67877,COLOR_fe9f0c]
    var model:LBHomeMerchantModel?{
        didSet{
            guard model != nil else {return}
            titleLabel.text = model?.subCataName ?? ""
            configMerLevel(model!)
            configMerchantClass(model!)
            setupUI()
        }
    }

    
    private let imgView = UIImageView()
    private let titleLabel = UILabel()
    private let connectBtn = UIButton()
    
    func setupUI(){
        
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(connectBtn)
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imageView?.contentMode = .scaleAspectFill
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        connectBtn.translatesAutoresizingMaskIntoConstraints = false
        
        imgView.backgroundColor = UIColor.arc4randomColor()
        
        imgView.layer.cornerRadius = 30
        imgView.layer.masksToBounds = true
        
        titleLabel.font = FONT_30PX
        titleLabel.textColor = COLOR_222222
        
        connectBtn.setImage(UIImage(named:"call_red_icon"), for: .normal)
        connectBtn.setTitle("联系商家", for: .normal)
        connectBtn.setTitleColor(COLOR_999999, for: .normal)
        connectBtn.titleLabel?.font = FONT_28PX
        connectBtn.isUserInteractionEnabled = false
        
       
        guard let imgW = connectBtn.imageView?.image?.size.width,
              let lbW  = connectBtn.titleLabel?.text?.getSize(15).width
            else {return}
        connectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imgW-10, 0, imgW)
        connectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, lbW, 0, -lbW)

        setupConstraints()
        
    }
    
    func setupConstraints() {
        
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .left, .equal,contentView,.left,10))
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .centerY, .equal,contentView,.centerY))
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .width,  .equal,nil,.width,60))
        contentView.addConstraint(BXLayoutConstraintMake(imgView, .height, .equal,nil,.height,60))
        
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .left, .equal,imgView,.right,10))
        contentView.addConstraint(BXLayoutConstraintMake(titleLabel, .top,  .equal,imgView,.top,3))
        
        // levelIconImgView
        ({
            var imgeviews = [UIImageView]()
            for imgName in levelIconImgViews {
                let levelIconImgView = UIImageView()
                levelIconImgView.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(levelIconImgView)
                
                var levelIconImgViewToItem = contentView
                if let toItem = imgeviews.last{
                    levelIconImgViewToItem = toItem
                }
                levelIconImgView.image = UIImage(named:imgName)
                imgeviews.append(levelIconImgView)
            contentView.addConstraint(BXLayoutConstraintMake(levelIconImgView, .right, .equal,levelIconImgViewToItem,.right,-25))
                contentView.addConstraint(BXLayoutConstraintMake(levelIconImgView, .top,  .equal,titleLabel,.top))
                
            }
            }())
        // classesLabel
        ({
            
            var labels = [UILabel]()
            for i in 0..<classesLabels.count {
                let classesLabel = UILabel()
                classesLabel.textColor = UIColor.white
                classesLabel.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(classesLabel)
                classesLabel.font = FONT_24PX
                
                var labelToItem:UIView = imgView
                if let toItem = labels.last{
                    labelToItem = toItem
                }
                classesLabel.backgroundColor = i<classesLabelColors.count ?classesLabelColors[i]:classesLabelColors.last
                classesLabel.text = " " + classesLabels[i] + " "
                labels.append(classesLabel)
                contentView.addConstraint(BXLayoutConstraintMake(classesLabel, .left, .equal,labelToItem,.right,10))
                contentView.addConstraint(BXLayoutConstraintMake(classesLabel, .bottom,  .equal,imgView,.bottom))
                contentView.addConstraint(BXLayoutConstraintMake(classesLabel, .height,  .equal,nil ,.height,21))
                
            }
            }())
        contentView.addConstraint(BXLayoutConstraintMake(connectBtn, .right, .equal,contentView,.right,-10))
        contentView.addConstraint(BXLayoutConstraintMake(connectBtn, .bottom, .equal,imgView,.bottom))
    
    }
    func configMerchantClass(_ model:LBHomeMerchantModel){
        guard model.labelName.count > 0 else {return}
        let pionts = [" ",",","，",";","；","|","/","-",":","."]
        pionts.forEach{
            if model.labelName.contains($0) {
                classesLabels = model.labelName.components(separatedBy: $0).filter{$0.count>0}
            }
        }
    }
    func configMerLevel(_ model:LBHomeMerchantModel) {
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


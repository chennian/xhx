//
//  LBShowCommentCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/27.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBShowCommentCell: UITableViewCell {
    
    var showPotoBrowser:((UIImageView)->())?
    var textConstraintH:NSLayoutConstraint?
    var model:commentImageListModel?{
        didSet{
            guard model != nil else { return}
            if (model?.mercImg.isURLFormate())!,let iconUrl =  model?.mercImg{
                avatarView.kf.setImage(with: URL(string:iconUrl))
            }else{
                avatarView.image = #imageLiteral(resourceName: "userIcon")
            }
        
            if let nameText = model?.mercName,nameText != "null"{
                nameLabel.text = " " + nameText  + "  "
            }else{
                nameLabel.text = "匿名用户"
            }
            if let contentText = model?.description,contentText != "null",contentText.count > 0{
                contentLabel.text = contentText
                textConstraintH?.constant = (model?.cellHeight)!
            }
            if let timeText = model?.publishTime {
                timeLabel.text = timeText
            }
            if let startCount = model?.grade {
                startView.startCount = Int(startCount + 0.5)
                
            }
            photoContentView.imagePaths = model!.imageList
            setupUI()
        }
    }

    
    // topView
    private let topView = UIView()
    private let avatarView = UIImageView()
    private let nameLabel = UILabel()
    private let timeLabel = UILabel()
    private let startView  = LBStartLevelView()

    // centerView
    private let contentLabel = UILabel()
    
    private let collectionContentView = UIView()
    
    let photoContentView = LBPhotoNineSpaceContentView()

    
    var contentLabelConstraint:NSLayoutConstraint?
    
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
    
    func setupUI(){
        
        contentView.addSubview(topView)
        topView.addSubview(avatarView)
        topView.addSubview(nameLabel)
        topView.addSubview(timeLabel)
        topView.addSubview(startView)

        contentView.addSubview(contentLabel)
        contentView.addSubview(photoContentView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        startView.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
         photoContentView.translatesAutoresizingMaskIntoConstraints = false

        avatarView.layer.cornerRadius = 20
        avatarView.layer.masksToBounds = true
        
        nameLabel.font = FONT_28PX
        nameLabel.textColor = COLOR_222222
        
        timeLabel.font = FONT_28PX
        timeLabel.textColor = COLOR_222222

        startView.spacing = 6
        startView.isUserInteractionEnabled = false

        // topView
        ({
            addConstraint(BXLayoutConstraintMake(topView, .left, .equal,contentView,.left))
            addConstraint(BXLayoutConstraintMake(topView, .top,  .equal,contentView,.top))
            addConstraint(BXLayoutConstraintMake(topView, .right, .equal,contentView,.right))
            addConstraint(BXLayoutConstraintMake(topView, .height,.equal,nil,.height,60))
            
            topView.addConstraint(BXLayoutConstraintMake(avatarView, .centerY, .equal,topView,.centerY))
            topView.addConstraint(BXLayoutConstraintMake(avatarView, .left, .equal,topView,.left,14))
            topView.addConstraint(BXLayoutConstraintMake(avatarView, .width, .equal,nil, .width,40))
            topView.addConstraint(BXLayoutConstraintMake(avatarView, .height, .equal,nil,.height,40))
            
            topView.addConstraint(BXLayoutConstraintMake(nameLabel, .top, .equal,avatarView,.top))
            topView.addConstraint(BXLayoutConstraintMake(nameLabel, .left, .equal,avatarView,.right,10))

            topView.addConstraint(BXLayoutConstraintMake(timeLabel, .right, .equal,topView,.right,-10))
            topView.addConstraint(BXLayoutConstraintMake(timeLabel, .top, .equal,avatarView,.top))
            
            addConstraint(BXLayoutConstraintMake(startView, .left, .equal,avatarView,.right,8))
            addConstraint(BXLayoutConstraintMake(startView, .top, .equal,nameLabel,.bottom))
            addConstraint(BXLayoutConstraintMake(startView, .width, .equal,nil,.width,120*AUTOSIZE_X))
            addConstraint(BXLayoutConstraintMake(startView, .height, .equal,nil,.height,30))
            
            }())
        
        contentLabel.font = FONT_26PX
        contentLabel.textColor = COLOR_999999
        contentLabel.numberOfLines = 0
 
        // description
        ({
            let text_ConstraintH = BXLayoutConstraintMake(contentLabel, .height, .equal,nil,.height,model!.textH)
            textConstraintH=text_ConstraintH
            contentView.addConstraint(BXLayoutConstraintMake(contentLabel, .left, .equal,contentView,.left,14))
            contentView.addConstraint(BXLayoutConstraintMake(contentLabel, .top , .equal,topView,.bottom))
            contentView.addConstraint(BXLayoutConstraintMake(contentLabel, .right,.equal,contentView,.right,-14))
            contentLabel.addConstraint(text_ConstraintH)
            
            }())
        // photoContentView
        photoContentView.showPotoBrowser = {[weak self]in
            guard let strongSelf = self else { return  }
            guard let action = strongSelf.showPotoBrowser else {return}
            action($0)
        }
        
        ({
            
            contentView.addConstraint(BXLayoutConstraintMake(photoContentView, .top, .equal, contentLabel, .bottom,5))
            contentView.addConstraint(BXLayoutConstraintMake(photoContentView, .left, .equal,contentView,.left,10))
            contentView.addConstraint(BXLayoutConstraintMake(photoContentView, .right, .equal,contentView,.right,-10))
            contentView.addConstraint(BXLayoutConstraintMake(photoContentView, .bottom, .equal,contentView,.bottom))
            
            }())

    }
    
}



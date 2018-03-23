//
//  LBNewsTableViewCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/5.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBNewsTableViewCell: UITableViewCell {
    
	/// 弹图片浏览器
	var showPotoBrowser:((UIImageView)->())?
	/// 点赞
	var clickThumbBtnAction:((UIButton,LBNewsTableViewCell)->())?

    var model:imageListModel?{
        didSet{
            guard model != nil else { return}
			// 发布图片
			photoContentView.imagePaths = model!.imageList
			// 用户Icon
            if (model?.mercImg.isURLFormate())!,let iconUrl =  model?.mercImg{
                avatarView.kf.setImage(with: URL(string:iconUrl))
            }else{
                avatarView.image = #imageLiteral(resourceName: "userIcon")
            }
			// 用户等级
            if let levelText = model?.identityDesc {
                levelLabel.text = " " + levelText  + " "
            }
			// 用户昵称
            if let nameText = model?.mercName,nameText != "null"{
                nameLabel.text = "  " + nameText  + "  "
            }else{
                nameLabel.text = "匿名用户"
            }
			// 内容
            if let contentText = model?.description,contentText != "null",contentText.count > 0{
                contentLabel.text = contentText
				textConstraintH?.constant = (model?.cellHeight)!
            }
			// 发布时间
            if let timeText = model?.publishTime {
				
				let dateFormartter = DateFormatter()
				dateFormartter.dateFormat = "yyyy-MM-dd HH:mm:ss"
				guard let date:Date = dateFormartter.date(from: timeText) else{
					timeLabel.text = timeText
					return
				}
				timeLabel.text = Date.timeAgoSinceDate(date, numericDates: true)
            }
			
			// 点赞
            if let thumbNum = model?.realPraise ,thumbNum != 0 {
                thumbBtn.setTitle("\(thumbNum)", for: .normal)
            }
			
            setupUI()
			
        }
    }
	/// 点赞 button的select状态
    var praiseButtonIsSelected:Bool?{
        didSet{
            guard praiseButtonIsSelected != nil else {return}
            thumbBtn.isSelected = praiseButtonIsSelected!
            if praiseButtonIsSelected == true,let thumbNum = model?.realPraise{
                thumbBtn.setTitle("\(thumbNum+1)", for: .normal)
            }
        }
    }
	
	private var textConstraintH:NSLayoutConstraint?
    
    // topView
    private let topView = UIView()
    private let avatarView = UIImageView()
    private let nameLabel = UILabel()
    private let levelLabel = UILabel()
    private let accessoryIcon = UIImageView()
    
    // centerView
    private let contentLabel = UILabel()
	private let photoContentView = LBPhotoNineSpaceContentView()

    // bottomView
    private let bottomView = UIView()
    private let timeLabel = UILabel()
    private let thumbBtn = UIButton()

	
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
        levelLabel.isHidden = true
        thumbBtn.addTarget(self, action: #selector(praiseAction(_ :)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        contentView.addSubview(topView)
        topView.addSubview(avatarView)
        topView.addSubview(nameLabel)
        topView.addSubview(levelLabel)
        
        contentView.addSubview(contentLabel)
        contentView.addSubview(photoContentView)
        
        contentView.addSubview(bottomView)
        bottomView.addSubview(timeLabel)
        bottomView.addSubview(thumbBtn)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        accessoryIcon.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        thumbBtn.translatesAutoresizingMaskIntoConstraints = false
        photoContentView.translatesAutoresizingMaskIntoConstraints = false
        
        avatarView.layer.cornerRadius = 15
        avatarView.layer.masksToBounds = true
        
        nameLabel.font = FONT_28PX
        nameLabel.textColor = COLOR_222222
        
        timeLabel.font = FONT_28PX
        timeLabel.textColor = COLOR_222222

        levelLabel.font = FONT_28PX
        levelLabel.textColor = UIColor.white
        levelLabel.backgroundColor = COLOR_e60013
        levelLabel.textAlignment = .center
        levelLabel.layer.cornerRadius = 10
        levelLabel.layer.masksToBounds = true
        
        // topView
        ({
            addConstraint(BXLayoutConstraintMake(topView, .left, .equal,contentView,.left))
            addConstraint(BXLayoutConstraintMake(topView, .top,  .equal,contentView,.top))
            addConstraint(BXLayoutConstraintMake(topView, .right, .equal,contentView,.right))
            addConstraint(BXLayoutConstraintMake(topView, .height,.equal,nil,.height,60))
            
            topView.addConstraint(BXLayoutConstraintMake(avatarView, .centerY, .equal,topView,.centerY))
            topView.addConstraint(BXLayoutConstraintMake(avatarView, .left, .equal,topView,.left,14))
            topView.addConstraint(BXLayoutConstraintMake(avatarView, .width, .equal,nil, .width,30))
            topView.addConstraint(BXLayoutConstraintMake(avatarView, .height, .equal,nil,.height,30))
            
            topView.addConstraint(BXLayoutConstraintMake(nameLabel, .centerY, .equal,topView,.centerY))
            topView.addConstraint(BXLayoutConstraintMake(nameLabel, .left, .equal,avatarView,.right,10))
            
            topView.addConstraint(BXLayoutConstraintMake(levelLabel, .left, .equal,nameLabel,.right,10))
            topView.addConstraint(BXLayoutConstraintMake(levelLabel, .centerY, .equal,nameLabel,.centerY))
            topView.addConstraint(BXLayoutConstraintMake(levelLabel, .height,.equal,nil,.height,20))
            
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
			contentView.addConstraint(BXLayoutConstraintMake(photoContentView, .top, .equal, contentLabel, .bottom))
            contentView.addConstraint(BXLayoutConstraintMake(photoContentView, .left, .equal,contentView,.left,10))
            contentView.addConstraint(BXLayoutConstraintMake(photoContentView, .right, .equal,contentView,.right,-10))
			contentView.addConstraint(BXLayoutConstraintMake(photoContentView, .bottom, .equal,bottomView,.top))

			}())
        
        thumbBtn.setImage(UIImage(named: "thumbImgNormal"), for: .normal)
        thumbBtn.setImage(UIImage(named: "thumbImgSelect"), for: .selected)
        thumbBtn.setTitleColor(COLOR_999999, for: .normal)
        thumbBtn.titleLabel?.font = FONT_28PX
        thumbBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0)
        // bottomVeiw
        ({
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomView]|",
																	  options: NSLayoutFormatOptions(rawValue: 0),
																	  metrics: nil,
																	  views: ["bottomView":bottomView]))
            contentView.addConstraint(BXLayoutConstraintMake(bottomView, .bottom, .equal,contentView,.bottom))
            contentView.addConstraint(BXLayoutConstraintMake(bottomView, .height, .equal,nil,.height,30))
            
            bottomView.addConstraint(BXLayoutConstraintMake(timeLabel, .left, .equal,bottomView,.left,14))
            bottomView.addConstraint(BXLayoutConstraintMake(timeLabel, .centerY,.equal,bottomView,.centerY))
            
            bottomView.addConstraint(BXLayoutConstraintMake(thumbBtn, .centerY,.equal,bottomView,.centerY))
            bottomView.addConstraint(BXLayoutConstraintMake(thumbBtn, .right, .equal,bottomView,.right,-25))
			
            }())
    }
	
    func praiseAction(_ button:UIButton) {
        button.isSelected = !button.isSelected
        guard let action = clickThumbBtnAction else{return}
        action(button,self)
    }
    
}

















//
//  DDZUploadBtn.swift
//  fdIos
//
//  Created by MichaelChan on 28/12/2017.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import RxSwift
class DDZUploadBtn : UIButton,AliOssTransferProtocol{
    var covderView : UIView = UIView().then{
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        $0.isHidden = true
        $0.isUserInteractionEnabled = false
    }
    
    var obkVar: Variable<String> = Variable("")
    
    var resPublish = PublishSubject<Bool>()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    //    let resultImg = UIImageView()
    
    var Oring_image : UIImage?
    //    override func setImage(_ image: UIImage?, for state: UIControlState) {
    //        super.setImage(image, for: state)
    //        self.Oring_image = image
    //
    //    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        layer.cornerRadius = fit( 4)
        clipsToBounds = true
        
        imageView?.contentMode = .center
        sizeToFit()
        addSubview(covderView)
        //        bringSubview(toFront: covderView)
        covderView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
    }
    
    /// 当前图片，方便动态监听图片的变化
    var currentImg : Variable<UIImage?> = Variable(nil)
    
    /// 一组view 的标识
    var index : Int = 0
    /// 全名称 用于本地图片缓存 路径命名
    var fuName : String = "bank"
    
    /// 本地存放路径
    var imgUrl : URL?
    
    /// oss路径
    //    var objecKey : String = ""
    
    /// oss endPoint
    var endPoint : String{
        get{
            return PrivateEndPoint
        }
    }
    
    /// oss bucket
    var bucketName : String{
        get{
            return RealNameAuthBucketName
        }
    }
    
    /// 选择新建时 自动删除 oss 文件  自动：true
    var autoDeleteOssObj : Bool = true
    
    /// 选择图片后 动画展示的view
    var presentView : UIView{
        return self
    }
}

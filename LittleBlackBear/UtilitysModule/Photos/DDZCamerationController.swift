//
//  DDZCamerationController.swift
//  DianDianZanMerchant
//
//  Created by zhijian chen on 2017/6/13.
//  Copyright © 2017年 zhijian chen. All rights reserved.
//

import UIKit
import TOCropViewController


/// alert  图片选择方式控制器
class DDZCamerationController: UIAlertController {
    
    
    class func alertVC(imgPiacker : UIImagePickerController = DDZImagePickerVC(),delegate : UIImagePickerControllerDelegate & UINavigationControllerDelegate & SNBaseViewModel) -> DDZCamerationController{
        
        
        let alertView = DDZCamerationController()
        let picker = DDZImagePickerVC()
        picker.delegate = delegate
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let action = UIAlertAction(title: "拍照", style: .default, handler: { (action) in
                picker.sourceType = .camera

                delegate.jumpSubject.onNext(.present(vc:picker,anmi : true))
            })
            alertView.addAction(action)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let action = UIAlertAction(title: "图库", style: .default, handler: { (action) in
                picker.sourceType = .savedPhotosAlbum
                delegate.jumpSubject.onNext(.present(vc:picker,anmi : true))

                
            })
            alertView.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertView.addAction(cancelAction)
        
        
        
       return alertView
    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setUp()
//    }
//
//    private func setUp(){
//
////        let
//
//    }
    

}

/// 手机相册控制器
class DDZImagePickerVC : UIImagePickerController{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get{
            return .lightContent
//            return .default
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.setBackgroundImage(createImageBy(color: color_main), for: .any, barMetrics: UIBarMetrics.default)
//        navigationController?.navigationBar.barStyle = .black
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : Font(40)]
        
        navigationBar.barStyle = .black
        
        navigationBar.barTintColor = color_main//.white
        navigationBar.tintColor = UIColor.white
        //        vc.navigationBar
//        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : Font(40)]
        navigationBar.setBackgroundImage(createImageBy(color: color_main), for: .any, barMetrics: .default)
    }
    
}



/// 图片剪切控制器
class DDZCorpImagePickerVC : TOCropViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        toolbar.clampButtonHidden = true
        toolbar.resetButton.isHidden = true
        toolbar.doneTextButton.setTitle("确定", for: .normal)
        toolbar.cancelTextButton.setTitle("取消", for: .normal)
        rotateButtonsHidden = true
        cropView.cropBoxResizeEnabled = false
        
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
        
    }
}

//
//  LBPayQRCodeViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/9.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift

class LBPayQRCodeViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    fileprivate let imageView  = UIImageView()
    private var imageConstraintH:NSLayoutConstraint?
    fileprivate let shareView = BXShareView()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "收款码"
        view.backgroundColor = UIColor.white
        LBLoadingView.loading.show(true)
        loadImageData(completion:{[weak self](url) in
            guard let `self` = self else{return}
            self.imageView.kf.setImage(with: URL(string: url), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, type, url) in
                guard error == nil,image?.size.height != 0 else{
                    return
                }
                let constant  = KSCREEN_WIDTH * image!.size.height / image!.size.width
                self.imageConstraintH?.constant = constant < KSCREEN_HEIGHT ?KSCREEN_HEIGHT-44:constant
                self.scrollView.contentSize = CGSize(width:0,height: self.imageConstraintH?.constant ?? 0 + 10)
                self.imageView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(LBPayQRCodeViewController.longPressAction)))
            })
            LBLoadingView.loading.dissmiss()
        })
        
        setupUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"more_red")?.withRenderingMode(.alwaysOriginal),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(longPressAction))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        shareView.removeFromSuperview()
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:COLOR_ffffff,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 16*default_scale)]

    }
    
    private func setupUI(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|",
                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["scrollView":scrollView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|",
                                                           options: NSLayoutFormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["scrollView":scrollView]))
        ({
            let imageConstranit_h = BXLayoutConstraintMake(imageView, .height, .equal,nil,.height,0)
            imageConstraintH = imageConstranit_h
            imageView.addConstraint(imageConstranit_h)
            scrollView.addConstraint(BXLayoutConstraintMake(imageView, .centerX, .equal,scrollView,.centerX))
            scrollView.addConstraint(BXLayoutConstraintMake(imageView, .centerY, .equal,scrollView,.centerY))
            scrollView.addConstraint(BXLayoutConstraintMake(imageView, .width, .equal,nil,.width,KSCREEN_WIDTH))
            
            }())
        
    }
    
    func loadImageData(completion:@escaping ((String)->()))  {
        
        let mercId = LBKeychain.get(CURRENT_MERC_ID)
        
        let parameters:[String:Any] = lb_md5Parameter(parameter: ["mercId":mercId])
        LBHttpService.LB_Request(.payQRCode, method: .get, parameters: parameters, success: { (json) in
            let url = json["detail"].stringValue
            completion(url)
        }, failure: {[weak self] (failItem) in
            guard let `self` = self else{return}
            self.showAlertView(failItem.message, "确定", nil)
        }) {[weak self](error) in
            guard let `self` = self else{return}
            self.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)
        }
        
//        SNRequestString(requestType: API.checkMerchantExit(mer_id: mercId)).subscribe(onNext: { (result) in
//            switch  result{
//            case .bool(let msg):
//                //
//                break
//            case .fail(_ ,let  msg):
//                SZHUD(msg ?? "查询商家失败", type: .error, callBack: nil)
//            default:
//                break
//            }
//        }).disposed(by: disposBag)
    }
    let disposBag = DisposeBag()
    func longPressAction() {
        guard let image = imageView.image,image.size.height > 0 else { return }
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle:.actionSheet)
        let shareAction = UIAlertAction(title: "分享", style: .default, handler: { _ in
            UIApplication.shared.keyWindow?.addSubview(self.shareView)
            self.shareView.delegate = self
        })
        
        let saveAction = UIAlertAction(title: "保存图片", style: .default, handler: { (_) in
            BXSaveImageManager.shareSaveImage.saveImage(image)
            
        })
        let cancelAction = UIAlertAction(title: "取消", style: .default, handler: nil)
        
        alertController.addAction(shareAction)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
}
extension LBPayQRCodeViewController:BXShareViewDelegate{
    func sendWXSecneSession() {
        guard let image = imageView.image,image.size.height > 0 else { return }
        let suscees = WXManager.shareManager.sendImageContent(image, WXSceneSession)
        if suscees {
//            showAlertView("分享成功", "确定", nil)
        }
        UIView.animate(withDuration: 0.5) {
            self.shareView.removeFromSuperview()
        }
    }
    
    func sendWXSecneTimeline() {
        guard let image = imageView.image,image.size.height > 0 else { return }
        let suscees = WXManager.shareManager.sendImageContent(image, WXSceneTimeline)
        if suscees {
//            showAlertView("分享成功", "确定", nil)
        }
        UIView.animate(withDuration: 0.5) { self.shareView.removeFromSuperview()}
    }
    
    
}





//
//  LBAddGroupController.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/17.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import TOCropViewController

class LBAddGroupController: UIViewController {
    fileprivate var fieldCell:LBAddGroupFieldCell = LBAddGroupFieldCell()
    fileprivate var descCell:LBAddSeckillDescriptionCell = LBAddSeckillDescriptionCell()
    
    var protocolObject : AliOssTransferProtocol?
    var fullName : String = ""
    
    fileprivate var name:String = ""
    fileprivate var price:String = ""
    fileprivate var enterNum:String = ""
    fileprivate var mainImg:String = ""
    fileprivate var detailImg:String = ""
    fileprivate var mercId:String = LBKeychain.get(CURRENT_MERC_ID)
    fileprivate var goodDescription:String = ""
    
    fileprivate var detailImg1:String = ""
    fileprivate var detailImg2:String = ""
    fileprivate var detailImg3:String = ""

    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(LBAddGroupFieldCell.self)
        $0.register(LBAddGroupActivityCell.self)
        $0.register(LBAddSeckillDetailImgCell.self)
        $0.register(LBAddSeckillDescriptionCell.self)
        $0.register(LBSubmitButtonCell.self)
        
        $0.register(ZJSpaceCell.self)
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        self.title = "新建团团"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        loadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showMessage(title: String, message: String) {
        UIAlertView(title: title,
                    message:message,
                    delegate: nil,
                    cancelButtonTitle: nil,
                    otherButtonTitles: "确定").show()
    }
    
    @objc fileprivate func uploadData(){
        
        self.name = fieldCell.titleTextField.text!
        self.price = fieldCell.priceTextField.text!
        self.enterNum = fieldCell.numTextField.text!
        self.goodDescription = descCell.descriptionText.text!
        detailImg = "\(detailImg1)|\(detailImg2)|\(detailImg3)"
        print(detailImg)
        
        guard !name.isEmpty else {
            showMessage(title: "提示", message: "请输入标题")
            return
        }
        
        guard !price.isEmpty else {
            showMessage(title: "提示", message: "请输入价格")
            return
        }
        
         guard !enterNum.isEmpty else {
            showMessage(title: "提示", message: "请输入参团人数")
            return
        }
        
        guard !mainImg.isEmpty else {
            showMessage(title: "提示", message: "请上传展示图片")
            return
        }
        guard !detailImg.isEmpty else {
            showMessage(title: "提示", message: "请上传详情展示图")
            return
        }
        guard !goodDescription.isEmpty else {
            showMessage(title: "提示", message: "请输入卡卷描述")
            return
        }
        
        print(detailImg)
        
        
        let paramert:[String:String] = ["name":name,
                                        "price":price,
                                        "enterNum":enterNum,
                                        "mainImg":mainImg,
                                        "detailImg":detailImg,
                                        "description":goodDescription,
                                        "mercId":mercId]
        
        SZHUD("正在上传中...", type: .loading, callBack: nil)
        let time: TimeInterval = 1.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            //code
            LBHttpService.LB_Request2(.newUpdateGroup, method: .post, parameters:lb_md5Parameter(parameter: paramert), headers: nil, success: {[weak self] (json) in
                SZHUD("上传成功", type: .info, callBack: nil)
                }, failure: { (failItem) in
                SZHUD("上传失败", type: .error, callBack: nil)
            }) { (error) in
                SZHUD("请求错误", type: .error, callBack: nil)
            }
        }
    }
}



extension LBAddGroupController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //case

        if indexPath.row == 0{
            let cell : LBAddGroupFieldCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.fieldCell = cell
            return cell
            
        }else if indexPath.row == 1{
            let cell : ZJSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        }else if indexPath.row == 2{
            let cell : LBAddGroupActivityCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.imgTap2.subscribe(onNext: {[unowned self] (btn,fullname) in
                self.fullName = fullname
                self.protocolObject = btn
                let alertView = DDZCamerationController()
                let picker = DDZImagePickerVC()
                picker.delegate = self
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    let action = UIAlertAction(title: "拍照", style: .default, handler: { (action) in
                        picker.sourceType = .camera
                        self.present(picker, animated: true, completion: nil)
                    })
                    alertView.addAction(action)
                }
                
                if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                    let action = UIAlertAction(title: "图库", style: .default, handler: { (action) in
                        picker.sourceType = .savedPhotosAlbum
                        self.present(picker, animated: true, completion: nil)
                        
                    })
                    alertView.addAction(action)
                }
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                alertView.addAction(cancelAction)
                
                self.present(alertView, animated: true, completion: nil)
            }).disposed(by: cell.disposeBag)
            return cell
            
        }else if indexPath.row == 3{
            let cell : ZJSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        }else if indexPath.row == 4{
            let cell : LBAddSeckillDetailImgCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.imgTap.subscribe(onNext: {[unowned self] (btn,fullname) in
                
                self.fullName = fullname
                self.protocolObject = btn
                let alertView = DDZCamerationController()
                let picker = DDZImagePickerVC()
                picker.delegate = self
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    let action = UIAlertAction(title: "拍照", style: .default, handler: { (action) in
                        picker.sourceType = .camera
                        
                        //                        delegate.jumpSubject.onNext(.present(vc:picker,anmi : true))
                        self.present(picker, animated: true, completion: nil)
                    })
                    alertView.addAction(action)
                }
                
                if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                    let action = UIAlertAction(title: "图库", style: .default, handler: { (action) in
                        picker.sourceType = .savedPhotosAlbum
                        //                        delegate.jumpSubject.onNext(.present(vc:picker,anmi : true))
                        self.present(picker, animated: true, completion: nil)
                        
                    })
                    alertView.addAction(action)
                }
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                alertView.addAction(cancelAction)
                
                self.present(alertView, animated: true, completion: nil)
            }).disposed(by: cell.disposeBag)
            return cell
            
        }else if indexPath.row == 5{
            let cell : ZJSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        }else if indexPath.row == 6{
            let cell :LBAddSeckillDescriptionCell  = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.descCell = cell
            return cell
        }else if indexPath.row == 7{
            let cell : ZJSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }else {
            let cell : LBSubmitButtonCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.submitBoutton.setTitle("确定", for: UIControlState.normal)
            cell.contentView.backgroundColor = color_bg_gray_f5
            
            cell.submitBoutton.addTarget(self, action: #selector(uploadData), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //case
        
        if indexPath.row == 0{
            return fit(275)
        }else if indexPath.row == 1{
            return fit(16)
            
        }else if indexPath.row == 2{
            return fit(300)
            
        }else if indexPath.row == 3{
            return fit(16)
            
        }else if indexPath.row == 4{
            return fit(305)
            
        }else if indexPath.row == 5{
            return fit(16)
            
        }else if indexPath.row == 6{
            return fit(305)
            
        }else if indexPath.row == 7{
            return fit(16)
        }else{
            return fit(120)
        }
    }
}

extension LBAddGroupController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
//        protocolObject?.currentImg.value = img
        let cropVC = TOCropViewController(croppingStyle: .default, image: img)
        if self.fullName == "img1" || self.fullName == "img2" || self.fullName == "img3"  {
            cropVC.customAspectRatio = CGSize(width:1,height:1)

        }else{
            cropVC.customAspectRatio = CGSize(width:487,height:158)
        }
        
        
        cropVC.delegate = self
        picker.dismiss(animated: true) {
            self.present(cropVC, animated: true, completion: nil)
        }
    }
}

extension LBAddGroupController : TOCropViewControllerDelegate{
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        unowned let weakself = self
        
        cropViewController.dismiss(animated: false) {
            weakself.protocolObject?.setPalceImg(img: image, fineshed: { (res) in
                if res{//上传oss成功
                    guard let obk = self.protocolObject?.obkVar.value else{
                        return
                    }
                    if self.fullName == "img1" {
                        self.detailImg1 = frontUrl + obk
                    }else if self.fullName == "img2"{
                        self.detailImg2 = frontUrl + obk
                    }else if self.fullName == "img3"{
                        self.detailImg3 = frontUrl + obk
                    }else{
                        self.mainImg = frontUrl + obk
                    }
                }
            })
            
        }
        
    }
}






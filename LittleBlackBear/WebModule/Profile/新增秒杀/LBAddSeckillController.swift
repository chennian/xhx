//
//  LBAddStickController.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/17.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import TOCropViewController
class LBAddSeckillController: UIViewController {
    
    fileprivate var fieldCell:LBAddSeckillFieldCell = LBAddSeckillFieldCell()
    fileprivate var descCell:LBAddSeckillDescriptionCell = LBAddSeckillDescriptionCell()

    fileprivate var name:String = ""
    fileprivate var price:String = ""
    fileprivate var endTime:String = ""
    fileprivate var cardNum:String = ""
    fileprivate var mainImg:String = ""
    fileprivate var detailImg:String = ""
    fileprivate var mercId:String = LBKeychain.get(CURRENT_MERC_ID)
    fileprivate var desc:String = ""
    
    fileprivate var detailImg1:String = ""
    fileprivate var detailImg2:String = ""
    fileprivate var detailImg3:String = ""
    
    fileprivate lazy var datePicker:UIDatePicker = UIDatePicker()
    
    fileprivate lazy var seckillDescriptionCell = LBAddSeckillDescriptionCell()

    var protocolObject : AliOssTransferProtocol?
    var fullName : String = ""
    typealias PickedImageHandle = (UIImage) -> ()
    fileprivate var imagePickerFinishHandle: PickedImageHandle?
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(LBAddSeckillFieldCell.self)
        $0.register(LBAddSeckillActivityCell.self)
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
    
    func setUpPikerView(){
        datePicker.frame = CGRect(x:0, y:0, width:KSCREEN_WIDTH, height:216)
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale(identifier: "zh_CN")
        //注意：action里面的方法名后面需要加个冒号“：”
        datePicker.addTarget(self, action: #selector(dateChanged),
                             for: .valueChanged)
//        self.view.addSubview(datePicker)
        tableView.addSubview(datePicker)
        datePicker.locale = Locale(identifier: "zh_CN")
        datePicker.datePickerMode = .date
        datePicker.setValue(UIColor.white, forKey: "textColor")
//        datePicker.backgroundColor = UIColor.red
    }
    
    //日期选择器响应方法
    func dateChanged(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月dd日"
        print(formatter.string(from: datePicker.date))
    }
    
    func setupUI() {
//        setUpPikerView()

        self.title = "新建秒秒"
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
    
    func showMessage(title: String, message: String) {
            UIAlertView(title: title,
                        message:message,
                        delegate: nil,
                        cancelButtonTitle: nil,
                        otherButtonTitles: "确定").show()
    }
    //上传数据
    @objc fileprivate func uploadData(){
        self.name = fieldCell.titleTextField.text!
        self.price = fieldCell.priceTextField.text!
        self.cardNum = fieldCell.numTextField.text!
        self.endTime = fieldCell.countTextField.text!
        self.desc = descCell.descriptionText.text!
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
        print(endTime)

        guard !endTime.isEmpty else {
            showMessage(title: "提示", message: "请输入倒计时")
            return
        }
        print(cardNum)
        guard !cardNum.isEmpty else {
            showMessage(title: "提示", message: "请输入商品数量")
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
        guard !desc.isEmpty else {
            showMessage(title: "提示", message: "请输入卡卷描述")
            return
        }
        
        print(detailImg)
        
        let paramert:[String:String] = ["name":name,
                                        "price":price,
                                        "endTime":endTime,
                                        "cardNum":cardNum,
                                        "mainImg":mainImg,
                                        "detailImg":detailImg,
                                        "desc":desc,
                                        "mercId":LBKeychain.get(CURRENT_MERC_ID)]
        
        SZHUD("正在上传中...", type: .loading, callBack: nil)
        let time: TimeInterval = 1.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            LBHttpService.LB_Request2(.newUpdateSeckill, method: .post, parameters: lb_md5Parameter(parameter: paramert), headers: nil, success: {[weak self] (json) in
                SZHUD("上传成功", type: .info, callBack: nil)

                }, failure: { (failItem) in
                    SZHUD("上传失败", type: .error, callBack: nil)
            }) { (error) in
                SZHUD("请求错误", type: .error, callBack: nil)
            }
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
 
}

extension LBAddSeckillController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //case

        
        if indexPath.row == 0{
            let cell : LBAddSeckillFieldCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.fieldCell = cell
            return cell
            
        }else if indexPath.row == 1{
            let cell : ZJSpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
            
        }else if indexPath.row == 2{
            let cell : LBAddSeckillActivityCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.imgTap1.subscribe(onNext: {[unowned self] (btn,fullname) in
                
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
            cell.submitBoutton.addTarget(self, action: #selector(uploadData), for: .touchUpInside)
            cell.contentView.backgroundColor = color_bg_gray_f5
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //case
        if indexPath.row == 0{
            return fit(365)
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

extension LBAddSeckillController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        let cropVC = TOCropViewController(croppingStyle: .default, image: img)
        if self.fullName == "img1" || self.fullName == "img2" || self.fullName == "img3"  {
            cropVC.customAspectRatio = CGSize(width:1,height:1)
            
        }else{
            cropVC.customAspectRatio = CGSize(width:270,height:158)
        }

        cropVC.delegate = self
        picker.dismiss(animated: true) {
            self.present(cropVC, animated: true, completion: nil)
        }
    }
}

extension LBAddSeckillController : TOCropViewControllerDelegate{
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




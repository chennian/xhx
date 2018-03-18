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

    fileprivate lazy var  seckillCell  = LBAddSeckillCell()

    typealias PickedImageHandle = (UIImage) -> ()
    fileprivate var imagePickerFinishHandle: PickedImageHandle?
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.backgroundColor = UIColor.green
        $0.register(LBAddSeckillCell.self)
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        loadData()
        setupUI()
    }
    
    func setupUI() {
        
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
    func  loadData(){
        let paramert:[String:String] = ["":"","":""]
        LBHttpService.LB_Request(.activity, method: .post, parameters: lb_md5Parameter(parameter: paramert), headers: nil, success: {[weak self] (json) in
            
            print(json)
            }, failure: { (failItem) in
        }) { (error) in
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
    
    
    var protocolObject : AliOssTransferProtocol?
    
    var fullName : String = ""
}

extension LBAddSeckillController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LBAddSeckillCell = tableView.dequeueReusableCell(forIndexPath: indexPath)

        cell.imgTap.subscribe(onNext: {[unowned self] (btn,fullname) in
            
//          print("123")
            self.protocolObject = btn
            let alertView = DDZCamerationController()
            let picker = DDZImagePickerVC()
            picker.delegate = self
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let action = UIAlertAction(title: "拍照", style: .default, handler: { (action) in
                    picker.sourceType = .camera
                    
//                    delegate.jumpSubject.onNext(.present(vc:picker,anmi : true))
                    self.present(picker, animated: true, completion: nil)
                })
                alertView.addAction(action)
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                let action = UIAlertAction(title: "图库", style: .default, handler: { (action) in
                    picker.sourceType = .savedPhotosAlbum
//                    delegate.jumpSubject.onNext(.present(vc:picker,anmi : true))
                     self.present(picker, animated: true, completion: nil)
                    
                })
                alertView.addAction(action)
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertView.addAction(cancelAction)
            
            self.present(alertView, animated: true, completion: nil)
        }).disposed(by: cell.disposeBag)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KSCREEN_HEIGHT
    }
    
}


extension LBAddSeckillController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        let cropVC = TOCropViewController(croppingStyle: .default, image: img)
//        cropVC.customAspectRatio = CGSize(1,1)
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
//                    self.objectKey = obk
                    print(obk)
                }
            })
            
        }
        
    }
}

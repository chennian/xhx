//
//  ZJMineViewController.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 26/4/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import Alamofire
var shaowImg = UINavigationController().navigationBar.shadowImage
class ZJMineViewController: SNBaseViewController {



    let tableview = SNBaseTableView().then({
        $0.register(ZJMineFunctionCell.self)
        $0.register(ZJMineSignOutCell.self)
        $0.separatorStyle = .none
        $0.backgroundColor = Color(0xf5f5f5)
//        $0.bounces = false
    })
    
    
    
    let headerView = ZJMineTableviewHeader()
    


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(createImageBy(color: UIColor(red: 255.0 / 255.0, green: 92.0 / 255.0, blue: 3.0 / 255.0, alpha: 1.0)), for: UIBarMetrics.default)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white,NSAttributedStringKey.font:Font(36)]
        UIApplication.shared.statusBarStyle = .lightContent

            headerView.refreshContent()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
        navigationController?.navigationBar.setBackgroundImage(createImageBy(color: .white), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = shaowImg
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:Color(0x313131),NSAttributedStringKey.font:Font(36)]
    }
    let viewModel =  ZJMineViewModel()
    override func setupView() {
        view.addSubview(tableview)
//        view.addSubview(signOutbtn)
        title = "我的"
        viewModel.createModels()
        tableview.delegate = viewModel
        tableview.dataSource = viewModel
        tableview.tableHeaderView = headerView
        headerView.refreshContent()
        headerView.frame = CGRect(x: 0, y: 0, width: ScreenW, height: fit(171))
        tableview.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        
    }
    
    
    override func bindEvent() {
        viewModel.jumpSubject.subscribe(onNext: { (type) in
            switch type{
            case .push(let vc,let anmi):
                
                self.navigationController?.pushViewController(vc, animated: anmi)
                
            case .present(let vc,let anmi):
                self.present(vc, animated: anmi, completion: nil)
            default:
                break
            }
        }).disposed(by: disposeBag)
        
        headerView.publish.subscribe(onNext: { (type) in
            switch type{
            case .login:
                let viewController = LBLoginViewController()
                
                viewController.loginSuccessHanlder = {() in
                    self.viewModel.createModels()
                    viewController.dismiss(animated: true, completion: nil)
                }
                self.present(LBNavigationController(rootViewController:viewController), animated: true, completion: nil)
            case .changeHead:
                self.showPhotoPickerView()
            case .changeName:
                let vc = ZJModifyNickNameVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }).disposed(by: disposeBag)
        viewModel.reloadPublish.subscribe(onNext: { () in
            self.headerView.refreshContent()
            self.tableview.reloadData()
        }).disposed(by: disposeBag)
    }
    
    
    fileprivate func showPhotoPickerView() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action0 = UIAlertAction(title: "拍照", style: .default) {[weak self] (_)  in
            //            self?.showImagePickerController(sourceType: .camera, finishHandel: finishHandel)
            imagePicker.sourceType = .camera
            self?.present(imagePicker, animated: true, completion: nil)
        }
        let action1 = UIAlertAction(title: "相册", style: .default) {[weak self] (_)  in
            //            self?.showImagePickerController(sourceType: .photoLibrary, finishHandel: finishHandel)
            imagePicker.sourceType = .photoLibrary
            self?.present(imagePicker, animated: true, completion: nil)
        }
        let action2 = UIAlertAction(title: "取消", style: .cancel) {(_)  in
        }
        alertController.addAction(action0)
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }

}

extension ZJMineViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        let imgurl = image.compressImage(str: LBKeychain.get(CURRENT_MERC_ID))!["url"] as! URL
        picker.dismiss(animated: false, completion: {
            self.uploadToOSs(img: imgurl)
        })
    }
    
    func uploadToOSs(img : URL){

        let manager = DDZOssManager()
        let date = NSDate()
        let dateFormatter = DateFormatter()
        let timestamp = Int(round(date.timeIntervalSince1970)) + 1
        dateFormatter.dateFormat = "yyyyMMdd"
        let floderDate = dateFormatter.string(from: date as Date)
        
        let md5Str = "\(timestamp)"
        let objecKey = "\((floderDate as NSString).substring(to: 4))/" + "\((floderDate as NSString).substring(from: 4))/" + "\((str: md5Str ))".md5() + ".jpg"
        let path = frontUrl + objecKey

        manager.uploadImg(objectKey: objecKey, url: img, bucketName: BucketName, endPoint: EndPoint) { (success) in
            if success{
                //                    print("上传阿里云成功")
                LBKeychain.set(path, key: HeadImg)//.get(HeadImg)
                self.headerView.refreshContent()
                
                
                self.uploadUrl(url: path)
                
            }else{
                //                self.imagePathArray.removeAll()
                SZHUD("图片上传失败", type: .error, callBack: nil)
            }
        }
        
    }
    
    func uploadUrl(url : String){

        Alamofire.request("http://transaction.xiaoheixiong.net/user/updateHeadImg", method: .post, parameters: ["headUrl" : url], headers: ["X-AUTH-TOKEN":LBKeychain.get(TOKEN),"X-AUTH-TIMESTAMP":LBKeychain.get(LLTimeStamp)]).responseJSON { (res) in
            
        }
        
        
    }
}

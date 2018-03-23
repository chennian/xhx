//
//  ZJHeadTopicPostViewController.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 19/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import TZImagePickerController
class ZJHeadTopicPostViewController: SNBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    let textInputView = ZJHeadTopicInputView()
    
    let imgView = ZJPostHeadTopicMulityImagesView()
    

    override func setupView() {
        view.addSubview(textInputView)

        view.addSubview(imgView)
        
        textInputView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.left.equalToSuperview()
            make.height.snEqualTo(220)
        }
        
        imgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(textInputView.snp.bottom)
        }

    }
    
    
    override func bindEvent() {
        imgView.addNewPicture.subscribe(onNext: {[unowned self] (type) in
            switch type{
            case .addNew(let asset):
                self.addNewPhoto(asset : asset)
            case .showBigPhoto(let imgs,let index):
//                let preview = TZPhotoPreviewController()
////                for img in imgs{
////
////                }
//
//                let  models = imgs.map({return TZAssetModel(asset: $0, type: TZAssetModelMediaTypePhoto)!})
//                ZJLog(messagr: models)
//
//                preview.models = NSMutableArray(array: models)
//                preview.currentIndex = index
////                preview.models
//                self.show(preview, sender: nil)
                break
            }
        }).disposed(by: disposeBag)
    }
    
    func initTZImagePickerController() -> TZImagePickerController{
        let vc = TZImagePickerController(maxImagesCount: 6, columnNumber: 4, delegate: self, pushPhotoPickerVc: true)!
        vc.allowPickingVideo = false
        vc.allowPickingGif = false
        vc.allowPickingOriginalPhoto = false
//        vc.allowPreview = false
        vc.allowTakePicture = false
        vc.allowPickingMultipleVideo = false
//        vc.navigationBar.barTintColor = .black//self.navigationController?.navigationBar.barTintColor
//        vc.navigationBar.tintColor = .black//self.navigationController?.navigationBar.tintColor
//        vc.navigationBar.barStyle = .black
//        vc.selectedAssets = 
        vc.navigationBar.setBackgroundImage(createImageBy(color: .gray), for: .default)
        return vc

    }
    
    
    
    func addNewPhoto(asset : [Any]){
        //
        let alertView = DDZCamerationController()
        let picker = DDZImagePickerVC()
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let action = UIAlertAction(title: "拍照", style: .default, handler: { (action) in
                picker.sourceType = .camera
                
//                delegate.jumpSubject.onNext(.present(vc:picker,anmi : true))
                self.present(picker, animated: true, completion: nil)
            })
            alertView.addAction(action)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let action = UIAlertAction(title: "图库", style: .default, handler: { (action) in
                let vc = self.initTZImagePickerController()
                vc.selectedAssets = NSMutableArray(array: asset)
                self.show(vc, sender: nil)
                
                
            })
            alertView.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertView.addAction(cancelAction)
        present(alertView, animated: true, completion: nil)
        
        
        
        
    }

    

}


extension ZJHeadTopicPostViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ZJHeadTopicPostViewController : TZImagePickerControllerDelegate{
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) {
        imgView.imgArray = photos
        imgView.imgSelect = assets
    }
}

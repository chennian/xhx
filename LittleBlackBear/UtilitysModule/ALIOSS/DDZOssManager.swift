//
//  DDZOssManager.swift
//  DianDianZanMerchant
//
//  Created by zhijian chen on 2017/6/24.
//  Copyright © 2017年 zhijian chen. All rights reserved.
//

import UIKit
import AliyunOSSiOS
import RxSwift
import Kingfisher

func removeFile(filePath : String){
    let manager = FileManager.default
    let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
    
    let file = (path as NSString).appendingPathComponent(filePath)
    if manager.fileExists(atPath: file){
        do{
            try manager.removeItem(atPath: file)
        }catch{
            return
        }
    }
}


class DDZOssManager: NSObject {
    
    static let manager = DDZOssManager()
    
    ///上传图片-data上传
    func uploadImg(objectKey : String,image : UIImage ,imageName:String,bucketName : String,endPoint : String,path:String,result : @escaping (Bool)->()){
        let client = OSSClient(endpoint: endPoint, credentialProvider: credential)
        
        
        let put = OSSPutObjectRequest()
        
        put.bucketName = bucketName
        put.objectKey = objectKey
        
        put.uploadingData = UIImagePNGRepresentation(image)!
        
        let putTask = client.putObject(put)
        let _ = putTask.continue({ (task) -> Any? in
            if (task.error == nil){
                ZJLog(messagr: "succeed")
                result(true)
                //                callBack(objectKey)
            }else{
                                ZJLog(messagr: "error:" + "\(task.error!)")
                result(false)
            }
            return nil
        })
    }
    
    ///上传图片-URL上传
    func uploadImg(objectKey : String,url : URL ,bucketName : String,endPoint : String,result : @escaping (Bool)->()){
        

        let client = OSSClient(endpoint: endPoint, credentialProvider: credential)
        

        let put = OSSPutObjectRequest()
        
        put.bucketName = bucketName
        put.objectKey = objectKey
        
        put.uploadingFileURL = url
        
        let putTask = client.putObject(put)
        let _ = putTask.continue({ (task) -> Any? in
            if (task.error == nil){
                                ZJLog(messagr: "succeed")
                result(true)
//                callBack(objectKey)
            }else{
                ZJLog(messagr: "error:" + "\(task.error!)")
                result(false)
            }
            return nil
        })
        
        
    }
    
    func downloadImag(objectKey : String,bucketName : String,endPoint : String,imgUrl : URL,finshed:@escaping ()->()){
        let client = OSSClient(endpoint: endPoint, credentialProvider: credential)
        
        let downRequst = OSSGetObjectRequest()
        downRequst.bucketName = bucketName
        downRequst.objectKey = objectKey
        downRequst.downloadToFileURL = imgUrl

        
        
        
        let getTask = client.getObject(downRequst)
        
        let _ = getTask.continue({ (task) -> Any? in
            if (task.error == nil){
                //                ZJLog(messagr: "succeed")
                //                callBack(objectKey)
//                let getResult = task.result
//                guard let data = getResult?.downloadedData else {
//                    ZJLog(messagr: "下载结束，单无数据")
//                    return nil
//                }
                
                DispatchQueue.main.async {
                    
                    finshed()
                }
                
                
            }else{
                ZJLog(messagr: "error:" + "\(task.error!)")}
            return nil
        })
    }
    
    func deleteImg(objectKey : String,bucketName : String,endPoint : String){
        let client = OSSClient(endpoint: endPoint, credentialProvider: credential)
        
        let deleteRequst = OSSDeleteObjectRequest()
        deleteRequst.bucketName = bucketName
        deleteRequst.objectKey = objectKey
        let deleteTask = client.deleteObject(deleteRequst)
        
        
        _ = deleteTask.continue({ (task) -> Any? in
            if task.error != nil{
                ZJLog(messagr: task.error!)
            }
            return nil
        })
    }
    

    
    
    
    private lazy var credential  : OSSPlainTextAKSKPairCredentialProvider = {
        return OSSPlainTextAKSKPairCredentialProvider(plainTextAccessKey: OSSAccessKey, secretKey: OSSSecretKey)
    }()
    
    
    

}






/// 上传图片类 协议  AliOssTransferProtocol
protocol AliOssTransferProtocol {
   
    /// 一组view 的标识
    var index : Int{get set}
    
    /// 全名称 用于本地图片缓存 路径命名
    var fuName : String{get set}
    
    /// 当前图片，方便动态监听图片的变化
    var currentImg : Variable<UIImage?>{ get set}
    
    /// 选择图片后 动画展示的view
    var presentView : UIView{get}
    ///<--------------------------------------------------------------->
    
    
    /// objk变化
    var obkVar : Variable<String>{set get}
    
    //    var imgPrefix : String{ get}  拼接图片链接
    func imgPrefix() -> String
    
    /// 本地存放路径
    var imgUrl : URL?{get set}
    
    /// oss路径
//    var objecKey : String{get set}
    
    /// oss endPoint
    var endPoint : String{get}
    
    /// oss bucket
    var bucketName : String{get}
    
    /// 选择新建时 自动删除 oss 文件  自动：true
    var autoDeleteOssObj : Bool{set get}
    
    /// covderView ///挡板view
    var covderView : UIView{set get}
    
    /// 上传结果的信号
    var resPublish : PublishSubject<Bool> {set get}
    
    
    /// 本地更改图片进行图片设置---在这里进行图片的展示，
    ///更改 currentImg 的值，做本地缓存,上传至aliOss
    ///
    /// - Parameter img: 本地相册相机选择出来的图片
     func setPalceImg(img : UIImage,fineshed :@escaping (Bool)->())
    
    /// 设置服务器图片 ---> 针对public buckt 下图片
    /// 直接通过 kf下载
    /// - Parameter img: 服务器图片路径地址
    func setServeImg(imgStr : String,prefix : String)
    
    
    /// 设置服务器图片 ---->  针对private bucket下,通过oss下载图片
    func setServePrivateImg(objectKey : String)
    
    /// 重置
    func reset()
    
    
    
}
extension AliOssTransferProtocol where Self : DDZUploadBtn {
    

    /// 设置本地图片
    /// 自动上传至oss服务器 并且缓存本地文件，同时会删除之前本地和oss路径下的文件
    /// - Parameter img: 本地图片
    func setPalceImg(img: UIImage, fineshed:@escaping  (Bool) -> ()) {
        if obkVar.value != "" && autoDeleteOssObj{
            DDZOssManager.manager.deleteImg(objectKey: obkVar.value, bucketName: bucketName, endPoint: endPoint)
        }
        if imgUrl != nil{
            removeFile(filePath: imgUrl!.absoluteString)
        }
        setImage(img , for: .normal)
        self.covderView.isHidden = false
        
        unowned let weakself = self
        guard let info = img.compressImage(str: fuName + "\(index)") else {
            return
        }
        weakself.imgUrl = (info["url"] as! URL)
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        let timestamp = Int(round(date.timeIntervalSince1970))
        dateFormatter.dateFormat = "yyyyMMdd"
        let floderDate = dateFormatter.string(from: date as Date)
        
        let md5Str = "\(timestamp)" + weakself.fuName + "\(weakself.index)"
        DispatchQueue.global().async {
            let obk = "\((floderDate as NSString).substring(to: 4))/" + "\((floderDate as NSString).substring(from: 4))/" + "\((str: md5Str ))".md5() + ".jpg"
            
            ZJLog(messagr: weakself.obkVar.value)
            DDZOssManager.manager.uploadImg(objectKey: obk, url: weakself.imgUrl!, bucketName: weakself.bucketName, endPoint: weakself.endPoint, result: {res in
                DispatchQueue.main.async {
//                    ZJLog(messagr: "上传完成")
                    ZJLog(messagr: res)
                    self.covderView.isHidden = res
                    self.resPublish.onNext(res)
                    weakself.obkVar.value = obk
//                    ZJLog(messagr: "上传回调调用")
                    fineshed(res)
                }
                

            })
        }
        
    }
    
    
    
    func imgPrefix() -> String{
        return  "https://" + bucketName + "." + (endPoint as NSString).replacingOccurrences(of: "https://", with: "") + "/"
    }
    func setServePrivateImg(objectKey : String){
        
        let documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        unowned let weakself = self
        DispatchQueue.global().async {
            
            let imurl = documentUrl!.appendingPathComponent(objectKey)
            weakself.imgUrl = imurl
            
//            weakself.objecKey = objectKey
            weakself.obkVar.value = objectKey
            DDZOssManager.manager.downloadImag(objectKey: objectKey, bucketName: weakself.bucketName, endPoint: weakself.endPoint, imgUrl: imurl) {
                  let img = try! UIImage(data: Data.init(contentsOf: imurl))
//                ZJLog(messagr: "success")
//                 weakself.currentImg.value = img
                 weakself.setImage(img, for: .normal)
                 weakself.imageView?.contentMode = .scaleAspectFill
            
            }
        }
    }
    
    /// 设置服务器图片
    /// 自动做缓存，并且解析出 objecKey
    /// - Parameter img: 服务器图片路径地址
    func setServeImg(imgStr : String,prefix : String = ""){
        
        
        
        var imgurlPrefix = prefix
        if imgurlPrefix == "" {
            imgurlPrefix = imgPrefix()
        }
        unowned let weakself = self
        let imgUrl = imgurlPrefix + imgStr
        
        
        
        
        kf.setImage(with: URL(string: imgUrl), for: .normal, placeholder: nil, options: nil, progressBlock: nil) { (img, error, type, url) in
            //            weakself.imgUrl = url
            guard let image = img else{
                return
            }
            weakself.currentImg.value = image
//            weakself.objecKey = imgStr
            weakself.obkVar.value = imgStr
        }
        imageView?.contentMode = .scaleAspectFill
    }

    func reset(){
        self.imgUrl = nil
//        self.objecKey = ""
        self.obkVar.value = ""
        self.covderView.isHidden = true
        self.setImage(Oring_image, for: .normal)
    }
    

    
    
    /// 自定义 removeFromSuperview 方法，调用时会删除本地缓存和oss路径下的文件
    func zj_removeFromSuperview(){
        zj_deleObjectFormOssAndLocal()
        removeFromSuperview()
    }
    
    private func zj_deleObjectFormOssAndLocal(){
        if imgUrl != nil{
            removeFile(filePath: imgUrl!.absoluteString)
        }
        if autoDeleteOssObj{
            DDZOssManager.manager.deleteImg(objectKey: obkVar.value, bucketName: bucketName, endPoint: endPoint)
        }
        
    }
}



extension AliOssTransferProtocol where Self : SNBaseTableViewCell {

    func imgPrefix() -> String{
        return  "https://" + bucketName + "." + (endPoint as NSString).replacingOccurrences(of: "https://", with: "") + "/"
    }
    
    
    /// 设置服务器图片
    /// 自动做缓存，并且解析出 objecKey
    /// - Parameter img: 服务器图片路径地址
    func setServeImg(imgStr : String,prefix : String = ""){
        
        
        
        var imgurlPrefix = prefix
        if imgurlPrefix == "" {
            imgurlPrefix = imgPrefix()
        }
        unowned var weakself = self
        let imgUrl = imgurlPrefix + imgStr
        
        
       let img = presentView as! UIImageView
        
        img.kf.setImage(with: URL(string: imgUrl), options: nil, progressBlock: nil) { (img, error, type, url) in
            guard let image = img else{
                return
            }
            weakself.currentImg.value = image
//            weakself.objecKey = imgStr
            weakself.obkVar.value = imgStr
        }
        
        
    }
    
    
    
    /// 设置本地图片
    /// 自动上传至oss服务器 并且缓存本地文件，同时会删除之前本地和oss路径下的文件
    /// - Parameter img: 本地图片
    mutating func setPalceImg(img : UIImage){
        
        if obkVar.value != "" && autoDeleteOssObj{
            DDZOssManager.manager.deleteImg(objectKey: obkVar.value, bucketName: bucketName, endPoint: endPoint)
        }
        if imgUrl != nil{
            removeFile(filePath: imgUrl!.absoluteString)
        }
        
        
        
//        unowned var weakself = self
        guard let info = img.compressImage(str: fuName + "\(index)") else {
            return
        }
//        DispatchQueue.global().async {
        
//            weakself.
        imgUrl = (info["url"] as! URL)
            
            let date = NSDate()
            let dateFormatter = DateFormatter()
            let timestamp = Int(round(date.timeIntervalSince1970))
            dateFormatter.dateFormat = "yyyyMMdd"
            let floderDate = dateFormatter.string(from: date as Date)
            
            let md5Str = "\(timestamp)" + fuName + "\(index)"
            
//            weakself.
        let obk = "\((floderDate as NSString).substring(to: 4))/" + "\((floderDate as NSString).substring(from: 4))/" + "\((str: md5Str ))".md5() + ".jpg"
//        objecKey = obk
        obkVar.value = obk
            
        DDZOssManager.manager.uploadImg(objectKey: obkVar.value, url: imgUrl!, bucketName: bucketName, endPoint: endPoint, result: {result in
            
        })
//        }
        
        currentImg.value = info["image"] as? UIImage
        
        
        let img = presentView as! UIImageView
        DispatchQueue.main.async {
            
            img.image = info["image"] as? UIImage
        }
//        ZJLog(messagr: img)
        
//        guard let imahe = info["image"] as? UIImage else {
//            return
//        }
//        ZJLog(messagr: imahe)
//        setImage(info["image"] as? UIImage, for: .normal)
//        img.contentMode = .scaleAspectFill
    }
    
}



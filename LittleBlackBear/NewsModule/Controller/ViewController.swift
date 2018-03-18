//
//  ViewController.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/16.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

class ViewController: UIViewController,PhotoPickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate {
    
    var selectModel = [PhotoImageModel]()
    var containerView = UIView()
    var publishText = UITextView()
    var placeholderLabel = UILabel()
    var imageArray:[UIImage] = []
    var imagePathArray:[String] = []
    var imagePathString:String = ""
    
    var triggerRefresh = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRightBar()
        
        setUpPublishText()
        self.view.addSubview(self.containerView)
        self.checkNeedAddButton()
        self.renderView()
    }
    
    func setUpRightBar(){
        
        self.title = "发布动态"
        
        let button = UIButton(frame:CGRect(x:0, y:0, width:50, height:30))
        
        button.setTitle("发布", for: UIControlState.normal)
        
        button.setTitleColor(UIColor.red, for: UIControlState.normal)
        
        button.addTarget(self, action: #selector(submit), for: UIControlEvents.touchUpInside)
        
        let item = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem=item
    }
    
    func submit(){
        
        let manager = DDZOssManager()
        
        print(selectModel)
        //上传阿里云
        for itemModel in selectModel {
            if let asset = itemModel.data {
                PHImageManager.default().requestImage(for: asset, targetSize:PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: nil, resultHandler: { (image, info) -> Void in
                    let ossImage = image?.compressImage(image: image!)
                    self.imageArray.append(ossImage!)
                })
            }
        }
        
        print(imageArray)
        
        if !imageArray.isEmpty {
            
            for i in 0..<imageArray.count {
                let date = NSDate()
                let dateFormatter = DateFormatter()
                let timestamp = Int(round(date.timeIntervalSince1970)) + 1
                dateFormatter.dateFormat = "yyyyMMdd"
                let floderDate = dateFormatter.string(from: date as Date)
                
                let md5Str = "\(timestamp)"
                let objecKey = "\((floderDate as NSString).substring(to: 4))/" + "\((floderDate as NSString).substring(from: 4))/" + "\((str: md5Str ))".md5() + "\(i)" + ".jpg"
                let path = frontUrl + objecKey
                print(path)
                self.imagePathArray.append(path)
                manager.uploadImg(objectKey: objecKey, image: self.imageArray[i],imageName:"",bucketName: BucketName, endPoint: EndPoint,path:path){[weak self] (success) in
                    if success{
                        print("上传阿里云成功")
                    }else{
                        print("上传阿里云失败")
                    }
                }
            }
        }
        
        print(imagePathArray)
        if !imagePathArray.isEmpty{
            uploadData()
        }
        
    }
    
    
    private func uploadData(){
        print(self.imagePathArray)
       self.imagePathString = self.imagePathArray.joined(separator: "|")
        print(self.imagePathString)
        let paramert:[String:String] = ["sign":"","mercId":LBKeychain.get(CURRENT_MERC_ID),"mercName":"","description":publishText.text,"images":self.imagePathString]
        LBHttpService.LB_Request(.publishHead, method: .post, parameters: lb_md5Parameter(parameter: paramert), headers: nil, success: {[weak self] (json) in
            
//            let alertView = UIAlertView(title: nil, message: "发布成功", delegate: nil, cancelButtonTitle:"确定" )
//            alertView.show()
            self?.navigationController?.popViewController(animated: true)
            print(json)
            }, failure: { (failItem) in
        }) { (error) in
        }
        
    }
    private func setUpPublishText(){
        self.view.addSubview(self.publishText)
        self.publishText.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100)
        publishText.layer.borderWidth = 0;
        publishText.font = UIFont.systemFont(ofSize: 14)
        publishText.delegate = self
        //        publishText.keyboardType = UIKeyboardType.default
        publishText.returnKeyType = UIReturnKeyType.default
        publishText.showsVerticalScrollIndicator = false // 不显示垂直 滑动线
        publishText.showsHorizontalScrollIndicator = false
        
        
        self.placeholderLabel = UILabel.init() // placeholderLabel是全局属性
        self.placeholderLabel.frame = CGRect(x:5 , y:5, width:220, height:20)
        self.placeholderLabel.font = UIFont.systemFont(ofSize: 14)
        self.placeholderLabel.text = "  发布动态消息到我的头条吧！"
        publishText.addSubview(self.placeholderLabel)
        self.placeholderLabel.textColor = UIColor.gray
        
    }
    
    private func checkNeedAddButton(){
        if self.selectModel.count < PhotoPickerController.imageMaxSelectedNum && !hasButton() {
            selectModel.append(PhotoImageModel(type: ModelType.Button, data: nil))
        }
    }
    
    private func hasButton() -> Bool{
        for item in self.selectModel {
            if item.type == ModelType.Button {
                return true
            }
        }
        return false
    }
    
    /**
     * 删除已选择图片数据 Model
     */
    func removeElement(element: PhotoImageModel?){
        if let current = element {
            self.selectModel = self.selectModel.filter({$0 != current})
            self.triggerRefresh = true // 删除数据事出发重绘界面逻辑
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        self.navigationController?.navigationBar.barStyle = .default
        if self.triggerRefresh { // 检测是否需要重绘界面
            self.triggerRefresh = false
            self.updateView()
        }
    }
    
    private func updateView(){
        self.clearAll()
        self.checkNeedAddButton()
        self.renderView()
    }
    
    private func renderView(){
        
        if selectModel.count <= 0 {return;}
        
        let totalWidth = UIScreen.main.bounds.width
        let space:CGFloat = 10
        let lineImageTotal = 4
        
        let line = self.selectModel.count / lineImageTotal
        let lastItems = self.selectModel.count % lineImageTotal
        
        let lessItemWidth = (totalWidth - (CGFloat(lineImageTotal) + 1) * space)
        let itemWidth = lessItemWidth / CGFloat(lineImageTotal)
        
        for i in 0 ..< line {
            let itemY = CGFloat(i+1) * space + CGFloat(i) * itemWidth
            for j in 0 ..< lineImageTotal {
                let itemX = CGFloat(j+1) * space + CGFloat(j) * itemWidth
                let index = i * lineImageTotal + j
                self.renderItemView(itemX: itemX, itemY: itemY, itemWidth: itemWidth, index: index)
            }
        }
        
        // last line
        for i in 0..<lastItems{
            let itemX = CGFloat(i+1) * space + CGFloat(i) * itemWidth
            let itemY = CGFloat(line+1) * space + CGFloat(line) * itemWidth
            let index = line * lineImageTotal + i
            self.renderItemView(itemX: itemX, itemY: itemY, itemWidth: itemWidth, index: index)
        }
        
        let totalLine = ceil(Double(self.selectModel.count) / Double(lineImageTotal))
        let containerHeight = CGFloat(totalLine) * itemWidth + (CGFloat(totalLine) + 1) *  space
        self.containerView.frame = CGRect(x:0, y:100, width:totalWidth,  height:containerHeight)
    }
    
    private func renderItemView(itemX:CGFloat,itemY:CGFloat,itemWidth:CGFloat,index:Int){
        let itemModel = self.selectModel[index]
        let button = UIButton(frame: CGRect(x:itemX, y:itemY, width:itemWidth, height: itemWidth))
        button.backgroundColor = UIColor.red
        button.tag = index
        
        if itemModel.type == ModelType.Button {
            button.backgroundColor = UIColor.clear
            button.addTarget(self, action: #selector(ViewController.eventAddImage), for: .touchUpInside)
            button.contentMode = .scaleAspectFill
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
            button.setImage(UIImage(named: "image_select"), for: UIControlState.normal)
        } else {
            button.addTarget(self, action: #selector(ViewController.eventPreview), for: .touchUpInside)
            if let asset = itemModel.data {
                let pixSize = UIScreen.main.scale * itemWidth
                PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: pixSize, height: pixSize), contentMode: PHImageContentMode.aspectFill, options: nil, resultHandler: { (image, info) -> Void in
                    if image != nil {
                        button.setImage(image, for: UIControlState.normal)
                        button.contentMode = .scaleAspectFill
                        button.clipsToBounds = true
//                        self.imageArray.append(image!)
                    }
                })
            }
        }
        self.containerView.addSubview(button)
        
    }
    
    private func clearAll(){
        for subview in self.containerView.subviews {
            if let view =  subview as? UIButton {
                view.removeFromSuperview()
            }
        }
    }
    
    // MARK: - 按钮事件
    func eventPreview(button:UIButton){
        let preview = SinglePhotoPreviewViewController()
        let data = self.getModelExceptButton()
        preview.selectImages = data
        preview.sourceDelegate = self
        preview.currentPage = button.tag
        self.show(preview, sender: nil)
    }
    
    
    // 页面底部 stylesheet
    func eventAddImage() {
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // change the style sheet text color
        alert.view.tintColor = UIColor.black
        
        let actionCancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        let actionCamera = UIAlertAction.init(title: "拍照", style: .default) { (UIAlertAction) -> Void in
            self.selectByCamera()
        }
        
        let actionPhoto = UIAlertAction.init(title: "从手机照片中选择", style: .default) { (UIAlertAction) -> Void in
            self.selectFromPhoto()
        }
        
        alert.addAction(actionCancel)
        alert.addAction(actionCamera)
        alert.addAction(actionPhoto)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // 拍照获取
    private func selectByCamera(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera // 调用摄像头
        imagePicker.cameraDevice = .rear // 后置摄像头拍照
        imagePicker.cameraCaptureMode = .photo // 拍照
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.mediaTypes = [kUTTypeImage as String]
        
        imagePicker.modalPresentationStyle = .popover
        self.show(imagePicker, sender: nil)
    }
    
    // MARK: -  拍照 delegate相关方法
    // 退出拍照
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    // 完成拍照
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let mediaType = info[UIImagePickerControllerMediaType] as! String;
        if mediaType == kUTTypeImage as String { // 图片类型
            var image: UIImage? = nil
            var localId: String? = ""
            
            if picker.isEditing { // 拍照图片运行编辑，则优先尝试从编辑后的类型中获取图片
                image = info[UIImagePickerControllerEditedImage] as? UIImage
            }else{
                image = info[UIImagePickerControllerOriginalImage] as? UIImage
            }
            // 存入相册
            if image != nil {
                PHPhotoLibrary.shared().performChanges({
                    let result = PHAssetChangeRequest.creationRequestForAsset(from: image!)
                    let assetPlaceholder = result.placeholderForCreatedAsset
                    localId = assetPlaceholder?.localIdentifier
                }, completionHandler: { (success, error) in
                    if success && localId != nil {
                        let assetResult = PHAsset.fetchAssets(withLocalIdentifiers: [localId!], options: nil)
                        let asset = assetResult[0]
                        DispatchQueue.main.async {
                            self.renderSelectImages(images: [asset])
                        }
                    }
                })
            }
        }
    }
    
    
    /**
     * 从相册中选择图片
     */
    private func selectFromPhoto(){
        PHPhotoLibrary.requestAuthorization {[unowned self] (status) -> Void in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    self.showLocalPhotoGallery()
                    break
                default:
                    self.showNoPermissionDailog()
                    break
                }
            }
        }
    }
    
    /**
     * 用户相册未授权，Dialog提示
     */
    private func showNoPermissionDailog(){
        let alert = UIAlertController.init(title: nil, message: "没有打开相册的权限", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     * 打开本地相册列表
     */
    private func showLocalPhotoGallery(){
        let picker = PhotoPickerController(type: PageType.RecentAlbum)
        picker.imageSelectDelegate = self
        picker.modalPresentationStyle = .popover
        PhotoPickerController.imageMaxSelectedNum = 9 // 允许选择的最大图片张数
        let realModel = self.getModelExceptButton() // 获取已经选择过的图片
        PhotoPickerController.alreadySelectedImageNum = realModel.count
        debugPrint(realModel.count)
        self.show(picker, sender: nil)
    }
    
    func onImageSelectFinished(images: [PHAsset]) {
        self.renderSelectImages(images: images)
    }
    
    private func renderSelectImages(images: [PHAsset]){
        for item in images {
            self.selectModel.insert(PhotoImageModel(type: ModelType.Image, data: item), at: 0)
        }
        
        let total = self.selectModel.count;
        if total > PhotoPickerController.imageMaxSelectedNum {
            for i in 0 ..< total {
                let item = self.selectModel[i]
                if item.type == .Button {
                    self.selectModel.remove(at: i)
                }
            }
        }
        self.renderView()
    }
    
    private func getModelExceptButton()->[PhotoImageModel]{
        var newModels = [PhotoImageModel]()
        for i in 0..<self.selectModel.count {
            let item = self.selectModel[i]
            if item.type != .Button {
                newModels.append(item)
            }
        }
        return newModels
        
    }
    
    
    
    //MARK: UITextViewDelegate
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.placeholderLabel.isHidden = true // 隐藏
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.resignFirstResponder()
            self.placeholderLabel.isHidden = false  // 显示
        }
        else{
            self.placeholderLabel.isHidden = true  // 隐藏
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.resignFirstResponder()
            self.placeholderLabel.isHidden = false  // 显示
        }
        else{
            self.placeholderLabel.isHidden = true  // 隐藏
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{ // 输入换行符时收起键盘
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        publishText.resignFirstResponder() // 收起键盘
        
    }
    
}


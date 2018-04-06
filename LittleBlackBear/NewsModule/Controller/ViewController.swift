//
//  ViewController.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/16.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import Photos
import RxSwift
import MobileCoreServices
import TZImagePickerController
class ViewController: UIViewController,PhotoPickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate {
    
    
    let popPublic = PublishSubject<Bool>()
    var selectModel = [PhotoImageModel]()
    var containerView = UIView()
    var publishText = UITextView()
    var placeholderLabel = UILabel()
    var imageArray:[UIImage] = []
    var imagePathArray:[String] = []
    var imagePathString:String = ""
    var locationSwitch = UISwitch()
    
    fileprivate var  city = LBKeychain.get(LOCATION_CITY_KEY)  + LBKeychain.get(locationSubLocalKey) + LBKeychain.get(locationAareKey)
    fileprivate var  lng =  LBKeychain.get(longiduteKey)
    fileprivate var  lat =  LBKeychain.get(latitudeKey)

    fileprivate let mainView = UIView()
    
    fileprivate let nikeTextField = UITextField()
    
    fileprivate let locationLable = UILabel()
    
    var triggerRefresh = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(city)
        setUpRightBar()
        setNickView()
        setUpPublishText()
        self.view.addSubview(self.containerView)
        setLoctionView()
        self.checkNeedAddButton()
        self.renderView()
    }
    
    func  setLoctionView() {
        
        let locationView = UIView()
        locationView.backgroundColor = ColorRGB(red: 255, green: 255, blue: 255)
        self.view.addSubview(locationView)
        locationView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(self.containerView.snp.bottom)
            make.height.snEqualTo(90)
        }
        
        
        let lineView = UIView()
        lineView.backgroundColor = Color(0xe8e8e8)
        locationView.addSubview(lineView)
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalToSuperview()
        }
        
       let locationImg = UIImageView()
        locationView.addSubview(locationImg)
        locationImg.image = UIImage(named:"mapLoc")
        locationImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
            make.width.snEqualTo(18)
            make.height.equalTo(16)
        }
        
        locationView.addSubview(locationLable)
        locationLable.font = Font(30)
        locationLable.textColor = Color(0x313131)
        print(self.city)
        locationLable.text = self.city
        
        locationLable.snp.makeConstraints { (make) in
            make.left.equalTo(locationImg.snp.right).snOffset(15)
            make.centerY.equalTo(locationImg.snp.centerY)
        }
    }
    
    func setNickView(){
        self.view.backgroundColor = ColorRGB(red: 234, green: 234, blue: 234)
        mainView.backgroundColor = ColorRGB(red: 234, green: 234, blue: 234)
        self.view.addSubview(mainView)
        
        let mainSmallView = UIView()
        mainSmallView.backgroundColor = ColorRGB(red: 255, green: 255, blue: 255)
        
        nikeTextField.borderStyle = .none
        nikeTextField.placeholder = "请设置你的昵称"
        nikeTextField.font = Font(30)
        nikeTextField.textColor = Color(0x313131)
        
        let nickLable = UILabel()
        nickLable.font = Font(30)
        nickLable.textColor = Color(0x313131)
        nickLable.text = "昵称"
        
        
        self.view.addSubview(mainView)
        mainView.addSubview(mainSmallView)
        mainSmallView.addSubview(nickLable)
        mainSmallView.addSubview(nikeTextField)
        
        mainView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.snEqualTo(140)
        }
        mainSmallView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.snEqualTo(100)
        }
        
        nickLable.snp.makeConstraints { (make) in
            make.left.equalTo(mainSmallView.snp.left).snOffset(30)
            make.centerY.equalToSuperview()
            make.width.snEqualTo(80)
        }
        
        nikeTextField.snp.makeConstraints { (make) in
            make.left.equalTo(nickLable.snp.right)
            make.centerY.equalTo(nickLable)
            make.right.equalToSuperview().offset(fit(-100))
        }
    
    }
    func setUpRightBar(){
        
        self.title = "发布头条"
        
        let button = UIButton(frame:CGRect(x:0, y:0, width:50, height:30))
        
        button.setTitle("发送", for: UIControlState.normal)
        
        button.setTitleColor(UIColor.red, for: UIControlState.normal)
        
        button.addTarget(self, action: #selector(submit), for: UIControlEvents.touchUpInside)
        
        let item = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem=item
    }
    func submitImages(){
        
        let manager = DDZOssManager()

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

                manager.uploadImg(objectKey: objecKey, image: self.imageArray[i],imageName:"",bucketName: BucketName, endPoint: EndPoint,path:path){[unowned self] (success) in
                    if success{
                        print("上传阿里云成功")

                    }else{
                        self.imagePathArray.removeAll()
                    }
                }
            }
        }
    }
    
    func submit(){
        
        if nikeTextField.text == ""{
            let alertView = UIAlertView(title: "温馨提示", message: "请输入昵称", delegate: nil, cancelButtonTitle:"确定" )
            alertView.show()
            return
        }
        
        if publishText.text == ""{
            let alertView = UIAlertView(title: "温馨提示", message: "请输入文字", delegate: nil, cancelButtonTitle:"确定" )
            alertView.show()
            return
        }
        if self.imageArray.isEmpty {
            SZHUD("图片上传失败", type: .error, callBack: nil)
            return
        }
        
        self.submitImages()

        let time: TimeInterval = 4.0
        SZHUD("正在发送中...", type: .loading, callBack: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            //code
            self.uploadData()
        }
        
    }
    
    
    private func uploadData(){
    
        
        print(self.imagePathArray)
       self.imagePathString = self.imagePathArray.joined(separator: "|")
        print(self.imagePathString)
        let paramert:[String:String] = ["merc_id":LBKeychain.get(CURRENT_MERC_ID),"description":publishText.text,"images":self.imagePathString,"location_desc":self.city,"lng":self.lng,"lat":self.lat,"nickName":self.nikeTextField.text!]
        LBHttpService.LB_Request2(.publishHead, method: .post, parameters: lb_md5Parameter(parameter: paramert), headers: nil, success: {[weak self] (json) in
            SZHUDDismiss()
            let alertView = UIAlertView(title: nil, message: "发布成功", delegate: nil, cancelButtonTitle:"确定" )
            alertView.show()
            self?.popPublic.onNext(true)
            self?.navigationController?.popViewController(animated: true)
            print(json)
            }, failure: { (failItem) in
                SZHUDDismiss()
        }) { (error) in
            SZHUD("发送失败", type: .error, callBack: nil)
        }
        
    }
    private func setUpPublishText(){
     
        let publishView = UIView()
        self.view.addSubview(publishView)
        publishView.backgroundColor = ColorRGB(red: 255, green: 255, blue: 255)
        publishView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(mainView.snp.bottom)
            make.height.snEqualTo(270)
        }
        self.view.addSubview(self.publishText)
        self.publishText.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(mainView.snp.bottom).snOffset(45)
            make.height.snEqualTo(270)
        }
//        self.publishText.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100)
        publishText.layer.borderWidth = 0;
        publishText.font = Font(30)
        publishText.delegate = self
        //        publishText.keyboardType = UIKeyboardType.default
        publishText.returnKeyType = UIReturnKeyType.default
        publishText.showsVerticalScrollIndicator = false // 不显示垂直 滑动线
        publishText.showsHorizontalScrollIndicator = false
        
        
        self.placeholderLabel = UILabel.init() // placeholderLabel是全局属性
        publishText.addSubview(self.placeholderLabel)

        self.placeholderLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
        }
//        self.placeholderLabel.frame = CGRect(x:5 , y:5, width:220, height:20)
        self.placeholderLabel.font = Font(30)
        self.placeholderLabel.text = "请输入你想说的话"
        self.placeholderLabel.textColor = Color(0xcbcbcb)
        
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
            if let index = selectModel.index(of: current){
                
                self.imageArray.remove(at: index)
            }
            
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
        
        self.containerView.backgroundColor = ColorRGB(red: 255, green: 255, blue: 255)
//        self.containerView.snp.makeConstraints { (make) in
//            make.left.equalToSuperview()
//            make.right.equalToSuperview()
//            make.top.equalTo(publishText.snp.bottom)
//            make.height.snEqualTo(containerHeight)
//        }
        self.containerView.frame = CGRect(x:0, y:fit(410), width:totalWidth,  height:containerHeight)

    }
    
    private func renderItemView(itemX:CGFloat,itemY:CGFloat,itemWidth:CGFloat,index:Int){
        let itemModel = self.selectModel[index]
        let button = UIButton(frame: CGRect(x:itemX, y:itemY, width:itemWidth, height: itemWidth))
        button.backgroundColor = color_bg_gray_f5
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
//        let picker = TZImagePickerController
        /*--------------------------------------------------
         --------------------------------------------------
         */
        let picker = PhotoPickerController(type: PageType.RecentAlbum)
        picker.imageSelectDelegate = self
        picker.modalPresentationStyle = .popover
        PhotoPickerController.imageMaxSelectedNum = 9 // 允许选择的最大图片张数
        let realModel = self.getModelExceptButton() // 获取已经选择过的图片
        PhotoPickerController.alreadySelectedImageNum = realModel.count
        PhotoImage.instance.selectedImage = realModel.map(({return $0.data!}))
        debugPrint(realModel.count)
        self.show(picker, sender: nil)
    }
    ///获取图片结束
    func onImageSelectFinished(images: [PHAsset]) {
        self.renderSelectImages(images: images)
    }
    
    private func renderSelectImages(images: [PHAsset]){
        self.imageArray.removeAll()
//        self.selectModel = [self.selectModel.last!]
        
        let model = self.selectModel.last!
        self.selectModel.removeAll()
        for item in images {
            
           //PHAsset转image
            
            PHImageManager.default().requestImage(for: item, targetSize: PHImageManagerMaximumSize , contentMode: PHImageContentMode.aspectFill, options: nil, resultHandler: { (image, info) -> Void in
                if image != nil {
                    let newImage = image!.compressImage(image:image!)
                    self.imageArray.append(newImage!)
                }
            })
            
            
            self.selectModel.append(PhotoImageModel(type: ModelType.Image, data: item))//.insert(PhotoImageModel(type: ModelType.Image, data: item), at: 0)
        }
        self.selectModel.append(model)
        
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


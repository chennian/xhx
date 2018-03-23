//
//  LBMerchantApplyBaseViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Photos
import AliyunOSSiOS

enum LBMerchantApplyTypeStyle:String{
	case priv = "priv"
	case company = "company"
}
class LBMerchantApplyBaseViewController: UIViewController {
	
	//    var pasteBoard = UIPasteboard.general
	typealias PickedImageHandle = (UIImage) -> ()
	var imagePickerFinishHandle: PickedImageHandle?
    var textFieldKeyBoradTys:[LBTextFieldType] = [LBTextFieldType]()
	var headViewStyle: ApplyHeadViewStyle = .none(topImage: "") {
		didSet {
			let headView = ApplyHeadViewFactory.applyHeadView(tableView: tableView, style: headViewStyle)
			headView?.delegate = self
			tableView.tableHeaderView = headView
			
		}
	}
	
	var cellItems: [[ApplyTableViewCellType]] = [[ApplyTableViewCellType]]() {
		didSet {
			tableView.reloadData()
		}
	}
	
	// 内容数组
	// Any common String  image [UIImage]
	var cellContentDict: [IndexPath: Any?] = [IndexPath: Any?]()
	
	var tableView: LBMerchantApplyBaseTableView = {
		let tableView = LBMerchantApplyBaseTableView(frame: .zero, style: .grouped)
		tableView.separatorStyle = .none
		tableView.bounces = false
		tableView.backgroundColor = COLOR_efefef
		//        tableView.backgroundColor = UIColor.white
		LBMerchantApplyTableViewCellFactory.registerApplyTableViewCell(tableView)
		return tableView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		automaticallyAdjustsScrollViewInsets = false
		view.backgroundColor = UIColor.white
		setupUI()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"left_arrow_white")?.withRenderingMode(.alwaysOriginal),style: .plain,target: self, action: #selector(popViewController))
    }
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.setBackgroundImage(UIImage(named:"applyNav"), for: .topAttached, barMetrics: .default)

    }
	override func viewDidAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//        setupNavBarAlpha()
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		//        self.navigationController?.navigationBar.subviews.first?.alpha = 1
	}
	
	func setupUI() {
		view.addSubview(tableView)
		automaticallyAdjustsScrollViewInsets = false
		tableView.estimatedRowHeight = 0
		tableView.estimatedSectionFooterHeight = 0
		tableView.estimatedSectionHeaderHeight = 0
		tableView.delegate = self
		tableView.dataSource = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: ["tableView": tableView]))
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["tableView": tableView]))
	}
	
}

extension LBMerchantApplyBaseViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		switch cellItems[indexPath.section][indexPath.row] {
		case .common:
			return 50
		case let .image(.images(images: images)):
			return calculateCellHeight(title: nil, images: images)
		case let .image(.titleImages(title: title, images: images)):
			return calculateCellHeight(title: title, images: images)
		case let .button(.button(title: _, top: top, bottom: bottom)):
			return top + bottom + 45.0
		case let .button(.button0(img: _, selectedImg: _, title: _, top: top, bottom: bottom)):
			return top + bottom + 45.0
		}
	}
	
	
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 10
		
	}
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0.001
	}
	
	//    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
	//        return true
	//    }
	//    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
	//        if action == #selector(UIResponderStandardEditActions.copy(_:)) {
	//            return true
	//        }
	//        return false
	//    }
	//    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
	//        let cell = tableView.cellForRow(at: indexPath) as? CommonTableViewCell
	//        pasteBoard.string = cell?.descriptionLabel.text
	//    }
	
}


extension LBMerchantApplyBaseViewController {
	fileprivate func calculateCellHeight(title: String?, images: [UIImage?]) -> CGFloat {
		var height: CGFloat = 0.0
		let width = UIScreen.main.bounds.width - 50.f
		for image in images {
			guard let image = image else {
				return 0
			}
			let size = image.size
			let h = size.height / size.width * width
			height += h
		}
		let oneImageHeightWithMargin = images.count.f * 22.f + height // 以 22 + image 为单位图片高
		
		guard let tit = title else {
			return oneImageHeightWithMargin + 20 // 没title为 (50 / 2 = 25) - 22 = 20 多出的
		}
		
		let t = tit as NSString
		let contentSize = CGSize(width: width, height: CGFloat(MAXFLOAT))
		let h = t.textSizeWith(contentSize: contentSize, font: FONT_28PX).height
		let result = (h + 11 + 13) - 22 + oneImageHeightWithMargin + 5
		return result
	}
	//    func change(_ indexPath: IndexPath, step: Int, toImage: UIImage) {
	////        imageCell.images[step] = toImage
	//        var aImages: [UIImage]
	//        var aTitle: String?
	//
	//        switch cellItems[indexPath.row] {
	//        case let .image(.images(images: images)):
	//            aImages = images
	//        case let .image(.titleImages(title: title, images: images)):
	//            aTitle = title
	//            aImages = images
	//        default:
	//            return
	//        }
	//        aImages[step] = toImage
	//        if let title = aTitle {
	//            cellItems[indexPath.row] = ApplyTableViewCellType.image(.titleImages(title: title, images: aImages))
	//        }else {
	//            cellItems[indexPath.row] = ApplyTableViewCellType.image(.images(images: aImages))
	//        }
	//    }
}


// MARK: - UITableViewDataSource
extension LBMerchantApplyBaseViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return cellItems.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellItems[section].count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = LBMerchantApplyTableViewCellFactory.dequeueReusableCell(withTableView: tableView, type: cellItems[indexPath.section][indexPath.row])!
		cell.currentIndexPath = indexPath
		cell.delegate = self
		guard let content = cellContentDict[indexPath] else {
			return cell
		}
		cell.myCellContent = content
        
		return cell
	}
}


// MARK: - ApplyHeadViewDelegate
extension LBMerchantApplyBaseViewController: ApplyHeadViewDelegate {
	func didSelect(_ segmentedHeadView: SegmentedHeadView, index: Int) {
		Print(index)
	}
}


// MARK: - ApplyTableViewCellDelegate
extension LBMerchantApplyBaseViewController: ApplyTableViewCellDelegate {
	func commonCell(_ commonCell: CommonTableViewCell, textFieldShouldBeginEditing textField: UITextField) {
			guard let indexPath = commonCell.currentIndexPath else {return}
		Print("第  \(indexPath) 的 arrowCellClick \(textField)")
	}
	
	func commonCell(_ commonCell: CommonTableViewCell, textFieldDidEndEditing textField: UITextField) {
		guard let indexPath = commonCell.currentIndexPath else {
			return
		}
		cellContentDict[indexPath] = textField.text
		Print("第  \(indexPath) 的 --->qrtextFieldDidEndEditing\(textField)")
		
	}
	
	
	func commonCell(_ commonCell: CommonTableViewCell, arrowCellClick textField: UITextField) {
	
	}
	
	func commonCell(_ commonCell: CommonTableViewCell, verificationButtonClick verificationButton: UIButton) {
    
	}
	
	func imageCell(_ imageCell: ImageTableViewCell, imageButtonClick imageButton: UIImageView) {
		guard let indexPath = imageCell.currentIndexPath else {
			return
		}
		Print("第 \(indexPath) 的 \(imageButton.tag) verificationButtonClick\(imageButton)")
		imageCell.images[imageButton.tag] = UIImage(named: "yyzz_btn")
		cellContentDict[indexPath] = imageCell.images
	}
	
	func buttonCell(_ buttonCell: ButtonTableViewCell, nextButtonClick nextButton: UIButton) {
		Print("下一步点击")
		Print(cellContentDict)
	}
	
	
}

// MARK: - UIScrollViewDelegate
extension LBMerchantApplyBaseViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		guard scrollView.isEqual(tableView) else {
			return
		}
		//        self.setupNavBarAlpha()
	}
	fileprivate func setupNavBarAlpha() {
		let offsetY = tableView.contentOffset.y
		let minOffsetY: CGFloat = 0.0
		let maxOffsetY: CGFloat = 100.0
		if offsetY > maxOffsetY {
			return
		}
		let alpha = (offsetY - minOffsetY) / (maxOffsetY - minOffsetY)
		UIView.animate(withDuration: 0.3) {
			self.navigationController?.navigationBar.subviews.first?.alpha = alpha > 1 ? 1 : alpha
		}
	}
}

extension LBMerchantApplyBaseViewController{
    func uploadImg(objectKey : String,image : UIImage ,bucketName : String,endPoint : String,result : @escaping (Bool)->()){
        
        let credential  : OSSPlainTextAKSKPairCredentialProvider = OSSPlainTextAKSKPairCredentialProvider(plainTextAccessKey: OSSAccessKey, secretKey: OSSSecretKey)
        
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
    
}
extension LBMerchantApplyBaseViewController{
	
	// 上传图片服务器返回图片路径
	func uploadmerchantImageInfo(image:UIImage,imgName:String,parameters: [String:Any]?=nil,success:@escaping ((String)->())){
        
		let parm = lb_md5Parameter(parameter: parameters)
        
		LBHttpService.LB_uploadSingleImage(.shopPicUpload, image, imgName, parameters: parm as! [String : String], success: {
            success($0["PICURL"].stringValue)
            
        },
            failure: { (failItem) in
                
			UIAlertView(title: "提示",
                        message:failItem.message,
                        delegate: nil,
                        cancelButtonTitle: nil,
                        otherButtonTitles: "确定").show()
		}) { (error) in
            
			UIAlertView(title: "提示",
                        message: error.localizedDescription ,
                        delegate: nil,
                        cancelButtonTitle: nil,
                        otherButtonTitles: "确定").show()
			
		}
	}
}
// MARK: - showAlertView
extension LBMerchantApplyBaseViewController {
	
	func showAlertView(with message: String) {
        
		let alertController = UIAlertController(title: "提示:",
                                                message: message,
                                                preferredStyle: .alert)
		let action = UIAlertAction(title: "确定", style: .cancel) {(_)  in
		}
		alertController.addAction(action)
		self.present(alertController, animated: true, completion: nil)
	}
	
	func showPhotoPickerView(finishHandel: @escaping PickedImageHandle) {
        
        PHPhotoLibrary.requestAuthorization {[weak self](status) in
            guard let strongSelf = self else {return}
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    strongSelf.showPhotoSheet(finishHandel)
                }
                
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({ (status) in
                    if status == .authorized{
                        DispatchQueue.main.async {
                            strongSelf.showPhotoSheet(finishHandel)
                        }
                    }
                })
            case .denied,.restricted:
                let alertController = UIAlertController(title: "",
                                                        message: "是否允许小黑熊访问您的相册",
                                                        preferredStyle: UIAlertControllerStyle.alert)
                let action0 = UIAlertAction(title: "是",
                                            style: UIAlertActionStyle.default,
                                            handler: { (action) in
                    guard let url = URL(string: UIApplicationOpenSettingsURLString) else {
                        Print("UIApplicationOpenSettingsURLString 有可能被废弃了")
                        return
                    }
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url,options: [UIApplicationOpenURLOptionUniversalLinksOnly: false], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                })
                let action1 = UIAlertAction(title: "否", style: UIAlertActionStyle.cancel, handler: nil)
                
                alertController.addAction(action0)
                alertController.addAction(action1)
                strongSelf.present(alertController, animated: true, completion: nil)
            }
            
        }
        
	}
    
   private func showPhotoSheet(_ finishHandel: @escaping((UIImage) -> ())) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action0 = UIAlertAction(title: "拍照", style: .default) {[weak self] (_)  in
            guard let strongSelf = self else{return}
            strongSelf.showImagePickerController(sourceType: .camera, finishHandel: finishHandel)
        }
        let action1 = UIAlertAction(title: "相册", style: .default) {[weak self] (_)  in
            guard let strongSelf = self else{return}
            strongSelf.showImagePickerController(sourceType: .photoLibrary, finishHandel: finishHandel)
        }
        let action2 = UIAlertAction(title: "取消", style: .cancel) {(_)  in}
        
        alertController.addAction(action0)
        alertController.addAction(action1)
        alertController.addAction(action2)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
	private func showImagePickerController(sourceType: UIImagePickerControllerSourceType, finishHandel: @escaping((UIImage) -> ())) {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.sourceType = sourceType
		imagePicker.allowsEditing = false
        self.imagePickerFinishHandle = {finishHandel($0)}
		present(imagePicker, animated: true, completion: nil)
	}
}

extension LBMerchantApplyBaseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
			return
		}
        DispatchQueue.main.async {[weak self] in
            guard let strongSelf = self else{return}
            guard let action = strongSelf.imagePickerFinishHandle else{return}
                action(image)
        }
		picker.dismiss(animated: true, completion: nil)
	}
}

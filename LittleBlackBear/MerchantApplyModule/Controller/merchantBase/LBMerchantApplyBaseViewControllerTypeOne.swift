//
//  LBMerchantApplyBaseViewControllerTypeOne.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBMerchantApplyBaseViewControllerTypeOne: LBMerchantApplyBaseViewController {
    
    fileprivate let DocTypePickView = LBDocTypePickView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 216))
    
    var nextVC: UIViewController?
    var applyStepModel: ApplyTypeOneProtocol?
	var isOtherApply:applyType = .selfApply{
		didSet{
			switch isOtherApply {
			case .selfApply:
				cellItems = [
					[.common(.describe1(imgName:"merchantsInfo",title: "商户负责人信息", subtitle: "（与营业执照法人姓名相同）")),
					 .common(.input0(title: "负责人姓名:", placeholder: "请输入负责人姓名")),
                     .common(.input0(title: "身份证类型:", placeholder: "请选择省身份证类型")),
					 .common(.input0(title: "身份证号:", placeholder: "请输入负责人身份证号")),
                     .common(.input0(title: "身份证有效期:", placeholder: "请输入身份证号有效期,如20220819")),
					 .common(.input0(title: "注册手机号:", placeholder: "请输入注册手机号")),
					 .common(.input0(title: "邮箱地址:", placeholder: "请输入负责人邮箱地址")),
					 .common(.describe(title: "该邮箱将接收与小黑熊商家相关的全部重要信息", subtitle:"")),
					 ],
					[    .image(.images(images: [UIImage( named: "idCardPostive"), UIImage( named: "idCardNegative")])),
						 .button(.button(title: "下一步", top: 30, bottom: 25))
					]
					
				]
			case .otherApply:
				cellItems = [[.common(.describe1(imgName:"myIfonMark",title: "我的信息", subtitle: "")),
							  .common(.input0(title: "申请人账号:", placeholder: "请输入申请人账号")),
							  .common(.input0(title: "申请人姓名:", placeholder: "请输入申请人姓名")),
							  ],
							 [.common(.describe1(imgName:"merchantsInfo",title: "商户负责人信息", subtitle: "（与营业执照法人姓名相同）")),
							  .common(.input0(title: "负责人姓名:", placeholder: "请输入负责人姓名")),
                              .common(.input0(title: "身份证类型:", placeholder: "请选择省身份证类型")),
							  .common(.input0(title: "身份证号:", placeholder: "请输入负责人身份证号")),
                              .common(.input0(title: "身份证有效期:", placeholder: "请输入身份证号有效期,如20220819")),
							  .common(.input0(title: "注册手机号:", placeholder: "请输入注册手机号")),
							  .common(.input0(title: "邮箱地址:", placeholder: "请输入负责人邮箱地址")),
							  .common(.describe(title: "该邮箱将接收与小黑熊商家相关的全部重要信息", subtitle:"")),
							  ],
							 [  .image(.images(images: [UIImage( named: "idCardPostive"), UIImage( named: "idCardNegative")])),
								.button(.button(title: "下一步", top: 30, bottom: 25))
							]]
			}
		}
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let applyStepModel = applyStepModel else {
            return
        }
		switch isOtherApply {
		case .selfApply:
			let images = [applyStepModel.firstImage?.image, applyStepModel.secondImage?.image]
			cellContentDict = [
							   IndexPath(row: 1, section: 0): applyStepModel.name,
                               IndexPath(row: 2, section: 0):applyStepModel.idcardType,
                               IndexPath(row: 3, section: 0):applyStepModel.IDNumber,
                               IndexPath(row: 4, section: 0):applyStepModel.validterm,
							   IndexPath(row: 5, section: 0): applyStepModel.account,
							   IndexPath(row: 6, section: 0):applyStepModel.email,
							   IndexPath(row: 0, section: 1):images,
							   
							   
			]
		case .otherApply:
			let images = [applyStepModel.firstImage?.image, applyStepModel.secondImage?.image]
			cellContentDict = [IndexPath(row: 1, section: 0): applyStepModel.applyPhone,
							   IndexPath(row: 2, section: 0): applyStepModel.applyName,
							   IndexPath(row: 1, section: 1): applyStepModel.name,
                               IndexPath(row: 2, section: 1):applyStepModel.idcardType,
                               IndexPath(row: 3, section: 1):applyStepModel.IDNumber,
                               IndexPath(row: 4, section: 1):applyStepModel.validterm,
							   IndexPath(row: 5, section: 1): applyStepModel.account,
							   IndexPath(row: 6, section: 1):applyStepModel.email,
							   IndexPath(row: 0, section: 2):images,
							   
							   
			]
		}
		
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
		switch isOtherApply {
		case .selfApply:
		
			if let name = cellContentDict[IndexPath(row: 1, section: 0)] as? String {
				applyStepModel?.name = name
			}
            if let idcardType = cellContentDict[IndexPath(row: 2, section: 0)] as? String {
                applyStepModel?.idcardType = idcardType
            }
            if let IDNumber = cellContentDict[IndexPath(row: 3, section: 0)] as? String {
                applyStepModel?.IDNumber = IDNumber
            }
            
            if let validterm = cellContentDict[IndexPath(row: 4, section: 0)] as? String {
                applyStepModel?.validterm = validterm
            }
			if let account = cellContentDict[IndexPath(row: 5, section: 0)] as? String {
				applyStepModel?.account = account
			}
		
            if let email = cellContentDict[IndexPath(row: 6, section: 0)] as? String {
                applyStepModel?.email = email
            }
		case .otherApply:

			if let applyPhone = cellContentDict[IndexPath(row: 1, section: 0)] as? String {
				applyStepModel?.applyPhone = applyPhone
			}
			if let applyPhone = cellContentDict[IndexPath(row: 2, section: 0)] as? String {
				applyStepModel?.applyName = applyPhone
			}
            
			if let name = cellContentDict[IndexPath(row: 1, section: 1)] as? String {
				applyStepModel?.name = name
			}
            if let idcardType = cellContentDict[IndexPath(row: 2, section: 0)] as? String {
                applyStepModel?.idcardType = idcardType
            }
			if let IDNumber = cellContentDict[IndexPath(row: 3, section: 1)] as? String {
				applyStepModel?.IDNumber = IDNumber
			}
            if let validterm = cellContentDict[IndexPath(row: 4, section: 1)] as? String {
                applyStepModel?.validterm = validterm
            }
            if let account = cellContentDict[IndexPath(row: 5, section: 1)] as? String {
                applyStepModel?.account = account
            }
			if let email = cellContentDict[IndexPath(row: 6, section: 1)] as? String {
				applyStepModel?.email = email
			}
		}

        // 本地保存
        
        ApplyModelTool.save(model: ApplyModel.shareApplyModel)
        

    }
    
    override func commonCell(_ commonCell: CommonTableViewCell, textFieldShouldBeginEditing textField: UITextField) {
        guard let indexPath = commonCell.currentIndexPath else {
            return
        }
        if  isOtherApply == .selfApply,indexPath.section == 0{
    
            switch indexPath.row  {
            case 2:
                textField.inputView = DocTypePickView
                DocTypePickView.didSelectRowWithValue = {(value) in
                    textField.text = value
                }
            case 4,5:
                textField.keyboardType = .numberPad
            case 6:
                textField.keyboardType = .emailAddress
            default:
                break
            }
        }
        
        if isOtherApply == .otherApply {
            switch indexPath.section {
            case 0:
                switch indexPath.row  {
                case 1:
                    textField.keyboardType = .numberPad
                case 2:
                    textField.keyboardType = .default
                default:
                    break
                }
            case 1:
                switch indexPath.row  {
                case 1:
                    textField.keyboardType = .default
                case 2:
                    textField.inputView = DocTypePickView
                    DocTypePickView.didSelectRowWithValue = {(value) in
                        textField.text = value
                    }
                case 4,5:
                    textField.keyboardType = .numberPad
                case 6:
                    textField.keyboardType = .emailAddress
                default:
                    break
                }
            default: break
                
            }
        }
     
        
        
    }
    
    override func commonCell(_ commonCell: CommonTableViewCell, textFieldDidEndEditing textField: UITextField) {
        super.commonCell(commonCell, textFieldDidEndEditing: textField)
		guard commonCell.currentIndexPath != nil else {
            return
        }
        
        
    }
    
    override func imageCell(_ imageCell: ImageTableViewCell, imageButtonClick imageButton: UIImageView) {
        guard let indexPath = imageCell.currentIndexPath else {
            return
        }
        showPhotoPickerView { [weak self] (image) in
            guard let strongSelf = self else{return}
            // 上传照片如果上传成功回调
            let tag = imageButton.tag
            imageCell.images[tag] = image
            let imgNames:[String] = ["firstImage","secondImage"]
            var phone:String = ""
            if strongSelf.isOtherApply == .selfApply{
                phone = (strongSelf.cellContentDict[IndexPath(row: 5, section: 0)] as? String ?? "")!
            }else{
                phone = (strongSelf.cellContentDict[IndexPath(row: 5, section: 1)] as? String ?? "")!

            }
//            strongSelf.uploadmerchantImageInfo(image: image, imgName: imgNames[tag], parameters: ["mobile": phone], success: { path in
//                guard path.count > 0 else{return}
//                strongSelf.cellContentDict[indexPath] = imageCell.images
//                switch tag {
//                case 0:
//                    strongSelf.applyStepModel?.firstImage = ApplyImage(image: image, path: path)
//                case 1:
//                    strongSelf.applyStepModel?.secondImage = ApplyImage(image: image, path: path)
////                case 2:
////                    strongSelf.applyStepModel?.threeImage = ApplyImage(image: image, path: path)
//                default:break
//                }
//
//            })
            let date = NSDate()
            let dateFormatter = DateFormatter()
            let timestamp = Int(round(date.timeIntervalSince1970))
            dateFormatter.dateFormat = "yyyyMMdd"
            let floderDate = dateFormatter.string(from: date as Date)
            
            let md5Str = "\(timestamp)"
            let objecKey = "\((floderDate as NSString).substring(to: 4))/" + "\((floderDate as NSString).substring(from: 4))/" + "\((str: md5Str ))".md5() + ".jpg"
            let path = frontUrl + objecKey
            
            let manager = DDZOssManager()
            
            manager.uploadImg(objectKey: objecKey, image: image.compressImage(image: image)!,imageName:imgNames[tag],bucketName: BucketName, endPoint: EndPoint,path:path){[weak self] (success) in
                if success{
                    guard path.count > 0 else{return}
                    strongSelf.cellContentDict[indexPath] = imageCell.images
                    switch tag {
                        case 0:
                        strongSelf.applyStepModel?.firstImage = ApplyImage(image: image, path: path)
                        case 1:
                        strongSelf.applyStepModel?.secondImage = ApplyImage(image: image, path: path)
                        default:break
                        
                    }
                    print(path)
                }else{
                    SZHUD("图片上传失败", type: .error, callBack: nil)
                    return
                }
            
            }
        }
    }
    
    override func buttonCell(_ buttonCell: ButtonTableViewCell, nextButtonClick nextButton: UIButton) {
		switch isOtherApply {
		case .otherApply:
			// 字典转模型
			guard (cellContentDict[IndexPath(row: 1, section: 0)] as? String) != nil else {
				showAlertView(with: "请输入申请账号")
				return
			}
			guard (cellContentDict[IndexPath(row: 2, section: 0)] as? String) != nil else {
				showAlertView(with: "请输入申请人姓名")
				return
			}
			
			guard (cellContentDict[IndexPath(row: 1, section: 1)] as? String) != nil else {
				showAlertView(with: "请输入负责人姓名")
				return
			}
			guard (cellContentDict[IndexPath(row: 2, section: 1)] as? String) != nil else {
				showAlertView(with: "请输入身份证类型")
				return
			}
			guard (cellContentDict[IndexPath(row: 3, section: 1)] as? String) != nil else {
				showAlertView(with: "请输入负责人身份证号")
				return
			}
            guard (cellContentDict[IndexPath(row: 4, section: 1)] as? String) != nil else {
                showAlertView(with: "请输入负责人身份证号有效期")
                return
            }
            guard (cellContentDict[IndexPath(row: 5, section: 1)] as? String) != nil else {
                showAlertView(with: "请输入负责人注册手机号")
                return
            }
			guard (cellContentDict[IndexPath(row: 6, section: 1)] as? String) != nil else {
				showAlertView(with: "请输入负责人邮箱地址")
				return
			}
			Print(cellContentDict)
			guard (cellContentDict[IndexPath(row: 0, section: 2)] as? [UIImage])?.count == 2 else {
				showAlertView(with: "请上传照片")
				return
			}

		case .selfApply:
        
			guard (cellContentDict[IndexPath(row: 1, section: 0)] as? String) != nil else {
				showAlertView(with: "请输入负责人姓名")
				return
			}
			guard (cellContentDict[IndexPath(row: 2, section: 0)] as? String) != nil else {
				showAlertView(with: "请输入负责人身份证类型")
				return
			}
			guard (cellContentDict[IndexPath(row: 3, section: 0)] as? String) != nil else {
				showAlertView(with: "请输入负责人身份证号")
				return
			}
            guard (cellContentDict[IndexPath(row: 4, section: 0)] as? String) != nil else {
                showAlertView(with: "请输入负责人身份证号有效期")
                return
            }
            guard (cellContentDict[IndexPath(row: 5, section: 0)] as? String) != nil else {
                showAlertView(with: "请输入负责人手机号码")
                return
            }
			guard (cellContentDict[IndexPath(row: 6, section: 0)] as? String) != nil else {
				showAlertView(with: "请输入负责人邮箱地址")
				return
			}
			Print(cellContentDict)
            guard var applyStepModel = applyStepModel, let _ = applyStepModel.firstImage?.path, let _ = applyStepModel.secondImage?.path  else {
                showAlertView(with: "请上传照片")
                return
            }
//            guard (cellContentDict[IndexPath(row: 0, section: 1)] as? [UIImage])?.count == 3 else {
//                showAlertView(with: "请上传照片")
//                return
//            }

		}
        

        
        guard let vc = nextVC else {
            return
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}


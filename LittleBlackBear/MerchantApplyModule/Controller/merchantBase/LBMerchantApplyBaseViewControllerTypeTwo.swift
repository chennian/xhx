//
//  LBMerchantApplyBaseViewControllerTypeTwo.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBMerchantApplyBaseViewControllerTypeTwo: LBMerchantApplyBaseViewController {
    
    fileprivate let industryPickView = LBIndustryPickerView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 216))
    fileprivate let industryDetailPickView = LBIndustryDetailPickView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 216))
    fileprivate let cityPickView = LBCityPickerView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 216))
    
    var nextVC: UIViewController?
    var applyStepModel: ApplyTypeTwoProtocol?
    
    
    fileprivate var companyProvince:String = ""
    fileprivate var companyCity:String = ""
    fileprivate var companyType:String  = ""
    fileprivate var industry_firstTextField:String = ""
    fileprivate var industry_secondTextField:String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "LBMerchantApplyTypeStyle") as! String == LBMerchantApplyTypeStyle.priv.rawValue {
            
            cellItems = [[
                .common(.describe1(imgName: "quickOpen", title: "快捷开通", subtitle: "")),
                .image(.images(images: [UIImage( named: "shopFrontPhoto"),UIImage( named: "businessLicense"),UIImage( named: "checkStandPic"),UIImage( named: "storePic")]))
                ],[
                    .common(.describe1(imgName: "enterpriseInfo", title: "企业信息", subtitle: "(按证书上的内容出自填写,带*为必填)")),
                    .common(.input0(title: "*商户简称：", placeholder: "该名称在支付完成页面向用户展示")),
                    .common(.input0(title: "企业名称：", placeholder: "请输入企业名称缩")),
                    .common(.input0(title: "统一社会信用代码：", placeholder: "如 00000000001234")),
                    .common(.input0(title: "营业执照有效期：", placeholder: "请输入营业执照有效期,如20220819")),
                    .common(.input3(title: "公司地址:", placeholder: "请选择省市", constraint:KSCREEN_WIDTH)),
                    .common(.input3(title: "        ", placeholder: "请输入公司详细地址(省市区街道)", constraint:15)),
                    .common(.input3(title: "行业类别：", placeholder: "请选择行业类别", constraint:KSCREEN_WIDTH)),
                    .common(.input3(title: "        ", placeholder: "金银珠宝/钻石/玉石", constraint:15)),
                    .button(.button(title: "下一步", top: 30, bottom: 25))
                ] ]
        }else{
            cellItems = [[
                .common(.describe1(imgName: "quickOpen", title: "快捷开通", subtitle: "")),
                .image(.images(images: [UIImage( named: "shopFrontPhoto"),UIImage( named: "businessLicense"),UIImage( named: "checkStandPic")]))
                ],[
                    .common(.describe1(imgName: "enterpriseInfo", title: "企业信息", subtitle: "(按证书上的内容出自填写,带*为必填)")),
                    .common(.input0(title: "*商户简称：", placeholder: "该名称在支付完成页面向用户展示")),
                    .common(.input0(title: "企业名称：", placeholder: "请输入企业名称缩")),
                    .common(.input0(title: "统一社会信用代码：", placeholder: "如 00000000001234")),
                    .common(.input0(title: "营业执照有效期：", placeholder: "请输入营业执照有效期,如20220819")),
                    .common(.input3(title: "公司地址:", placeholder: "请选择省市", constraint:KSCREEN_WIDTH)),
                    .common(.input3(title: "        ", placeholder: "请输入公司详细地址(省市区街道)", constraint:15)),
                    .common(.input3(title: "行业类别：", placeholder: "请选择行业类别", constraint:KSCREEN_WIDTH)),
                    .common(.input3(title: "        ", placeholder: "金银珠宝/钻石/玉石", constraint:15)),
                    .button(.button(title: "下一步", top: 30, bottom: 25))
                ] ]
        }
        
        print(UserDefaults.standard.object(forKey: "LBMerchantApplyTypeStyle") as! String )
        dealToIndustryPickViewAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let applyStepModel = applyStepModel else {
            return
        }
        if UserDefaults.standard.object(forKey: "LBMerchantApplyTypeStyle") as! String == LBMerchantApplyTypeStyle.priv.rawValue {
            let images = [applyStepModel.shopFrontPhotoImage?.image,applyStepModel.businessLicenseImage?.image,applyStepModel.checkStandPic?.image,applyStepModel.storePic?.image]
            cellContentDict = [
                IndexPath(row: 1, section: 0): images,
                IndexPath(row: 1, section: 1): applyStepModel.merchantAbbreviation,
                IndexPath(row: 2, section: 1): applyStepModel.enterpriseName,
                IndexPath(row: 3, section: 1): applyStepModel.businessLicenseNum,
                IndexPath(row: 4, section: 1): applyStepModel.enterpraiseLicenseTerm,
                IndexPath(row: 5, section: 1): applyStepModel.companyAddress,
                IndexPath(row: 6, section: 1): applyStepModel.companyAddressDetails,
                IndexPath(row: 7, section: 1): applyStepModel.companyFirstLevel,
                IndexPath(row: 8, section: 1): applyStepModel.companySecondLevel,
            ]
        }else{
            let images = [applyStepModel.shopFrontPhotoImage?.image,applyStepModel.businessLicenseImage?.image,applyStepModel.checkStandPic?.image]
            cellContentDict = [
                IndexPath(row: 1, section: 0): images,
                IndexPath(row: 1, section: 1): applyStepModel.merchantAbbreviation,
                IndexPath(row: 2, section: 1): applyStepModel.enterpriseName,
                IndexPath(row: 3, section: 1): applyStepModel.businessLicenseNum,
                IndexPath(row: 4, section: 1): applyStepModel.enterpraiseLicenseTerm,
                IndexPath(row: 5, section: 1): applyStepModel.companyAddress,
                IndexPath(row: 6, section: 1): applyStepModel.companyAddressDetails,
                IndexPath(row: 7, section: 1): applyStepModel.companyFirstLevel,
                IndexPath(row: 8, section: 1): applyStepModel.companySecondLevel,
            ]
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 字典转模型
        if let merchantAbbreviation = cellContentDict[IndexPath(row: 1, section: 1)] as? String {
            applyStepModel?.merchantAbbreviation = merchantAbbreviation
        }
        if let enterpriseName = cellContentDict[IndexPath(row: 2, section: 1)] as? String {
            applyStepModel?.enterpriseName = enterpriseName
        }
        if let businessLicenseNum = cellContentDict[IndexPath(row: 3, section: 1)] as? String {
            applyStepModel?.businessLicenseNum = businessLicenseNum
        }
        if let enterpraiseLicenseTerm = cellContentDict[IndexPath(row: 4, section: 1)] as? String {
            applyStepModel?.enterpraiseLicenseTerm = enterpraiseLicenseTerm
        }
        if let companyAddress = cellContentDict[IndexPath(row: 5, section: 1)] as? String {
            applyStepModel?.companyAddress = companyAddress
        }
        if let companyAddressDetails = cellContentDict[IndexPath(row:6, section: 1)] as? String {
            applyStepModel?.companyAddressDetails = companyAddressDetails
        }
        if let companyFirstLevel = cellContentDict[IndexPath(row:7, section: 1)] as? String {
            applyStepModel?.companyFirstLevel = companyFirstLevel
        }
        if let companySecondLevel = cellContentDict[IndexPath(row:8, section: 1)] as? String {
            applyStepModel?.companySecondLevel = companySecondLevel
        }
        if companyType.count > 0 {
            applyStepModel?.companyType = companyType
        }
        if companyCity.count > 0 {
            applyStepModel?.companyCity = companyCity
        }
        if companyProvince.count > 0 {
            applyStepModel?.companyProvince = companyProvince
        }
        
        ApplyModelTool.save(model: ApplyModel.shareApplyModel)
    }
    
    override func buttonCell(_ buttonCell: ButtonTableViewCell, nextButtonClick nextButton: UIButton) {
        // 字典转模型
        
        if UserDefaults.standard.object(forKey: "LBMerchantApplyTypeStyle") as! String == LBMerchantApplyTypeStyle.priv.rawValue {
            guard var applyStepModel = applyStepModel, let _ = applyStepModel.shopFrontPhotoImage?.path, let _ = applyStepModel.businessLicenseImage?.path,let _ = applyStepModel.checkStandPic?.path,let _ = applyStepModel.storePic?.path else {
                showAlertView(with: "请上传照片")
                return
            }
        }else{
            guard var applyStepModel = applyStepModel, let _ = applyStepModel.shopFrontPhotoImage?.path, let _ = applyStepModel.businessLicenseImage?.path,let _ = applyStepModel.checkStandPic?.path else {
                showAlertView(with: "请上传照片")
                return
                
            }
        }
        
        
        guard (cellContentDict[IndexPath(row: 1, section: 1)] as? String) != nil else {
            showAlertView(with: "请输入商户简称")
            return
        }
        guard (cellContentDict[IndexPath(row: 2, section: 1)] as? String) != nil else {
            showAlertView(with: "请输入企业名称")
            return
        }
        guard (cellContentDict[IndexPath(row: 3, section: 1)] as? String) != nil else {
            showAlertView(with: "营业执照注册号")
            return
        }
        guard (cellContentDict[IndexPath(row: 4, section: 1)] as? String) != nil else {
            showAlertView(with: "营业执照有效期")
            return
        }
        guard (cellContentDict[IndexPath(row: 5, section: 1)] as? String) != nil else {
            showAlertView(with: "请选择公司所在省市")
            return
        }
        guard (cellContentDict[IndexPath(row: 6, section: 1)] as? String) != nil else {
            showAlertView(with: "请输入公司详细地址(省市区街道)")
            return
        }
        guard (cellContentDict[IndexPath(row: 7, section: 1)] as? String) != nil else {
            showAlertView(with: "请选择行业类别")
            return
        }
        guard (cellContentDict[IndexPath(row: 8, section: 1)] as? String) != nil else {
            showAlertView(with: "请选择行业类别")
            return
        }
        
        guard let vc = nextVC else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    override func commonCell(_ commonCell: CommonTableViewCell, textFieldShouldBeginEditing textField: UITextField) {
        guard let indexPath = commonCell.currentIndexPath else {
            return
        }
        if indexPath.section == 1 {
            switch indexPath.row  {
            case 5:
                textField.inputView = cityPickView
                cityPickView.didSelectRowWithValue = { [weak self](value1,value2) in
                    guard let strongSelf = self else {return}
                    strongSelf.companyProvince = value1
                    strongSelf.companyCity = value2
                    strongSelf.applyStepModel?.companyCity = value2
                    strongSelf.applyStepModel?.companyProvince = value1
                    textField.text = value1 + value2
                }
            case 7:
                textField.inputView = industryPickView
                industryPickView.didSelectRowWithValue = {[weak self](value1,value2) in
                    guard let strongSelf = self else {return}
                    strongSelf.industry_firstTextField = value1 + value2
                    textField.text = value1 + value2
                }
            case 8:
                textField.inputView = industryDetailPickView
                industryDetailPickView.didSelectRowWithValue = { [weak self](value1,value2) in
                    guard let strongSelf = self else {return}
                    strongSelf.industry_secondTextField = value2
                    strongSelf.companyType = "\(value1)"
                    textField.text =  value2
                }
                
            default:
                textField.inputView = nil
                break
            }
            
        }
        
        
    }
    
    
    override func imageCell(_ imageCell: ImageTableViewCell, imageButtonClick imageButton: UIImageView) {
        guard let indexPath = imageCell.currentIndexPath else {return}
        showPhotoPickerView { [weak self] (image) in
            guard let strongSelf = self else{return}
            // 上传照片如果上传成功回调
            let tag = imageButton.tag
            imageCell.images[tag] = image
            var imgNames:[String] = ["shopFrontPhotoImage","businessLicenseImage","checkStandPic"]
            
            if UserDefaults.standard.object(forKey: "LBMerchantApplyTypeStyle") as! String == LBMerchantApplyTypeStyle.priv.rawValue {
                imgNames = ["shopFrontPhotoImage","businessLicenseImage","checkStandPic","storePic"]
                
            }else{
                imgNames = ["shopFrontPhotoImage","businessLicenseImage","checkStandPic"]
                
            }
            
            strongSelf.cellContentDict[indexPath] = imageCell.images
            
            
            let date = NSDate()
            let dateFormatter = DateFormatter()
            let timestamp = Int(round(date.timeIntervalSince1970))
            dateFormatter.dateFormat = "yyyyMMdd"
            let floderDate = dateFormatter.string(from: date as Date)
            
            let md5Str = "\(timestamp)"
            let objecKey = "\((floderDate as NSString).substring(to: 4))/" + "\((floderDate as NSString).substring(from: 4))/" + "\((str: md5Str ))".md5() + ".jpg"
            let path = frontUrl + objecKey
            
            let manager = DDZOssManager()
            SZHUD("正在上传中", type: .loading, callBack: nil)
            let newImage = image.compressImage(image: image)

            manager.uploadImg(objectKey: objecKey, image:newImage!,imageName:imgNames[tag],bucketName: BucketName, endPoint: EndPoint,path:path){[weak self] (success) in
                if success{
                    if UserDefaults.standard.object(forKey: "LBMerchantApplyTypeStyle") as! String == LBMerchantApplyTypeStyle.priv.rawValue {
                        switch tag {
                        case 0:
                            strongSelf.applyStepModel?.shopFrontPhotoImage = ApplyImage(image: image, path: path)
                        case 1:
                            strongSelf.applyStepModel?.businessLicenseImage = ApplyImage(image: image, path: path)
                        case 2:
                            strongSelf.applyStepModel?.checkStandPic = ApplyImage(image: image, path: path)
                        case 3:
                            strongSelf.applyStepModel?.storePic = ApplyImage(image: image, path: path)
                        default:break
                            
                        }
                        SZHUDDismiss()

                    }else{
                        switch tag {
                        case 0:
                            strongSelf.applyStepModel?.shopFrontPhotoImage = ApplyImage(image: image, path: path)
                        case 1:
                            strongSelf.applyStepModel?.businessLicenseImage = ApplyImage(image: image, path: path)
                        case 2:
                            strongSelf.applyStepModel?.checkStandPic = ApplyImage(image: image, path: path)
                        default:break
                        }}
                    print(path)
                }else{
                    SZHUD("图片上传失败", type: .error, callBack: nil)
                    return                }
                
            }
            
//            let phone =  ApplyModel.shareApplyModel.applySelfModel.stepOne.applyPhone
//            strongSelf.uploadmerchantImageInfo(image: image, imgName: imgNames[tag], parameters: ["mobile": phone ?? "13714821123"], success: { path in
//                guard path.count > 0 else{return}
//
//                if UserDefaults.standard.object(forKey: "LBMerchantApplyTypeStyle") as! String == LBMerchantApplyTypeStyle.priv.rawValue {
//                    switch tag {
//                    case 0:
//                        strongSelf.applyStepModel?.shopFrontPhotoImage = ApplyImage(image: image, path: path)
//                    case 1:
//                        strongSelf.applyStepModel?.businessLicenseImage = ApplyImage(image: image, path: path)
//                    case 2:
//                        strongSelf.applyStepModel?.checkStandPic = ApplyImage(image: image, path: path)
//                    case 3:
//                        strongSelf.applyStepModel?.storePic = ApplyImage(image: image, path: path)
//                    default:break
//
//                    }}else{
//                    switch tag {
//                    case 0:
//                        strongSelf.applyStepModel?.shopFrontPhotoImage = ApplyImage(image: image, path: path)
//                    case 1:
//                        strongSelf.applyStepModel?.businessLicenseImage = ApplyImage(image: image, path: path)
//                    case 2:
//                        strongSelf.applyStepModel?.checkStandPic = ApplyImage(image: image, path: path)
//                    default:break
//                    }}
//            })
        }
    }
}
// MARK: dealToIndustryPickViewAction
extension LBMerchantApplyBaseViewControllerTypeTwo{
    
    func dealToIndustryPickViewAction() {
        
        cityPickView.dissMissIndustryPickerViewAction = {}
        // 行业类别一级
        industryPickView.dissMissIndustryPickerViewAction = {}
        industryPickView.IndustryDetailPickView = {[weak self] (list) in
            guard let strongSelf = self else {return}
            strongSelf.industryDetailPickView.List = list
        }
        // 行业类别二级
        industryDetailPickView.dissMissIndustryPickerViewAction = {}
        
    }
}









//
//  LBMerchantApplyBaseViewControllerTypeThree.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//
import UIKit
import RxSwift

class LBMerchantApplyBaseViewControllerTypeThree: LBMerchantApplyBaseViewController {
    
    fileprivate let disposeBag = DisposeBag()
    
    fileprivate let bankTotalPickView = LBBankTotalPickView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 216))
    fileprivate let bankBranchPickView = LBBankBranchPickerView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 216))
    fileprivate let cityPickView = LBCityPickerView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 216))
    fileprivate var banktotalid:String = ""
    fileprivate var entbankInfCity:String = ""
    fileprivate var entbankInfProvince:String = ""
    fileprivate var isReadingPrivate:Bool = false
    
    fileprivate let protocolButton = LBPrivatePolicyButtonView()
    
    fileprivate var applyType:LBMerchantApplyTypeStyle = .priv
    var nextVC: UIViewController?
    
    var applyStepModelPriv: ApplyTypeThreeProtocol?
    var applyStepModelCompany: ApplyTypeThreeProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        pickView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.object(forKey: "LBMerchantApplyTypeStyle") as! String == LBMerchantApplyTypeStyle.priv.rawValue {
            guard let applyStepModel = applyStepModelPriv else {
                return
            }
            let images = [applyStepModel.bankFirstImg?.image,applyStepModel.bankFirstImg?.image]
            cellContentDict = [
                IndexPath(row: 0, section: 0): images,
                IndexPath(row: 2, section: 0): applyStepModel.bankCard,
                IndexPath(row: 3, section: 0): applyStepModel.bankCardID,
                IndexPath(row: 4, section: 0): applyStepModel.bankAddress,
                IndexPath(row: 5, section: 0): applyStepModel.branchBank,
                IndexPath(row: 6, section: 0): applyStepModel.bankName,
                IndexPath(row: 7, section: 0): applyStepModel.bankPhone,
                
            ]
            applyType = .priv
        }else{
            applyType = .company
            guard let applyStepModel = applyStepModelCompany else {
                return
            }
            let images = [applyStepModel.licenseImage?.image]
            cellContentDict = [
                IndexPath(row: 0, section: 0): images,
                IndexPath(row: 2, section: 0): applyStepModel.bankCard,
                IndexPath(row: 3, section: 0): applyStepModel.bankCardID,
                IndexPath(row: 4, section: 0): applyStepModel.bankAddress,
                IndexPath(row: 5, section: 0): applyStepModel.branchBank,
                IndexPath(row: 6, section: 0): applyStepModel.bankName,
                IndexPath(row: 7, section: 0): applyStepModel.bankPhone,
            ]
        }
        
        
        
    }
    private  func setUpUI() {
        if UserDefaults.standard.object(forKey: "LBMerchantApplyTypeStyle") as! String == LBMerchantApplyTypeStyle.priv.rawValue {
            setupPrivateUI()
            applyType = .priv
        }else{
            setupCompanyUI()
            applyType = .company
            
        }
        tableView.tableFooterView = protocolButton
        tableView.tableFooterView?.backgroundColor = COLOR_ffffff
        protocolButton.clickPrivateBtn = {[weak self] (button)in
            button.isSelected = !button.isSelected
            self?.isReadingPrivate = button.isSelected
        }
        protocolButton.clickPrivateDetailBtn = {[weak self](_) in
            guard let  `self` = self else{return}
            let viewController = LBPrivatePolicyViewController()
            viewController.accepttedPolicy = {(result)in
                self.isReadingPrivate = result
                viewController.dismiss(animated: true, completion: nil)
            }
            self.present(LBNavigationController(rootViewController:viewController), animated: true, completion: nil)
            
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        saveData()
    }
    
    func saveData(){
        switch self.applyType {
        case .priv:
            
            if let bankCard = cellContentDict[IndexPath(row: 2, section: 0)] as? String {
                applyStepModelPriv?.bankCard = bankCard
            }
            if let bankCardID = cellContentDict[IndexPath(row: 3, section: 0)] as? String {
                applyStepModelPriv?.bankCardID = bankCardID
            }
            if let bankAddress = cellContentDict[IndexPath(row: 4, section: 0)] as? String {
                applyStepModelPriv?.bankAddress = bankAddress;
            }
            if let branchBank = cellContentDict[IndexPath(row: 5, section: 0)] as? String {
                applyStepModelPriv?.branchBank = branchBank
            }
            if let bankName = cellContentDict[IndexPath(row: 6, section: 0)] as? String {
                applyStepModelPriv?.bankName = bankName
            }
            if let bankPhone = cellContentDict[IndexPath(row: 7, section: 0)] as? String {
                applyStepModelPriv?.bankPhone = bankPhone
            }
            
        case .company:
            if let bankCard = cellContentDict[IndexPath(row: 2, section: 0)] as? String {
                applyStepModelCompany?.bankCard = bankCard
            }
            if let bankCardID = cellContentDict[IndexPath(row: 3, section: 0)] as? String {
                applyStepModelCompany?.bankCardID = bankCardID
            }
            if let bankAddress = cellContentDict[IndexPath(row: 4, section: 0)] as? String {
                applyStepModelCompany?.bankAddress = bankAddress;
            }
            if let branchBank = cellContentDict[IndexPath(row: 5, section: 0)] as? String {
                applyStepModelCompany?.branchBank = branchBank
            }
            if let bankName = cellContentDict[IndexPath(row: 6, section: 0)] as? String {
                applyStepModelCompany?.bankName = bankName
            }
            if let bankPhone = cellContentDict[IndexPath(row: 7, section: 0)] as? String {
                applyStepModelCompany?.bankPhone = bankPhone
            }
        }
        // 保存本地
        ApplyModelTool.save(model: ApplyModel.shareApplyModel)
    }
    
    override func buttonCell(_ buttonCell: ButtonTableViewCell, nextButtonClick nextButton: UIButton) {
        
        guard isReadingPrivate == true else{
            showAlertView(with: "请勾选已阅读隐私条款")
            return
            
        }
        
        switch nextButton.tag {
        case 1:
            let viewController = LBPrivatePolicyViewController()
            viewController.accepttedPolicy = {[weak self](result)in
                guard let  `self` = self else{return}
                nextButton.isSelected = result
                self.isReadingPrivate = nextButton.isSelected
                viewController.dismiss(animated: true, completion: nil)
            }
            present(LBNavigationController(rootViewController:viewController), animated: true, completion: nil)
            
        default:
            
            saveData()
            switch self.applyType {
            case .priv:
                
                guard var applyStepModel = applyStepModelPriv, let _ = applyStepModel.bankFirstImg?.path, let _ = applyStepModel.bankSecondImg?.path else {
                    showAlertView(with: "请上传照片")
                    return
                }
                guard (cellContentDict[IndexPath(row: 2, section: 0)] as? String) != nil else {
                    showAlertView(with: "请输入银行卡号")
                    return
                }
                guard (cellContentDict[IndexPath(row: 3, section: 0)] as? String) != nil else {
                    showAlertView(with: "请选择开户行")
                    return
                }
                guard (cellContentDict[IndexPath(row: 4, section: 0)] as? String) != nil else {
                    showAlertView(with: "请选择开户行所在地")
                    return
                }
                guard (cellContentDict[IndexPath(row: 5, section: 0)] as? String) != nil else {
                    showAlertView(with: "请选择开户支行")
                    return
                }
                guard (cellContentDict[IndexPath(row: 6, section: 0)] as? String) != nil else {
                    showAlertView(with: "请输入银行开户名")
                    return
                }
                guard (cellContentDict[IndexPath(row: 7, section: 0)] as? String) != nil else {
                    showAlertView(with: "请输入银行预留手机号码")
                    return
                }
                
            case .company:
                guard var applyStepModel = applyStepModelCompany, let _ = applyStepModel.licenseImage?.path else {
                    showAlertView(with: "请上传照片")
                    return
                }
                guard (cellContentDict[IndexPath(row: 7, section: 0)] as? String) != nil else {
                    showAlertView(with: "请输入银行预留手机号码")
                    return
                }
            }
            uploadInfoRequire(button: nextButton)
            
        }
    }
    
    override func commonCell(_ commonCell: CommonTableViewCell, textFieldShouldBeginEditing textField: UITextField) {
        guard let indexPath = commonCell.currentIndexPath else {
            return
        }
        switch indexPath.row  {
        case 3:
            textField.inputView = bankTotalPickView
            bankTotalPickView.didSelectRowWithValue = { [weak self](value1,value2) in
                guard let strongSelf = self else{return}
                textField.text = value2
                strongSelf.banktotalid = value1
                strongSelf.entbankInfCity = ""
                
            }
            
        case 4:
            guard banktotalid.count > 0 else{
                UIAlertView(title: "提示", message: "请您先选择开户行", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                return
            }
            textField.inputView = cityPickView
            cityPickView.didSelectRowWithValue = { [weak self](value1,value2) in
                guard let strongSelf = self else{return}
                textField.text = value1 + "  " + value2
                strongSelf.entbankInfCity = value2
                strongSelf.entbankInfProvince = value1
                strongSelf.bankBranchPickView.loadBankBranchData(lb_md5Parameter(parameter: ["banktotalid":strongSelf.banktotalid,
                                                                                             "city":strongSelf.entbankInfCity]),
                                                                 SuccessHandler: {[weak self]in
                                                                    guard let strongSelf = self else{return}
                                                                    textField.inputView = strongSelf.bankBranchPickView
                })
            }
        case 5:
            guard banktotalid.count > 0 else{
                UIAlertView(title: "提示", message: "请您先选择开户行", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                return
            }
            guard entbankInfCity.count > 0 else{
                UIAlertView(title: "提示", message: "请您重新选择开户行所在地", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
                return
            }
            bankBranchPickView.loadBankBranchData(lb_md5Parameter(parameter: ["banktotalid":banktotalid,"city":entbankInfCity]), SuccessHandler: {[weak self]in
                guard let strongSelf = self else{return}
                textField.inputView = strongSelf.bankBranchPickView
            })
            bankBranchPickView.didSelectRowWithValue = { (value1,value2) in
                textField.text =  value2
            }
        case 2:
            textField.inputView = nil
            textField.keyboardType = .phonePad
        default:
            textField.inputView = nil
            break
        }
        
    }
    
    override func commonCell(_ commonCell: CommonTableViewCell, arrowCellClick textField: UITextField) {
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
            strongSelf.cellContentDict[indexPath] = imageCell.images
            let phone =  ApplyModel.shareApplyModel.applySelfModel.stepOne.applyPhone
            
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
            if self?.applyType == .company {
                
                manager.uploadImg(objectKey: objecKey, image:newImage!,imageName:"licenseImage",bucketName: BucketName, endPoint: EndPoint,path:path){[weak self] (success) in
                    if success{
                        guard path.count > 0 else{return}
                        self?.applyStepModelCompany?.licenseImage = ApplyImage(image: image, path: path)
                        print(path)
                        SZHUDDismiss()

                    }else{
                        SZHUD("图片上传失败", type: .error, callBack: nil)
                        return                    }
                }
            }else if self?.applyType == .priv {
                let imgNames:[String] = ["bankFirstImg","bankSecondImg"]
                
                manager.uploadImg(objectKey: objecKey, image:newImage!,imageName:imgNames[tag],bucketName: BucketName, endPoint: EndPoint,path:path){[weak self] (success) in
                    if success{
                        guard path.count > 0 else{return}
                        switch tag {
                        case 0:
                            strongSelf.applyStepModelPriv?.bankFirstImg = ApplyImage(image: image, path: path)
                        case 1:
                            strongSelf.applyStepModelPriv?.bankSecondImg = ApplyImage(image: image, path: path)
                        default:break
                            
                        }
                        SZHUDDismiss()

                    }else{
                        SZHUD("图片上传失败", type: .error, callBack: nil)
                        return                    }
                }
            }
        }
    }
    
    override func didSelect(_ segmentedHeadView: SegmentedHeadView, index: Int) {
        if index == 0 { // 个体户
            self.applyType = .priv
            setupPrivateUI()
            setupPrivate()
            
        }else if index == 1 { // 公司
            self.applyType = .company
            setupCompanyUI()
            setupCompany()
        }
    }
    
    /// 个体户
    func setupPrivateUI() {
        cellItems = [[
            .image(.images(images: [UIImage( named: "debitCardPostive"),UIImage( named: "debitCardNegative")])),
            .common(.describe1(imgName:"",title: "(带*为必填)", subtitle: "")),
            .common(.input0(title: "*对私银行账号:", placeholder: "请输入银行账户")),
            .common(.input0(title: "*开户行:", placeholder: "请选择开户行")),
            .common(.input0(title: "*开户所在地:", placeholder: "请选择开户所在地")),
            .common(.input0(title: "*开户支行:", placeholder: "请选择卡户支行")),
            .common(.input0(title: "*银行开户名:", placeholder: "输入银行开户名")),
            .common(.input0(title: "*手机号码:", placeholder: "请输入开户行预留手机号码")),
            .button(.button(title: "完成", top: 0, bottom: 25))
            ]]
        
    }
    
    func setupPrivate() {
        guard let applyStepModel = applyStepModelPriv else {
            return
        }
        cellContentDict = [
            IndexPath(row: 2, section: 0): applyStepModel.bankCard,
            IndexPath(row: 3, section: 0): applyStepModel.bankCardID,
            IndexPath(row: 4, section: 0): applyStepModel.bankAddress,
            IndexPath(row: 5, section: 0): applyStepModel.branchBank,
            IndexPath(row: 6, section: 0): applyStepModel.bankName,
            IndexPath(row: 7, section: 0): applyStepModel.bankPhone,
        ]
    }
    
    /// 企业
    func setupCompanyUI() {
        cellItems = [[
            .image(.images(images: [UIImage( named: "0peningPermit")])),
            .common(.describe1(imgName:"",title: "(带*为必填)", subtitle: "")),
            .common(.input0(title: "对公银行账号:", placeholder: "请输入银行账户")),
            .common(.input0(title: "开户行:", placeholder:"请选择开户行")),
            .common(.input0(title: "开户所在地:", placeholder:"请选择开户所在地")),
            .common(.input0(title: "开户支行:", placeholder: "请选择卡户支行")),
            .common(.input0(title: "*银行开户名:", placeholder: "输入银行开户名")),
            .common(.input0(title: "*手机号码:", placeholder: "请输入开户行预留手机号码")),
            .button(.button(title: "提交", top: 30, bottom: 25))
            ]]
    }
    
    func setupCompany() {
        guard let applyStepModel = applyStepModelCompany else {
            return
        }
        cellContentDict = [
            IndexPath(row: 0, section: 0): [applyStepModel.licenseImage?.image],
            IndexPath(row: 2, section: 0): applyStepModel.bankCard,
            IndexPath(row: 3, section: 0): applyStepModel.bankCardID,
            IndexPath(row: 4, section: 0): applyStepModel.bankAddress,
            IndexPath(row: 5, section: 0): applyStepModel.branchBank,
            IndexPath(row: 6, section: 0): applyStepModel.bankName,
            IndexPath(row: 7, section: 0): applyStepModel.bankPhone,
            
        ]
    }
    
}
// MARK: dealToPickView
extension LBMerchantApplyBaseViewControllerTypeThree{
    
    func pickView(){
        
        bankTotalPickView.dissMissIndustryPickerViewAction = {
            self.view.endEditing(true)
        }
        
        cityPickView.dissMissIndustryPickerViewAction = {
            self.view.endEditing(true)
        }
        
        //        guard banktotalid.isEmpty && entbankInfCity.isEmpty else {
        //            bankBranchPickView.loadBankBranchData(["banktotalid":banktotalid,"city":entbankInfCity])
        //            return
        //        }
        bankBranchPickView.dissMissIndustryPickerViewAction = {
            self.view.endEditing(true)
            UIView.animate(withDuration: 0.75, animations: {
                self.bankBranchPickView.frame.origin.y = CGFloat(MAXFLOAT)
            })
        }
        
    }
}
// MARK:上传资料
extension LBMerchantApplyBaseViewControllerTypeThree:LBMerchantUploadInfoServer{
    
    
    func uploadInfoRequire(button:UIButton) {
        
        // 获取第一步资料
        let stepOneItem = ApplyModel.shareApplyModel.applySelfModel.stepOne
        let applyPhone =  stepOneItem.applyPhone ?? ""
        let applyName = stepOneItem.applyName ?? ""
        let name: String = stepOneItem.name ?? ""
        let account: String = stepOneItem.account ?? ""
        let idcardType: String = stepOneItem.idcardType ?? ""  //证件类型
        let IDNumber: String = stepOneItem.IDNumber ?? ""
        let validterm:String = stepOneItem.validterm ?? ""
        let email: String  = stepOneItem.email ?? ""
        let firstImagePath: String = stepOneItem.firstImage?.path ?? ""
        let secondImagePath: String = stepOneItem.secondImage?.path ?? ""
        //        let threeImagePath: String = stepOneItem.threeImage?.path ?? ""
        
        //获取第二步资料
        let stepSecondeItem = ApplyModel.shareApplyModel.applySelfModel.stepTwo
        
        let shopFrontPhotoImagePath:String = stepSecondeItem.shopFrontPhotoImage?.path ?? ""
        let businessLicenseImagePath: String = stepSecondeItem.businessLicenseImage?.path ?? ""
        let checkStandPicImagePath: String = stepSecondeItem.checkStandPic?.path ?? ""
        let storePicImagePath: String = stepSecondeItem.storePic?.path ?? ""
        
        
        let merchantAbbreviation: String = stepSecondeItem.merchantAbbreviation ?? ""
        let businessLicenseNum: String = stepSecondeItem.businessLicenseNum ?? ""
        let organizationCodeNum: String = stepSecondeItem.organizationCodeNum ?? ""
        let enterpraiseLicenseTerm: String = stepSecondeItem.enterpraiseLicenseTerm ?? ""
        
        let enterpriseName: String = stepSecondeItem.enterpriseName ?? ""
        let companyProvince: String = stepSecondeItem.companyProvince ?? ""
        let companyCity: String = stepSecondeItem.companyCity ?? ""
        let companAddressDetails: String = stepSecondeItem.companyAddressDetails ?? ""
        let companyType: String = stepSecondeItem.companyType ?? ""
        
        var parameters:[String:Any] = [
            
            "mer_id":LBKeychain.get(CURRENT_MERC_ID),  //会员号
            "applyPhone":applyPhone,        //推荐人手机号
            "applyName":applyName,          //推荐人姓名
            "name" :name,                   // 负责人姓名
            "phone":account,                // 负责人手机号
            "idcardType":idcardType,        //身份证类型
            "idcard":IDNumber,              //负责人身份证号
            "email":email,                  //邮箱
            "validterm":validterm,          //身份证有效期
            "idcardone" :firstImagePath,    //正面身份证
            "idcardtwo":secondImagePath,    //反面身份证
//            "enterpriseInf.handidcardpic" :"123",//手持身份证
            
            "gatepic" :shopFrontPhotoImagePath,   //店铺门头照
            "busregimg":businessLicenseImagePath, //营业执照
            "storePic":storePicImagePath,         //店内照
            "checkStandPic":checkStandPicImagePath, //收营台  前台
            
            "entabb":merchantAbbreviation,        // 商户简称
            "entname":enterpriseName,             //企业名称
            
            "busregnum"  :businessLicenseNum,     //统一社会信用代码
            "enterpraiseLicenseTerm"  :enterpraiseLicenseTerm,     //营业执照有效期
//            "orgcode" :organizationCodeNum,
            "province":companyProvince,              //公司所在省
            "city":companyCity,                      //公司所在市
            "details":companAddressDetails,          //公司详细地址
            "industryid":companyType,//行业类别
            
            
        ]
        // 瞎传值，无意义 （后台暂无更新按就的进件）
//        parameters["enterpriseInf.openlicense"] = "enterpriseInf.orgcodeimg"
//        parameters["enterpriseInf.orgcodeimg"] = "enterpriseInf.orgcodeimg"
        
        // 第三步资料
        let stepThirItem = ApplyModel.shareApplyModel.applySelfModel.stepThree
        switch self.applyType {
        case .priv:
            
            let bankFirstImgPath = stepThirItem.priv.bankFirstImg?.path ?? ""
            let bankSecondImgPath = stepThirItem.priv.bankSecondImg?.path ?? ""
            
            let bankCard = stepThirItem.priv.bankCard ?? ""
            let bankCardID = stepThirItem.priv.bankCardID
            let bankPhone  = stepThirItem.priv.bankPhone
            let branchBank = stepThirItem.priv.branchBank
            let bankUserName  = stepThirItem.priv.bankName
            
            parameters["balancecardone"] = bankFirstImgPath   //银行卡正面
            parameters["balancecardtwo"] = bankSecondImgPath  //银行卡反面
            
            // 后台没分个体与企业校验 暂时瞎传
//            parameters["enterpriseInf.openlicense"]  = "licenseImagePath"
            
            parameters["priaccount"] = bankCard          //对私银行账号
            parameters["opnbank"] = bankCardID           //开户行
            parameters["banktotalid"] = banktotalid                 //开户行id
            parameters["ponaccname"] = branchBank        //开户支行
            parameters["bankProvince"] = entbankInfProvince  //开户银行所在省
            parameters["bankCity"] = entbankInfCity          //开户银行所在市
            parameters["cardphone"] = bankPhone          //银行预留手机号码
            parameters["cardtype"] = "\(1)"              //银行卡类型
            parameters["accountName"] = bankUserName            //持卡人姓名
            
            
        case .company:
            
            let licenseImagePath = stepThirItem.company.licenseImage?.path ?? ""
            let bankCard = stepThirItem.company.bankCard ?? ""
            let bankCardID = stepThirItem.company.bankCardID
            let bankUserName  = stepThirItem.company.bankName
            let bankPhone = stepThirItem.company.bankPhone
            let branchBank = stepThirItem.company.branchBank
            
            // 后台没分个体与企业校验 暂时瞎传
            parameters["balancecardone"] = "bankFirstImgPath"
            parameters["balancecardtwo"] = "bankSecondImgPath"
            
            parameters["openlicense"]  = licenseImagePath  //开户许可证正面照片
            parameters["comaccnum"] = bankCard                //对公银行账号
            parameters["opnbank"] = bankCardID               //开户行
            parameters["accountName"] = bankUserName                 //持卡人姓名
            parameters["banktotalid"] = banktotalid                      //开户行id
            parameters["ponaccname"] = branchBank             //开户支行
            parameters["bankProvince"] = entbankInfProvince       //银行卡所在省
            parameters["bankCity"] = entbankInfCity               //银行卡所在市
            parameters["cardphone"] = bankPhone               //银行预留手机号
            parameters["cardtype"] = "\(0)"                   //银行卡类型
            
        }
        button.isEnabled = false
        print(parameters);
        
        func showMessage(title: String, message: String) {
            UIAlertView(title: title,
                        message:message,
                        delegate: nil,
                        cancelButtonTitle: nil,
                        otherButtonTitles: "确定").show()
        }
        
        SNRequestBool(requestType: API.insertMerchant(paremeter: parameters)).subscribe(onNext: {[unowned self] (result) in
            switch result{
            case .bool(_):
                let viewController = LBMerchantApplyFinishViewController()
                self.navigationController?.pushViewController(viewController, animated: true)
                button.isEnabled = true
                ApplyModelTool.removeModel()
                SZHUD("上次成功", type: .info, callBack: nil)
            case .fail(let res):
                showMessage(title:"温馨提示" , message: res.msg!)
                button.isEnabled = true
            default:
                showMessage(title:"温馨提示" , message: "请求错误")
                self.navigationController?.popToRootViewController(animated: true)
                button.isEnabled = true
            }
        }).disposed(by: disposeBag)
        
    }
}



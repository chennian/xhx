//
//  ApplyUserModel.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//
import UIKit


enum applyType{
    case selfApply
    case otherApply
}
protocol ApplyTypeOneProtocol {
    
    var idcardType : String? { get set  }// 身份证类型   新增
    
    
    /// 我的信息
    var applyPhone:String?{get set}// 申请人账号
    var applyName:String?{get set}// 申请人姓名
    /// 商户负责人信息
    var name: String? { get set }// 负责人姓名
    var account: String? { get set  }// 注册手机号
    var IDNumber: String? { get set  }// 身份证号
    var validterm:String?{get set}// 身份证有效期
    var email: String? { get set  }// 邮箱
    var firstImage: ApplyImage? { get set  }// 身份证正面
    var secondImage: ApplyImage? { get set  }// 身份证反面
    //    var threeImage:ApplyImage?{get set}// 手持身份证
}

protocol ApplyTypeTwoProtocol {
    
    var shopFrontPhotoImage: ApplyImage? { get set  }// 门头照
    var businessLicenseImage: ApplyImage? { get set  }// 营业执照
    
    var checkStandPic: ApplyImage? { get set  }// 前台照片
    var storePic: ApplyImage? { get set  }// 前台照片
    
    
    var enterpraiseLicenseTerm : String? { get set  }// 营业执照有效期   新增
    
    
    var merchantAbbreviation:String?{get set} // 商户简称
    var enterpriseName: String? { get set  }// 企业名称
    var businessLicenseNum:String?{get set}// 营业执照
    var organizationCodeNum:String?{get set}// 组织机构代码
    var companyAddress: String? { get set  }// 公司地址
    var companyProvince:String?{get set}// 公司所在省
    var companyCity:String?{get set}// 公司所在市
    var companyAddressDetails:String?{get set}//公司在地详细地址
    var companyFirstLevel:String?{get set}// 行业类别一级
    var companySecondLevel:String?{get set}// 行业类别二级
    var companyType: String? { get set  }//行业类别id
}

protocol ApplyTypeThreeProtocol {
    var bankCard: String? { get set  }// 银行卡号
    var bankCardID: String? { get set  }// 开户行
    var bankAddress: String? { get set  }// 开户行所在地
    var branchBank: String? { get set  }// 开户支行
    var bankName: String? { get set  }// 银行开户名
    var bankPhone:String?{get set}// 银行预留手机号
    var bankFirstImg:ApplyImage?{get set}// 结算卡正面
    var bankSecondImg:ApplyImage?{get set}// 结算卡反面
    var licenseImage: ApplyImage? { get set  }// 开户许可证
}

extension ApplyTypeThreeProtocol {
    
    var bankFirstImg: ApplyImage? {
        get {
            return self.bankFirstImg
        }
        set {
            bankFirstImg = newValue
        }
    }
    var bankSecondImg: ApplyImage? {
        get {
            return self.bankSecondImg
        }
        set {
            bankSecondImg = newValue
        }
    }
    var licenseImage: ApplyImage? {
        get {
            return self.licenseImage
        }
        set {
            licenseImage = newValue
        }
    }
}

class ApplyModelTool {
    private static let component = "ApplyModel.LittleBlackBear"
    
    private static var path: String? {
        get {
            return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/").appending(ApplyModelTool.component)
        }
    }

    
    static func save(model: ApplyModel) {
        guard let path = path else {
            return
        }
        let backgoundQuene = DispatchQueue(label: "LittleBlackBear.bak")
        backgoundQuene.async {
            NSKeyedArchiver.archiveRootObject(model, toFile: path)
        }
    }
    
    static func readModel() -> ApplyModel {
        var model = ApplyModel()
        guard let path = path else {
            return model
        }
        let backgoundQuene = DispatchQueue(label: "LittleBlackBear.bak")
        backgoundQuene.async {
            model = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? ApplyModel ?? model
        }
        
        return model
    }
    
    static func removeModel(){
        guard path != nil , FileManager.default.fileExists(atPath: path!) else {
            return
        }
        print(path!)
        do {
            
//            try FileManager.default.removeItem(atPath: path!)
            
            let stepOneItem = ApplyModel.shareApplyModel.applySelfModel.stepOne
            stepOneItem.idcardType = nil
            stepOneItem.applyPhone = nil
            stepOneItem.applyName  = nil
            stepOneItem.name = nil
            stepOneItem.account = nil
            stepOneItem.IDNumber = nil
            stepOneItem.validterm = nil
            stepOneItem.email = nil
            stepOneItem.firstImage = nil
            stepOneItem.secondImage = nil
           
            let stepSecondeItem = ApplyModel.shareApplyModel.applySelfModel.stepTwo
            
            stepSecondeItem.companyFirstLevel = nil
            stepSecondeItem.companySecondLevel = nil
            stepSecondeItem.companyAddressDetails = nil
            stepSecondeItem.shopFrontPhotoImage = nil
            stepSecondeItem.businessLicenseImage = nil
            stepSecondeItem.checkStandPic = nil
            stepSecondeItem.storePic = nil
            stepSecondeItem.merchantAbbreviation = nil
            stepSecondeItem.businessLicenseNum = nil
            stepSecondeItem.organizationCodeNum = nil
            stepSecondeItem.enterpraiseLicenseTerm = nil   //新增    营业执照有效期
            stepSecondeItem.companyName = nil
            stepSecondeItem.enterpriseName = nil
            stepSecondeItem.companyAddress = nil
            stepSecondeItem.companyProvince = nil
            stepSecondeItem.companyCity = nil
            stepSecondeItem.companyType = nil
            
            let stepThirItem = ApplyModel.shareApplyModel.applySelfModel.stepThree
            
            stepThirItem.company.bankAddress = nil
            stepThirItem.company.bankCard = nil
            stepThirItem.company.bankName = nil
            stepThirItem.company.bankCardID = nil
            stepThirItem.company.bankPhone = nil
            stepThirItem.company.branchBank = nil
            stepThirItem.company.image = nil
            stepThirItem.company.licenseImage = nil
          
            stepThirItem.priv.bankAddress = nil
            stepThirItem.priv.bankCard = nil
            stepThirItem.priv.branchBank = nil
            stepThirItem.priv.bankCardID = nil
            stepThirItem.priv.bankName = nil
            stepThirItem.priv.bankPhone = nil
            stepThirItem.priv.bankSecondImg = nil
            stepThirItem.priv.bankSecondImg = nil
            
            save(model: ApplyModel.shareApplyModel)
            
            
        } catch let error {
            Print(error)
        }
    }
    
    
}



class ApplyModel:NSObject, NSCoding {
    private static let applySelfModelKey = "applySelfModelKey"
    
    static let shareApplyModel = ApplyModelTool.readModel()
    
    
    var applySelfModel = ApplySelfModel()
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let applySelfModel = aDecoder.decodeObject(forKey: ApplyModel.applySelfModelKey) as? ApplySelfModel else {
            return nil
        }
        
        self.applySelfModel = applySelfModel
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(applySelfModel, forKey: ApplyModel.applySelfModelKey)
    }
    
}


class ApplySelfModel: NSObject, NSCoding {
    
    var stepOne = StepOne()
    var stepTwo = StepTwo()
    var stepThree = StepThree()
    
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        guard let stepOne = aDecoder.decodeObject(forKey: "stepOne") as? StepOne else {
            return nil
        }
        guard let stepTwo = aDecoder.decodeObject(forKey: "stepTwo") as? StepTwo  else {
            return nil
        }
        guard let stepThree = aDecoder.decodeObject(forKey: "stepThree") as? StepThree  else {
            return nil
        }
        self.stepOne = stepOne
        self.stepTwo = stepTwo
        self.stepThree = stepThree
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(stepOne, forKey: "stepOne")
        aCoder.encode(stepTwo, forKey: "stepTwo")
        aCoder.encode(stepThree, forKey: "stepThree")
    }
}





class StepOne: NSObject, ApplyTypeOneProtocol, NSCoding {
    
    var idcardType:String?  //新加身份证类型
    
    
    var applyPhone: String?
    var applyName: String?
    
    var name: String?
    var account: String?
    var IDNumber: String?
    var validterm: String?
    
    var email: String?
    var firstImage: ApplyImage?
    var secondImage: ApplyImage?
    //    var threeImage: ApplyImage?z
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        applyPhone = aDecoder.decodeObject(forKey: "applyPhone") as? String
        applyName = aDecoder.decodeObject(forKey: "applyName") as? String
        
        name = aDecoder.decodeObject(forKey: "name") as? String
        account = aDecoder.decodeObject(forKey: "account") as? String
        idcardType = aDecoder.decodeObject(forKey: "idcardType") as? String
        IDNumber = aDecoder.decodeObject(forKey: "IDNumber") as? String
        validterm = aDecoder.decodeObject(forKey: "validterm") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        firstImage = aDecoder.decodeObject(forKey: "firstImage") as? ApplyImage
        secondImage = aDecoder.decodeObject(forKey: "secondImage") as? ApplyImage
        //        threeImage = aDecoder.decodeObject(forKey: "threeImage") as? ApplyImage
        
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(applyPhone, forKey: "applyPhone")
        aCoder.encode(applyName, forKey: "applyName")
        
        aCoder.encode(name, forKey: "name")
        aCoder.encode(account, forKey: "account")
        aCoder.encode(idcardType, forKey: "idcardType")
        aCoder.encode(IDNumber, forKey: "IDNumber")
        aCoder.encode(validterm, forKey: "validterm")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(firstImage, forKey: "firstImage")
        aCoder.encode(secondImage, forKey: "secondImage")
        //        aCoder.encode(threeImage, forKey: "threeImage")
        
        
    }
}


class StepTwo: NSObject, NSCoding, ApplyTypeTwoProtocol {
    
    var companyFirstLevel: String?
    var companySecondLevel: String?
    var companyAddressDetails: String?
    var shopFrontPhotoImage: ApplyImage?
    var businessLicenseImage: ApplyImage?
    var checkStandPic: ApplyImage?
    var storePic: ApplyImage?
    var merchantAbbreviation: String?
    var businessLicenseNum: String?
    var organizationCodeNum: String?
    var enterpraiseLicenseTerm: String?   //新增    营业执照有效期
    var companyName: String?
    var enterpriseName: String?
    var companyAddress: String?
    var companyProvince: String?
    var companyCity: String?
    var companyType: String?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        shopFrontPhotoImage = aDecoder.decodeObject(forKey: "shopFrontPhotoImage") as? ApplyImage
        businessLicenseImage = aDecoder.decodeObject(forKey: "businessLicenseImage") as? ApplyImage
        businessLicenseImage = aDecoder.decodeObject(forKey: "checkStandPic") as? ApplyImage
        storePic = aDecoder.decodeObject(forKey: "storePic") as? ApplyImage
        
        merchantAbbreviation = aDecoder.decodeObject(forKey: "merchantAbbreviation") as? String
        businessLicenseNum = aDecoder.decodeObject(forKey: "businessLicenseNum") as? String
        organizationCodeNum = aDecoder.decodeObject(forKey: "organizationCodeNum") as? String
        enterpraiseLicenseTerm = aDecoder.decodeObject(forKey: "enterpraiseLicenseTerm") as? String
        
        companyName = aDecoder.decodeObject(forKey: "companyName") as? String
        enterpriseName = aDecoder.decodeObject(forKey: "enterpriseName") as? String
        
        companyAddress = aDecoder.decodeObject(forKey: "companyAddress") as? String
        companyProvince = aDecoder.decodeObject(forKey: "companyProvince") as? String
        companyCity = aDecoder.decodeObject(forKey: "companyCity") as? String
        companyAddressDetails = aDecoder.decodeObject(forKey: "companyAddressDetails") as? String
        
        companyFirstLevel = aDecoder.decodeObject(forKey: "companyFirstLevel") as? String
        companySecondLevel = aDecoder.decodeObject(forKey: "companyFirstLevel") as? String
        companyType = aDecoder.decodeObject(forKey: "companyType") as? String
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(shopFrontPhotoImage, forKey: "shopFrontPhotoImage")
        aCoder.encode(businessLicenseImage, forKey: "businessLicenseImage")
        aCoder.encode(businessLicenseImage, forKey: "checkStandPic")
        aCoder.encode(businessLicenseImage, forKey: "storePic")
        
        
        aCoder.encode(merchantAbbreviation, forKey: "merchantAbbreviation")
        aCoder.encode(businessLicenseNum, forKey: "businessLicenseNum")
        aCoder.encode(organizationCodeNum, forKey: "organizationCodeNum")
        aCoder.encode(enterpraiseLicenseTerm, forKey: "enterpraiseLicenseTerm")
        
        
        aCoder.encode(companyName, forKey: "companyName")
        aCoder.encode(enterpriseName, forKey: "enterpriseName")
        
        aCoder.encode(companyAddress, forKey: "companyAddress")
        aCoder.encode(companyProvince, forKey: "companyProvince")
        aCoder.encode(companyCity, forKey: "companyCity")
        aCoder.encode(companyAddressDetails, forKey: "companyAddressDetails")
        
        
        aCoder.encode(companyType, forKey: "companyType")
        aCoder.encode(companyFirstLevel, forKey: "companyFirstLevel")
        aCoder.encode(companySecondLevel, forKey: "companySecondLevel")
        
    }
}

class StepThree: NSObject, NSCoding {
    
    @objc(_TtCC15LittleBlackBear9StepThree7Private)class Private: NSObject, NSCoding, ApplyTypeThreeProtocol {
        
        var bankName: String?
        
        var bankFirstImg: ApplyImage?
        var bankSecondImg: ApplyImage?
        
        var bankCard: String?
        var bankCardID: String?
        var bankPhone: String?
        var bankAddress: String?
        var branchBank: String?
        
        
        override init() {
            super.init()
        }
        
        required init?(coder aDecoder: NSCoder) {
            
            bankFirstImg = aDecoder.decodeObject(forKey: "bankFirstImg") as? ApplyImage
            bankSecondImg = aDecoder.decodeObject(forKey: "bankSecondImg") as? ApplyImage
            bankCard = aDecoder.decodeObject(forKey: "bankCard") as? String
            bankCardID = aDecoder.decodeObject(forKey: "bankCardID") as? String
            bankPhone = aDecoder.decodeObject(forKey: "bankPhone") as? String
            bankAddress = aDecoder.decodeObject(forKey: "bankAddress") as? String
            branchBank = aDecoder.decodeObject(forKey: "branchBank") as? String
            bankName = aDecoder.decodeObject(forKey: "bankName") as? String
            
        }
        
        func encode(with aCoder: NSCoder) {
            aCoder.encode(bankFirstImg, forKey: "bankFirstImg")
            aCoder.encode(bankSecondImg, forKey: "bankSecondImg")
            aCoder.encode(bankCard, forKey: "bankCard")
            aCoder.encode(bankCardID, forKey: "bankCardID")
            aCoder.encode(bankAddress, forKey: "bankAddress")
            aCoder.encode(branchBank, forKey: "branchBank")
            aCoder.encode(bankPhone, forKey: "bankPhone")
            aCoder.encode(bankName, forKey: "bankName")
            
        }
    }
    
    @objc(_TtCC15LittleBlackBear9StepThree7Company)class Company: NSObject, NSCoding, ApplyTypeThreeProtocol {
        var bankName: String?
        
        var bankAddress: String?
        
        var branchBank: String?
        
        var bankPhone: String?
        var licenseImage: ApplyImage?
        
        var bankCard: String?
        var bankCardID: String?
        var image: ApplyImage?
        
        override init() {
            super.init()
        }
        
        required init?(coder aDecoder: NSCoder) {
            licenseImage = aDecoder.decodeObject(forKey: "licenseImage") as? ApplyImage
            bankCard = aDecoder.decodeObject(forKey: "bankCard") as? String
            bankCardID = aDecoder.decodeObject(forKey: "bankCardID") as? String
            bankPhone = aDecoder.decodeObject(forKey: "bankPhone") as? String
            bankAddress = aDecoder.decodeObject(forKey: "bankAddress") as? String
            branchBank = aDecoder.decodeObject(forKey: "branchBank") as? String
            bankName = aDecoder.decodeObject(forKey: "bankName") as? String
            
        }
        
        func encode(with aCoder: NSCoder) {
            aCoder.encode(licenseImage, forKey: "licenseImage")
            aCoder.encode(bankCard, forKey: "bankCard")
            aCoder.encode(bankCardID, forKey: "bankCardID")
            aCoder.encode(bankAddress, forKey: "bankAddress")
            aCoder.encode(branchBank, forKey: "branchBank")
            aCoder.encode(bankPhone, forKey: "bankPhone")
            aCoder.encode(bankName, forKey: "bankName")
        }
    }
    
    var priv = Private()
    var company = Company()
    
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        guard let priv = aDecoder.decodeObject(forKey: "priv") as? Private else {
            return nil
        }
        guard let company = aDecoder.decodeObject(forKey: "company") as? Company else {
            return nil
        }
        self.priv = priv
        self.company = company
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(priv, forKey: "priv")
        aCoder.encode(company, forKey: "company")
    }
}
class ApplyImage: NSObject, NSCoding {
    var image: UIImage
    var path: String
    init(image: UIImage, path: String) {
        self.image = image
        self.path = path
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        image = aDecoder.decodeObject(forKey: "image") as! UIImage
        path = aDecoder.decodeObject(forKey: "path") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey: "image")
        aCoder.encode(path, forKey: "path")
    }
}



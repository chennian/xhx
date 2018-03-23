
//  LBRequestUrlType.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/17.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
protocol LBURL {
	static var baseUrl:String {get}
}
struct localhost:LBURL {
	static var baseUrl: String = "http://localhost/java/"
}
struct develope:LBURL {
//    static var baseUrl: String = "http://wzh.linuxnb.com/rest/"
    static var baseUrl: String = "http://java.linuxnb.com/rest/"

}
struct product:LBURL {
    static var baseUrl: String = "http://www.xiaoheixiong.net/rest/"
}
//商家进件新增
struct product1:LBURL {
    static var baseUrl: String = "http://www.xiaoheixiong.net/rest/"
}
struct product2:LBURL {
    static var baseUrl: String = "http://api.xiaoheixiong.net/"
}
/// H5
struct H5Develope:LBURL {
	static var baseUrl: String = "http://www.beixiang123.com/"
}
struct H5_product:LBURL {
	//	static var baseUrl: String = "http://www.beixiang123.com/"
	static var baseUrl: String = "http://bx.szbeixiang.com/"
	
}
enum LBRequestUrlType:String{
    
    //新增团团
    case newUpdateGroup = "api.xiaoheixiong.net/activity/addCoupon"
    //新增秒秒
    case newUpdateSeckill = "api.xiaoheixiong.net/activity/addKill"
    
    

	/// 手机号注册
	case mobileRegister = "xhx/register/mobileRegister"
    ///  获取验证码
	case sendRegValiMsgCode = "xhx/register/sendRegValiMsgCode"
    ///手机号或微信一键登录
	case phone_wechat_login =  "xhx/login/userLogin"
    
    /// 微信首次登录绑定手机号
    case bindWeixinMobile = "xhx/register/bindWeixinMobile"
    /// 微信授权登录
    case wxLoginURL = "https://api.weixin.qq.com/sns/oauth2/access_token"
    /// 获取新用户信息
    case wxInfoUrl  = "https://api.weixin.qq.com/sns/userinfo"
    ///刷新wxtoken
    case wxRefreToken = "https://api.weixin.qq.com/sns/oauth2/refresh_token"
    
	///找回登录密码
	case findLoginPwdCommit = "xhx/pwdPro/findLoginPwdCommit"
    /// 修改登录密码
	case modLoginPwdCommit  = "xhx/pwdPro/modLoginPwdCommit"
	/// 是否已经设置支付密码
	case isSetPayPassword = "xhx/pwdPro/selectPayPassIsSet"
    /// 设置支付密码
    case setPayPassword = "xhx/pwdPro/setPayPass"
    /// 找回支付密码
    case findPayPassword = "xhx/pwdPro/findPayPass"
    /// 修改支付密码
    case updatePayPass = "xhx/pwdPro/updatePayPass"

    /// 生活圈  首页
    case mainIndex = "xhx/merIndex/mainIndex"
    /// 商户详情
    case merIntroduce = "xhx/merIndex/merIntroduce"
    /// 商家详情 评价
	case saveEvaluationInfo = "xhx/evaluationInfo/saveEvaluationInfo"
    /// 商家详情 评论查询
	case getEvaluationList = "xhx/evaluationInfo/getEvaluationList"
    /// 商家详情 关注
    case favourite = "favourite/save"
    /// 商家详情 查询收藏
    case favourite_select = "favourite/select"
    /// 商家详情 删除收藏
    case favourite_delete =  "favourite/delete"
    /// 商家详情 商品
    case goods = "xhx/goods/list"
    /// 查询商品分类
    case goods_type = "xhx/goods/selectType"
    
    /// 秒秒 更多卡券
    case getMerMarkList = "xhx/merIndex/getMerMarkList"
    /// 卡券详情
    case getMyMarkCardDtl = "xhx/merMarkActi/getMyMarkCardDtl"
    /// 获取我领取的卡劵
    case userGetMerMark = "xhx/merMarkActi/userGetMerMark"
    /// 游戏卡券
    case getGameCoupon = "xhx/merMarkActi/userGetGameMerMark"
    
	/// 头条
	case headlineInfo = "xhx/headlineInfo/getHeadlineList"
    /// 生活圈  首页
    case publishHead = "headline/pushHeadLine"
    /// 头条点赞
	case praiseHeadlineInfo = "xhx/headlineInfo/praiseHeadlineInfo"
    
	///  商家进件 快捷注册
	case merchantApply_qrmerInf_insert      = "qrmerInf/insert"
    ///  商家进件 普通注册
	case merchantApply_qrmerInf_quickInsert = "qrmerInf/quickInsert"
	
    /// 银行分行
	case merRecBankBranch = "merRecBankBranch/getBankBranch"
    /// 银行总行
	case merRecBankTotal  = "merRecBankTotal/selectAll"
    /// 行业类别
    case industryType_selectAll = "industryType/getAll"
	/// 获取银行地址
    case getBankAddress = "common/getDicAreaByParentCode"
    /// 上传图片
	case shopPicUpload  = "pic/shopPicUpload"
    
    /// 商户位置
    case searchLsbCloudMer = "xhx/merIndex/searchLsbCloudMer"
    /// 地图红包位置
    case mapRedPacket =  "redPacket/getAlllRedPacket"
    /// 获取地图红包
    case httpGetAllRedPacket = "redPacket/httpGetAllRedPacket"
    ///打开地图红包
    case openRedPacket = "redPacket/openRedPacket"
    
    /// 用户信息查询
    case userInfoDetail = "xhx/user/userInfoDtl"
    /// 快捷实名认证
    case userFastAuth = "xhx/auth/userFastAuth"
    
    /// 上传用户头像
    case updateHeadImg = "xhx/user/updateHeadImg"
    /// 收款码
	case payQRCode =  "xhx/merQr/gen"
    /// 分享码
	case downloadQRCode = "xhx/merQr/drowDownloadIMG"
    /// 变更银行卡
    case modifyWithDrawCard = "xhx/withdrawBank/change"
    case activity = "xhx/withdrawBank"

    
}
enum loginType:String{
	case phone = "phone"
	case wechat = "wechat"

}



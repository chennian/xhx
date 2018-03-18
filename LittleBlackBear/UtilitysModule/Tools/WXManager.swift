//
//  WXManager.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/5/7.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
@objc protocol WXApiManagerDelegate:NSObjectProtocol{
	/// 分享授权成功
	func wxSendAuthSucceed(_ code:String)
	/// 登录授权成功
	func wxLoginAuthSucceed(_ code:String)
	func wxAuthDenied()
	func wxAuthCancel()
	/// 支付成功
	@objc optional func wxPaySucceed(_ code:String)
	
}
final class WXManager: NSObject {
	
	fileprivate weak var delegate:WXApiManagerDelegate?
	
	fileprivate let kWXNotInstallErrorTitle:String = "您还没有安装微信，不能使用微信分享功能"
	
	fileprivate static let sharedInstance = WXManager()
	class var shareManager:WXManager{
		return sharedInstance
	}
	fileprivate override init() {
		
    }
	///注册微信
	func registWeChat()  {
		let success = WXApi.registerApp(WX_APP_ID)
		guard success else {
			Print("注册微信失败")
			return
		}
		Print("注册微信成功")	
	}
    // 是否已经安装微信
   open static let isWXAppInstalled:Bool = WXApi.isWXAppInstalled()
   
	
/**
 *  发送微信验证请求.
 *
 *  @restrict 该方法支持未安装微信的用户.
 *
 *  @param viewController 发起验证的VC
 *  @param delegate       处理验证结果的代理
 */
	func sendAuthRequestWithController(_ viewController:UIViewController,_ delegate:WXApiManagerDelegate)  {
		let req = SendAuthReq()
		req.scope = "snsapi_userinfo"
		req.state = "LittterBlackBaer"
		self.delegate = delegate
		WXApi.sendAuthReq(req, viewController: viewController, delegate: self)
	}

 /**
 *  发送链接到微信.
 *
 *  @restrict 该方法要求用户一定要安装微信.
 *
 *  @param urlString 链接的Url
 *  @param title     链接的Title
 *  @param desc      链接的描述
 *  @param scene     发送的场景，分为朋友圈, 会话和收藏
 *
 *  @return 发送成功返回YES
 */
	func sendLinkContent(_ urlString:String,_ title:String,_ desc:String, _ scene:WXScene)-> Bool {
		guard WXApi.isWXAppInstalled() else {
			return false
		}
		let ext:WXWebpageObject  = WXWebpageObject()
		ext.webpageUrl = urlString
		let massage = WXMediaMessage()
		massage.title = title
		massage.description = desc
		massage.mediaTagName = "WECHAT_TAG_JUMP_SHOWRANK"
		massage.thumbData = UIImagePNGRepresentation(UIImage(named: "getheadimg")!)
		massage.mediaObject = ext

		let req = SendMessageToWXReq()
		req.message = massage
		req.bText = false
		req.scene = Int32(scene.rawValue)
		return WXApi.send(req)
		
	}
	func sendImageContent(_ image:UIImage,_ scene:WXScene) -> Bool{
		Print(image)
		Print(scene)
		guard WXApi.isWXAppInstalled() else {
			return false
		}
		let Message = WXMediaMessage()

		let req = SendMessageToWXReq()
		
		let ext:WXImageObject  = WXImageObject()
		ext.imageData = UIImagePNGRepresentation(image)
		
		Message.mediaObject = ext
		Message.setThumbImage(UIImage(named: "getheadimg"))

		req.message = Message
		req.bText = false
		req.scene = Int32(scene.rawValue)
		return WXApi.send(req)
	}
/**
 *  发送文件到微信.
 *
 *  @restrict 该方法要求用户一定要安装微信.
 *
 *  @param fileData   文件的数据
 *  @param extension  文件扩展名
 *  @param title      文件的Title
 *  @param desc       文件的描述
 *  @param thumbImage 文件缩略图
 *  @param scene      发送的场景，分为朋友圈, 会话和收藏
 *
 *  @return 发送成功返回YES
 */
	func sendFileData(_ fileData:Data ,_ fileExtension:String,_ title:String,_ desc:String,_ thumbImage:UIImage,_ scene: WXScene) -> Bool {
	
		guard WXApi.isWXAppInstalled() else {
			return false
		}
		
		let ext:WXFileObject  = WXFileObject()
		ext.fileData = fileData
		ext.fileExtension = fileExtension
		
		let massage = WXMediaMessage()
		massage.title = title
		massage.description = desc
		massage.mediaObject = ext
		massage.setThumbImage(thumbImage)
		
		let req = SendMessageToWXReq()
		req.message = massage
		req.bText = false
		req.scene = Int32(scene.rawValue)
		return WXApi.send(req)
		
	}
	
}
extension WXManager:WXApiDelegate{
	func onReq(_ req: BaseReq!) {
		
	}
	func onResp(_ resp: BaseResp!) {
		Print(resp)
	
		if let _:SendMessageToWXResp = resp as? SendMessageToWXResp {
			switch resp.errCode {
			case 0://WXSuccess/**< 成功    */
				self.delegate?.wxSendAuthSucceed("成功")
			case -4:// WXErrCodeAuthDeny授权失败
				self.delegate?.wxAuthDenied()
			case -2://WXErrCodeUserCancel用户取消病点击返回
				self.delegate?.wxAuthCancel()
			default:
				break
			}
		}
		if let authResp:SendAuthResp = resp as? SendAuthResp {
			
			switch resp.errCode {
			case 0://WXSuccess/**< 成功    */
				self.delegate?.wxLoginAuthSucceed(authResp.code)
			case -4:// WXErrCodeAuthDeny授权失败
				self.delegate?.wxAuthDenied()
			case -2://WXErrCodeUserCancel用户取消病点击返回
				self.delegate?.wxAuthCancel()
			default:
				break
			}
			Print(resp.errCode)
			Print(authResp.state)
		}
		
		if let payResp:PayResp = resp as? PayResp {
			switch payResp.errCode {
			case 0://WXSuccess/**< 成功    */
				Print("支付成功")
			default:
				Print("支付失败")
			}
		}
	}
}

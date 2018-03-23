
//
//  LBHttpManager.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/17.
//  Copyright © 2017年 蘇崢. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

typealias JSONResponse = (JSON)->()
typealias HTTP_Method = HTTPMethod
typealias HTTP_Headers = [String: String]

class LBHttpManager {
    
	static let shareInstance = LBHttpManager()
	fileprivate let sessionManager:SessionManager
	init() {
        
		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest = 25
		sessionManager = Alamofire.SessionManager(configuration: configuration)
	}
    
}
extension LBHttpManager{
	
	class func request(_ url: String, method: HTTP_Method, parameters: [String: Any]? = nil,  headers: HTTP_Headers? = nil, success: @escaping JSONResponse, failure: @escaping (Error) -> ()) {
		
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
		LBHttpManager.shareInstance.sessionManager.request(url, method: method, parameters: parameters,headers: headers).responseJSON { (response: DataResponse) in
            
			UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
			switch response.result {
                
			case .success(let value):
                
				success(JSON(value))
                
			case .failure(let error):
                
                let errot_text = error.localizedDescription
                if errot_text == "请求超时。"||errot_text == "网络连接已中断" {
                    UIAlertView(title: nil, message: errot_text, delegate: nil, cancelButtonTitle: "确定").show()
                }
                
                Print(error.localizedDescription)
				failure(error)
			}
		}
	}
	/// 单图上传
	class func uploadSingleImage(_ uploadIImageURLString:String,_ image:UIImage, _ imgName:String,_ parameters:[String:String]? = nil ,success: @escaping JSONResponse, failure: @escaping (Error) ->Void){
        var imageData = UIImageJPEGRepresentation(image, 1.0)
        if (imageData?.count)! > 200 * 1024 {
            
            if (imageData?.count)! > 1024*1024 {
                imageData = UIImageJPEGRepresentation(image, 0.1)
            }
            if (imageData?.count)! > 512*1024 {
                imageData = UIImageJPEGRepresentation(image, 0.5)
            }
            if (imageData?.count)! > 200*1024 {
                imageData = UIImageJPEGRepresentation(image, 0.9)
            }
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmssSSS"
        let suffixName = formatter.string(from: Date()) + ".png"
        
		UIApplication.shared.isNetworkActivityIndicatorVisible = true

		Alamofire.upload(
			multipartFormData: { multipartFormData in
				if imageData != nil {
					multipartFormData.append(imageData!, withName: "file" , fileName:imgName + suffixName , mimeType: "image/png")
				}
				for (key, value) in parameters! {
					multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
				}
		},
			to: uploadIImageURLString,
			encodingCompletion: { result in
				UIApplication.shared.isNetworkActivityIndicatorVisible = true
				switch result {
				case .success(let upload, _, _):
					upload.responseJSON { response in
						switch response.result {
						case .success(let data):
							success(JSON(data))
						case .failure(let error):
							failure(error)
						}
					}
				case .failure(let encodingError):
                    
					Print(encodingError)
				}
		})
	}
}


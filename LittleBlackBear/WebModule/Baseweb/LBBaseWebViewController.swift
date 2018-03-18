//
//  BXBaseWebViewController.swift
//  BaiXiangPay
//
//  Created by 蘇崢 on 17/2/10.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
import WebKit

class LBBaseWebViewController: UIViewController {
	
    
    var isHiddenStatusBar:Bool = false{
        didSet{
            if isHiddenStatusBar == true{
                progressView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 10)
            }else{
                progressView.frame = CGRect(x: 0, y: STATUS_BAR_HEIGHT, width: UIScreen.main.bounds.width, height: 10)
            }
        }
    }
	
	var callJavaScript:(()->())?
	
    let mercId:String = LBKeychain.get(CURRENT_MERC_ID)
    let phone:String  = LBKeychain.get(PHONE_NUMBER)
    
    let signString:String = LBKeychain.get(CURRENT_MERC_ID) + LBKeychain.get(PHONE_NUMBER)  + SIGN
    
    let userName:String = LBKeychain.get(USER_NAME)
    let baseUrl = "http://html.xiaoheixiong.net/#/"

	lazy var configuration: WKWebViewConfiguration = {
		
		let configuration = WKWebViewConfiguration()
		configuration.preferences = WKPreferences()
		configuration.preferences.minimumFontSize = 12
		configuration.preferences.javaScriptEnabled = true
		configuration.preferences.javaScriptCanOpenWindowsAutomatically = false
		
		configuration.userContentController = WKUserContentController()
		configuration.userContentController.add(self as WKScriptMessageHandler, name: "GoBackViewController")
		configuration.userContentController.add(self as WKScriptMessageHandler, name: "popRootController")
		configuration.userContentController.add(self, name: "shareAction")
	
		return configuration
		
	}()
	
	lazy var progressView: UIProgressView = {
		let progressView = UIProgressView(progressViewStyle: .default)
        progressView.frame = CGRect(x: 0, y: STATUS_BAR_HEIGHT, width: UIScreen.main.bounds.width, height: 10)
		progressView.tintColor = COLOR_e60013
		progressView.trackTintColor = UIColor.white
		return progressView
	}()
	
	var wkWebView = WKWebView()

    let statusBar = UIView()
    
    
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		let backItem = UIControl(frame: CGRect(x: 0, y: 32, width: 60, height: 24))
		let ItemImageView = UIImageView(image:  UIImage(named: "left_arrow"))
		backItem.addSubview(ItemImageView)
		backItem.addTarget(self, action: #selector(navigationControllerToPop), for: .touchUpInside)
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backItem)
		
	}
	
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		wkWebView.stopLoading()
		super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
	}
	
	func setupUI(){
		
		wkWebView = WKWebView(frame: CGRect.zero, configuration: configuration)
		wkWebView.uiDelegate = self
		wkWebView.navigationDelegate = self
        
		wkWebView.allowsBackForwardNavigationGestures = true
		wkWebView.sizeToFit()
		
		wkWebView.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new
			, context: nil)
		wkWebView.addObserver(self, forKeyPath: "loading", options: NSKeyValueObservingOptions.new
			, context: nil)
		wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new
			, context: nil)
        
		view.addSubview(wkWebView)
		view.addSubview(progressView)
        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[wkWebView]-0-|",
                                                           options: NSLayoutFormatOptions.alignAllCenterX,
                                                           metrics: nil,
                                                           views: ["wkWebView":wkWebView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[wkWebView]-0-|",
                                                           options: NSLayoutFormatOptions.alignAllCenterY,
                                                           metrics: nil,
                                                           views: ["wkWebView":wkWebView]))
        statusBar.translatesAutoresizingMaskIntoConstraints = false
        statusBar.backgroundColor = UIColor.white
        view.addSubview(statusBar)
        view.addConstraint(BXLayoutConstraintMake(statusBar,.left,  .equal,view,.left))
        view.addConstraint(BXLayoutConstraintMake(statusBar,.top,   .equal,view,.top))
        view.addConstraint(BXLayoutConstraintMake(statusBar,.right, .equal,view,.right))
        view.addConstraint(BXLayoutConstraintMake(statusBar,.height,.equal,nil, .height,STATUS_BAR_HEIGHT))
        
        
	}
	
	// MARK: loadWithUrlString
	func loadWithUrlString( urlString:String)  {
		guard urlString.isURLFormate() else {return}
		
		let url:URL = URL(string: urlString)!
		Print(url )
		let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30 )
		self.wkWebView.load(request)
		
	}
	
	func loadHtmlUrlString(urlString:String,baseUrl:String) {
		DispatchQueue.global().async { [weak self] in
			
			var url:URL = URL(string: "")!
			if baseUrl.count > 0 {
				url = URL(string: baseUrl)!
			}
			
			self?.wkWebView.loadHTMLString(urlString, baseURL: url)
		}
		
	}
	
	// MARK:KVO
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context:
		UnsafeMutableRawPointer?) {
		
		if keyPath == "title" {
			navigationItem.title = change?[NSKeyValueChangeKey.newKey] as? String
		}
		
		if keyPath == "estimatedProgress" {
			progressView.setProgress(Float(wkWebView.estimatedProgress), animated: true)
		}
		
		if wkWebView.isLoading == false {
			progressView.alpha = 0
			progressView.setProgress(0, animated: false)
			
		} else {
			if progressView.alpha == 0{
				progressView.alpha = 1
			}
		}
	}
	
	// MARK: user Resepon
	func navigationControllerToPop(  ) {
		if wkWebView.canGoBack {
			self.wkWebView.goBack()
		}else{
			self.navigationController?.popViewController(animated: true)
		}
	}
}

extension LBBaseWebViewController:WKNavigationDelegate{
	
	/// 页面开始加载时调用
	func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
	}
	/// 内容开始返回时调用
	func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
		
	}
	/// 页面加载失败时调用
	func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error){
		if error.localizedDescription == "The request timed out." {
			Print("请求超时!")
		}
	}
	/// 页面加载失败的时候调用
	func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
		
	}
	/// 接收到服务器跳转请求之后再执行
	func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!){
		
	}
	/// 在发送请求之前，决定是否跳转
	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void){
		
		let url  = navigationAction.request.url
		let schame = url?.scheme
		if schame == "tel" {
			let resourceSpecifier = (url as NSURL?)?.resourceSpecifier
			UIApplication.shared.openURL(URL(string: "telprompt://"+resourceSpecifier!)!)
		}
		if (url?.absoluteString.contains("//itunes.apple.com"))!{
			if url?.scheme == "itms-apps" {
				let urlString = url?.absoluteString.components(separatedBy: "itms-apps").last
				UIApplication.shared.openURL(URL(string: ("https"+urlString!))!)

			}else{
				UIApplication.shared.openURL(URL(string: (url?.absoluteString)!)!)

			}

		}
		decisionHandler(.allow)
		
	}
	/// 在接收到响应后，决定是否跳转
	func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void){
		decisionHandler(.allow)
	}
	///需要响应身份验证时调用 同样在block中需要传入用户身份凭证
	func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
		/*
		//用户身份信息
		let newCred = URLCredential(user: "", password: "", persistence: .none)
		challenge.sender?.use(newCred, for: challenge)
		completionHandler(.useCredential,newCred)
		*/
		completionHandler(.performDefaultHandling, challenge.proposedCredential)
	}
	///进程被终止的时候（iOS9)
	func webViewWebContentProcessDidTerminate(_ webView: WKWebView){
		
	}
	
}
extension LBBaseWebViewController:WKUIDelegate{
	/// 创建一个新的webView
	func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
		
		return webView
	}
	/// webView 关闭(ios9.0之后)
	func webViewDidClose(_ webView: WKWebView) {
	}
	/// 与js的alert（交互）
	func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
		UIAlertView(title: "提示", message: message, delegate: nil, cancelButtonTitle: "确定").show()
		completionHandler()
		
	}
	/// 显示js确认框
	func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Swift.Void){
		completionHandler(true)
	}
	/// 弹出js输入框textField
	func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Swift.Void){
		completionHandler("")
	}
	
	
}

extension LBBaseWebViewController:WKScriptMessageHandler{
	
	func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage){
		Print(message.name)
		if message.name == "GoBackViewController" {
			self.navigationControllerToPop()
		}
		if message.name == "popRootController"  {
			self.navigationController?.popToRootViewController(animated: true)
		}

	}
}

extension LBBaseWebViewController:UIWebViewDelegate{
	
	func webViewDidStartLoad(_ webView: UIWebView) {
		
	}
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
		if (self.callJavaScript != nil) {
			self.callJavaScript!()
		}
	}
}

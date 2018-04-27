//
//  BXLoadingView.swift
//  BaiXiangPay
//
//  Created by 蘇崢 on 2017/6/8.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit


final class LBLoadingView:NSObject{
	
	fileprivate static let shareloadingView = LBLoadingView()
	class var loading :LBLoadingView{
		return shareloadingView
	}
	
	fileprivate let loadingView:UIView = {
		let view  = UIView(frame: CGRect(x: 28, y: 21, width: 36, height: 36))
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	fileprivate let messageLabel: UILabel = {
        
		let messageLabel = UILabel()
		messageLabel.font = UIFont.boldSystemFont(ofSize: 14)
		messageLabel.text = "加载中..."
		messageLabel.textColor = white
		let size  = messageLabel.text?.boundingRect(with: CGSize(width: UIScreen.main.bounds.width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)], context: nil).size
		messageLabel.frame.origin.y = 65
		messageLabel.frame.origin.x = (92 - (size?.width)!)*0.5
		messageLabel.frame.size = size!
		messageLabel.sizeToFit()
		return messageLabel
        
	}()
    
	fileprivate let HUDView:UIView = {
        
		let view  = UIView(frame: CGRect(x: (KSCREEN_WIDTH - 92)*0.5, y: (KSCREEN_HEIGHT - 89)*0.5, width: 92, height: 89))
		view.layer.cornerRadius = 5
		view.layer.masksToBounds = true
		view.backgroundColor = UIColor.rgb(58, 58, 58, alpha: 0.75)
		return view
        
	}()
    
	let backView: UIView = {
        
		let view  = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(clearHUD)))
		view.frame = CGRect(x: 0, y: 64, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT)
		return view
        
	}()
	
	fileprivate  var outlineCircle: CGPath {
        
		let path = UIBezierPath()
		let startAngle: CGFloat = CGFloat((0) / 180.0 * .pi)  //0
		let endAngle: CGFloat = CGFloat((360) / 180.0 * .pi)   //360
		path.addArc(withCenter: CGPoint(x: loadingView.frame.size.width/2.0, y: loadingView.frame.size.height/2.0), radius: loadingView.frame.size.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: false)
		return path.cgPath
        
	}
	
    
	fileprivate var circleLayer  = CAShapeLayer()
	fileprivate var outlineLayer = CAShapeLayer()
	
	private func setupLayers() {
		
		HUDView.addSubview(loadingView)
		HUDView.addSubview(messageLabel)
		
		outlineLayer.position = CGPoint(x: 0,
		                                y: 0);
		outlineLayer.path = outlineCircle
		outlineLayer.fillColor = UIColor.clear.cgColor
		outlineLayer.strokeColor =  UIColor.rgb(204, 204, 204, alpha: 1).cgColor
		outlineLayer.lineCap = kCALineCapRound
		outlineLayer.lineWidth = 3;
		loadingView.layer.addSublayer(outlineLayer)
		
		circleLayer.position = CGPoint(x: 0,
		                               y: 0);
		circleLayer.path = outlineCircle
		circleLayer.fillColor = UIColor.clear.cgColor
		circleLayer.strokeColor = COLOR_e60013.cgColor
		circleLayer.lineCap = kCALineCapRound
		circleLayer.lineWidth = 3;
		circleLayer.actions = [
			"strokeStart": NSNull(),
			"strokeEnd": NSNull(),
			"transform": NSNull()
		]
        
		loadingView.layer.addSublayer(circleLayer)
		
		circleLayer.strokeStart = 0.0
		circleLayer.strokeEnd = 0.1
		let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
		rotationAnimation.toValue = NSNumber(value: 2.0 * .pi)
		rotationAnimation.duration = 1
		rotationAnimation.isCumulative = true
		rotationAnimation.repeatCount = MAXFLOAT
		loadingView.layer.add(rotationAnimation, forKey: "rotationAnimation")
		
	}
	
     func show(_ isHiddenBackView:Bool){
        
        guard  let windows = UIApplication.shared.keyWindow else { return }
        setupLayers()
        windows.addSubview(backView)
        backView.isHidden = isHiddenBackView
        windows.addSubview(HUDView)
        windows.bringSubview(toFront: HUDView)
     
	}
	
    func dissmiss(_ windows:UIWindow? = UIApplication.shared.keyWindow!){
        
        HUDView.removeFromSuperview()
        backView.removeFromSuperview()
    
	}
    
    func clearHUD() {
        guard let windows = UIApplication.shared.keyWindow  else{return}
        self.perform(#selector(dissmiss( _ :)), with:windows, afterDelay: 0.5)
		
	}
	
}


//
//  LBPrivatePolicyView.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/25.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import WebKit
class LBPrivatePolicyView: UIView {
    
    var acceptionPolicy:((Bool)->())?
    private let webView = WKWebView()
    private let footerView:UIButton={
        let button = UIButton()
        button.titleLabel?.font = FONT_28PX
        button.setTitleColor(COLOR_e60013, for: .normal)
        button.setTitle("  我已阅读并接受《小黑熊用户协议》", for: .normal)
        button.setImage(UIImage(named:"protocolNormal"), for: .normal)
        button.setImage(UIImage(named:"protocolSelect"), for: .selected)
        return button 
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        footerView.addTarget( self, action: #selector(acceptionPolicy(_ :)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        addSubview(webView)
        addSubview(footerView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[webView]|",
                                                     options: NSLayoutFormatOptions(rawValue: 0),
                                                     metrics: nil ,
                                                     views: ["webView":webView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[footerView]|",
                                                      options: NSLayoutFormatOptions(rawValue: 0),
                                                      metrics: nil ,
                                                      views: ["footerView":footerView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[webView]-[footerView(45)]|",
                                                     options: NSLayoutFormatOptions(rawValue: 0),
                                                     metrics: nil ,
                                                     views: ["webView":webView,"footerView":footerView]))
        guard let url = URL(string:"http://html.xiaoheixiong.net/#/privacyPolicy/1/1") else { return }
        webView.load(URLRequest(url:url))
        
    }
    
    func acceptionPolicy(_ button:UIButton){
        button.isSelected = !button.isSelected
        guard let action = acceptionPolicy,button.isSelected == true  else { return }
        action(true)
    }
    
    
}


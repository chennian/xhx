//
//  UIAlertViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/26.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
extension UIViewController{
    //
    func showAlertView(_ message:String,_ actionTitle:String,_ handler:((UIAlertAction)->Void)?) {
        DispatchQueue.main.async {[weak self] in
            guard let strongSelf = self else{return }
            let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
                guard let handler = handler else{return}
                handler(action)
            }
            alert.addAction(action)
            strongSelf.present(alert, animated: true, completion: nil)
        }
  
    }
    
	func showAlertView(message:String,actionTitles:[String],handler:((UIAlertAction)->Void)?){
        DispatchQueue.main.async {[weak self] in
            guard let strongSelf = self else{return }
            let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
            for title in actionTitles {
                let action = UIAlertAction(title: title, style: .default) { (action) in
                    guard let handler = handler else{return}
                    handler(action)
                }
                
                alert.addAction(action)
            }
            
            strongSelf.present(alert, animated: true, completion: nil)
        }
  
	}
}




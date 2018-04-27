//
//  DDZPickerViewManager.swift
//  quanfanddz
//
//  Created by zhijian chen on 2017/3/13.
//  Copyright © 2017年 zhijian chen. All rights reserved.
//

import UIKit


class DDZPickerViewManager: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
    private var isPresent : Bool = false
    var presentFrame : CGRect = CGRect.zero
    
    
    
    //MARK: - UIViewControllerTransitioningDelegate
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
    
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
    }
    
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let present = CalenderPopPresentatuinController.init(presentedViewController: presented, presenting: presenting)
        present.presentFrame = presentFrame
        return present
    }
    
    //MARK: -  UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            willPresentedController(transitionContext: transitionContext)
            
        }else{
            willDismissController(transitionContext: transitionContext)
        }
        
    }
    
    
    
    /// 执行展现动画
    private func willPresentedController(transitionContext: UIViewControllerContextTransitioning)
    {
        //获取view
        let view  = transitionContext.view(forKey: UITransitionContextViewKey.to)
        //设置初始
        view?.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)//CGAffineTransform(translationX: 0, y: fit( 522))
        //设置锚点
        view?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //添加view
        transitionContext.containerView.addSubview(view!)
        //开始动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            view?.transform = CGAffineTransform.identity
        }, completion: { (_) in
            // 注意: 自定转场动画, 在执行完动画之后一定要告诉系统动画执行完毕了
            transitionContext.completeTransition(true)
        })
    }
    private func willDismissController(transitionContext: UIViewControllerContextTransitioning){
        //获取view
        let view  = transitionContext.view(forKey: UITransitionContextViewKey.from)
        //设置锚点
        view?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //开始动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            view?.transform =  CGAffineTransform(scaleX: 0.001, y: 0.001)//CGAffineTransform(translationX: 0, y: fit( 522))
        }, completion: { (_) in
            // 注意: 自定转场动画, 在执行完动画之后一定要告诉系统动画执行完毕了
            transitionContext.completeTransition(true)
        })
    }
    
}

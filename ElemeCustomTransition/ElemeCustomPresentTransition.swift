//
//  ElemeCustomTransition.swift
//  ElemeCustomTransition
//
//  Created by 任岐鸣 on 2016/12/15.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class ElemeCustomPresentTransition: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! ElemeViewController
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)! as UIViewController
        toVC.view.alpha = 0
        let container = transitionContext.containerView
        
        
        let rect = CGRect.init(x:  fromVC.view.frame.width * (1-0.85) / 2, y: (fromVC.view.frame.height - 430)/2, width: fromVC.view.frame.width*0.85, height: 430)
        let cardView = CardView.init(frame: rect)
        cardView.setData(title: (fromVC.selectedCell?.cardView.lblTitle.text)!, price: (fromVC.selectedCell?.cardView.lblPrice.text)!)
        
        container.addSubview(toVC.view)
        container.addSubview(cardView)
        
        fromVC.view.alpha = 0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toVC.view.alpha = 1
        }) { (finished) in
            container.bringSubview(toFront: toVC.view)
            fromVC.view.alpha = 1
            transitionContext.completeTransition(true)
        }
    }
}

//
//  ElemeCustomDismissTransition.swift
//  ElemeCustomTransition
//
//  Created by 任岐鸣 on 2016/12/15.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class ElemeCustomDismissTransition: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from) as! DetailViewController
        let toVC = transitionContext.viewController(forKey: .to) as! ElemeViewController
        
        toVC.view.alpha = 0
        
        if fromVC.isBeingDismissed {
            
            let duration = transitionDuration(using: transitionContext)
            UIView.animate(withDuration: duration, animations: {
                fromVC.cardView.frame = (toVC.selectedCell?.cardView.frame)!
                fromVC.cardView.layoutSubviews()
            }, completion: {
                finished in
                toVC.view.alpha = 1
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}

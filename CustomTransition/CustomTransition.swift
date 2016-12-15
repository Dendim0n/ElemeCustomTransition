//
//  CustomTransition.swift
//  CustomTransition
//
//  Created by 任岐鸣 on 2016/11/30.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class SimplePresentAnim: NSObject,UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toVC = transitionContext.viewController(forKey: .to)!
        
        let screenBounds = UIScreen.main.bounds
        let finalFrame = transitionContext.finalFrame(for: toVC)
        toVC.view.frame = finalFrame.offsetBy(dx: 0, dy: screenBounds.size.height)
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            toVC.view.frame = finalFrame
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
        })
        
    }
}
class SimpleDismissAnim: NSObject,UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from)!
//        let toVC = transitionContext.viewController(forKey: .to)!
        
        if fromVC.isBeingDismissed {
            let screenBounds = UIScreen.main.bounds
            let initFrame = transitionContext.initialFrame(for: fromVC)
            //        let finalFrame = transitionContext.finalFrame(for: toVC)
            let finalFrame = initFrame.offsetBy(dx: 0, dy: screenBounds.size.height)
            //        toVC.view.frame = init.offsetBy(dx: 0, dy: screenBounds.size.height)
            
            let containerView = transitionContext.containerView
            //        containerView.addSubview(toVC.view)
            //        containerView.sendSubview(toBack: toVC.view)
            
            let duration = transitionDuration(using: transitionContext)
            UIView.animate(withDuration: duration, animations: {
                fromVC.view.frame = finalFrame
            }, completion: {
                finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        

        
    }
}
class InteractionTransition: UIPercentDrivenInteractiveTransition,UIViewControllerTransitioningDelegate {
    
    var shouldComplete = false
    var interacting = false
    var presentingVC:UIViewController?
    
    var pan:UIPanGestureRecognizer?
    
    init(toViewController:UIViewController) {
        super.init()
        presentingVC = toViewController
        prepareGestureRecognizerInView(view: toViewController.view)
    }
    
    private func prepareGestureRecognizerInView(view:UIView) {
        pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan(pan:)))
        view.addGestureRecognizer(pan!)
    }
    
    func handlePan(pan:UIPanGestureRecognizer) {
        let translation = pan.translation(in: pan.view?.superview)
        switch pan.state {
        case .began:
            interacting = true
            presentingVC?.dismiss(animated: true, completion: nil)
        case .changed:
            var fraction = translation.y / UIScreen.main.bounds.height
            fraction = CGFloat(fminf(fmaxf(Float(fraction), 0.0), 1.0))
            shouldComplete = fraction > 0.5
            update(fraction)
        break
        case .cancelled:
            interacting = false
            if !shouldComplete || pan.state == .cancelled{
                cancel()
            } else {
                finish()
            }
        break
        case .ended:
            if shouldComplete {
                finish()
            } else {
                cancel()
            }
            break
        default:
            cancel()
            break
        }
    }
    
    override func cancel() {
        super.cancel()
//        pan?.removeTarget(self, action: #selector(handlePan(pan:)))
        
    }
    override func finish() {
        super.finish()
    }
    
}

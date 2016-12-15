//
//  FirstViewController.swift
//  CustomTransition
//
//  Created by 任岐鸣 on 2016/11/30.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UIViewControllerTransitioningDelegate {
    
    var presentAnim = SimplePresentAnim()
    var dismissAnim = SimpleDismissAnim()
    var dismissTransitionController:InteractionTransition?

    @IBAction func btnClicked(_ sender: UIButton) {
        let vc = SecondViewController()
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        dismissTransitionController = InteractionTransition.init(toViewController: vc)
        
        present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnim
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnim
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (self.dismissTransitionController?.interacting)! ? self.dismissTransitionController : nil
    }


}


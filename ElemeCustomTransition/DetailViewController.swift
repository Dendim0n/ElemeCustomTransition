//
//  DetailViewController.swift
//  ElemeCustomTransition
//
//  Created by 任岐鸣 on 2016/12/15.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(430)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        let button = UIButton()
        view.addSubview(button)
        button.backgroundColor = .black
        button.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        button.addTarget(self, action: #selector(animDismiss), for: UIControlEvents.touchUpInside)
        // Do any additional setup after loading the view.
        let blankView = UIView()
        blankView.backgroundColor = .white
        view.addSubview(blankView)
        blankView.snp.makeConstraints { (make) in
            make.top.equalTo(cardView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func animDismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            for subview in self.view.subviews {
                if subview != self.cardView {
                    subview.alpha = 0
                }
            }
        }) { (_) in
             self.dismiss(animated: true, completion: nil)
        }
       
    }
    
    func animForDismiss() {
        cardView.snp.remakeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalTo(430)
            make.center.equalToSuperview()
        }
        cardView.center = self.view.center
        self.view.layoutSubviews()
    }
    
    lazy var cardView = CardView(frame:.zero)
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3, animations: {
            for subview in self.view.subviews {
                if subview != self.cardView {
                    subview.alpha = 1.0
                }
            }
        }, completion: nil)
    }

}

//
//  ElemeCollectionViewCell.swift
//  ElemeCustomTransition
//
//  Created by 任岐鸣 on 2016/12/15.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class ElemeCollectionViewCell: UICollectionViewCell,UIGestureRecognizerDelegate {
    
    typealias doSomething = (ElemeCollectionViewCell) -> Void
    var toDetailClosure:doSomething?
    var dismissClosure:doSomething?
    var swipeDirection:direction = .none
    
    var currentTranslationPercent = 0.0
    
    let cardView = CardView(frame:.zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalTo(430)
            make.center.equalToSuperview()
        }
        
        
        
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(pan(sender:)))
        panGesture.delegate = self
        self.addGestureRecognizer(panGesture)
        
    }
    
    
    func pan(sender:UIPanGestureRecognizer) {
        let upScale = 75.0
        let downScale = 300.0
        switch sender.state {
        case .began: self.swipeDirection = .none
        case .changed:
            let point = sender.translation(in: self)
            swipeDirection = determineSwipeDirection(translation: sender.translation(in: self),useForAction: true)
            switch swipeDirection {
            case .down:
                currentTranslationPercent = Double(max(point.y,CGFloat(-downScale))) / downScale
                let transform = CGAffineTransform(translationX: 0, y: max(0,min(point.y,CGFloat(downScale))))
                cardView.transform = transform
            case .up:
                currentTranslationPercent = Double(max(point.y,CGFloat(-upScale))) / upScale
            default:
//                sender.fail
                break
            }
        case .ended:
            if currentTranslationPercent > 0.5 && swipeDirection == .down {
                print("dismiss")
                if self.dismissClosure != nil {
                    self.dismissClosure!(self)
                }
                cardView.transform = CGAffineTransform.identity
            } else if currentTranslationPercent < -0.5 && swipeDirection == .up {
                self.toDetail()
            }
            self.currentTranslationPercent = 0.0
            self.swipeDirection = .none
        default: break
        }
    }
    
    func toChooseRank() {
        
    }
    
    func toDetail() {
        print("goDetail")
        
        UIView.animate(withDuration: 0.3, animations: { 
            self.cardView.snp.remakeConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(430)
                make.centerX.equalToSuperview()
                make.top.equalToSuperview()
            }
            self.layoutSubviews()
        }) { _ in
            if self.toDetailClosure != nil {
                self.toDetailClosure!(self)
            }
            self.returnInitialConstraint()
        }
        
    }
    
    func returnInitialConstraint() {
        cardView.snp.remakeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalTo(430)
            make.center.equalToSuperview()
        }
    }
    func toCollection() {
        
    }

    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if swipeDirection == .none {
            return true
        } else {
            return false
        }
//        return true
    }
    
    
    func determineSwipeDirection(translation:CGPoint,useForAction:Bool) ->
        direction {
            let gestureMinimumTranslation = 20.0
            
            if swipeDirection != .none && useForAction {
                return swipeDirection
            }
            if (fabs(translation.x) > CGFloat(gestureMinimumTranslation)) {
                
                var gestureHorizontal = false
                
                if translation.y == 0.0 {
                    gestureHorizontal = true
                } else {
                    gestureHorizontal = (fabs(translation.x / translation.y) > 5.0)
                }
                
                if gestureHorizontal {
                    if translation.x > 0.0 {
                        return .right
                    } else {
                        return .left
                    }
                }
            } else if (fabs(translation.y) > CGFloat(gestureMinimumTranslation)) {
                if translation.y > 0.0 {
                    return .down
                } else {
                    return .up
                }
            }
            return swipeDirection
    }
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    enum direction {
        case up
        case down
        case left
        case right
        case none
    }
    
}

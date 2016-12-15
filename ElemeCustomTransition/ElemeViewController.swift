//
//  ViewController.swift
//  ElemeCustomTransition
//
//  Created by 任岐鸣 on 2016/12/14.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class ElemeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIViewControllerTransitioningDelegate {
    
    var selectedCell:ElemeCollectionViewCell?
    
    var presentTransition = ElemeCustomPresentTransition()
    var dismissTransition = ElemeCustomDismissTransition()
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.view.frame.size
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collection = UICollectionView.init(frame: self.view.frame, collectionViewLayout: layout)
        collection.register(ElemeCollectionViewCell.self, forCellWithReuseIdentifier: "elemeCell")
        collection.delegate = self
        collection.dataSource = self
        collection.isPagingEnabled = true
        collection.backgroundColor = .clear
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.backgroundColor = .clear
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "elemeCell", for: indexPath) as! ElemeCollectionViewCell
        cell.dismissClosure = {
            thisCell in
//            self.selectedCell = cell
        }
        cell.toDetailClosure = {
            thisCell in
            self.selectedCell = collectionView.cellForItem(at: indexPath) as! ElemeCollectionViewCell?
            let vc = DetailViewController()
            vc.view.backgroundColor = .black
            
//            self.view.backgroundColor = .white
            vc.transitioningDelegate = self
            vc.modalPresentationStyle = .custom
            vc.cardView.lblPrice.text = thisCell.cardView.lblPrice.text
            self.present(vc, animated: false, completion: nil)
            
        }
        cell.cardView.lblPrice.text = "\(indexPath.row)RMB"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! ElemeCollectionViewCell
//        self.selectedCell = cell
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }

}


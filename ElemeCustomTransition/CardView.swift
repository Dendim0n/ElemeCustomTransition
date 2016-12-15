//
//  Cardswift
//  ElemeCustomTransition
//
//  Created by 任岐鸣 on 2016/12/15.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class CardView:UIView {
    lazy var imageView:UIImageView = {
        let imgV = UIImageView()
        imgV.backgroundColor = .blue
        return imgV
    }()
    
    lazy var lblTitle:UILabel = {
        let lbl = UILabel()
        lbl.text = "test"
        return lbl
    }()
    
    var countSelector = UIView()
    
    lazy var lblPrice:UILabel = {
        let lbl = UILabel()
        lbl.text = "123RMB"
        return lbl
    }()
    
    lazy var btnAddCart:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .gray
        btn.setTitle("加入购物车", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.layer.cornerRadius = 12.5
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.cornerRadius = 4
        clipsToBounds = true
        let bottomBlankView = UIView()
        bottomBlankView.backgroundColor = .white
        addSubview(bottomBlankView)
        addSubview(self.imageView)
        addSubview(self.lblTitle)
        addSubview(self.countSelector)
        addSubview(self.lblPrice)
        addSubview(self.btnAddCart)
        
        bottomBlankView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        self.btnAddCart.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-11)
            make.height.equalTo(25)
            make.width.equalTo(85)
        }
        self.lblPrice.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalTo(self.btnAddCart)
        }
        self.lblTitle.snp.makeConstraints { (make) in
            make.left.equalTo(self.lblPrice)
            make.bottom.equalTo(self.lblPrice.snp.top).offset(-42.5)
        }
        self.countSelector.snp.makeConstraints { (make) in
            make.right.equalTo(self.btnAddCart)
            make.centerY.equalTo(self.lblTitle)
        }
        self.imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(self.lblTitle.snp.top).offset(-20)
        }

    }
    func setData(img:UIImage? = nil, title:String,price:String) {
        imageView.image = img
        lblTitle.text = title
        lblPrice.text = price
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


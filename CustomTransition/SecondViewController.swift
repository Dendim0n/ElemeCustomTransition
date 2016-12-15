//
//  SecondViewController.swift
//  CustomTransition
//
//  Created by 任岐鸣 on 2016/11/30.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        // Do any additional setup after loading the view.
        
        let btn = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = .red
        btn.setTitle("dismiss", for: UIControlState.normal)
        btn.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        view.addSubview(btn)
        
        
    }

    func clicked() {
        print("dismiss")
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  KenDropMenu
//
//  Created by 科技部iOS on 2018/3/6.
//  Copyright © 2018年 Ken. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var dropView: KenDropView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dropView.dataArr = ["A","B","C","D","E","F","G"]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


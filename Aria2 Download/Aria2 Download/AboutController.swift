//
//  AboutController.swift
//  PanDownload
//
//  Created by Jano on 2017/8/17.
//  Copyright © 2017年 Jano. All rights reserved.
//

import Cocoa

class AboutController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    // 打开 aria2 GitHub 页面
    @IBAction func aria2(_ sender: Any) {
        let a_url = URL(string: "https://github.com/aria2/aria2")
        NSWorkspace.shared.open(a_url!)
    }
    
    // 打开本程序 GitHub 页面
    @IBAction func bExp(_ sender: Any) {
        let b_url = URL(string: "https://github.com/Mongkii/Aria2-Download")
        NSWorkspace.shared.open(b_url!)
    }
    
}

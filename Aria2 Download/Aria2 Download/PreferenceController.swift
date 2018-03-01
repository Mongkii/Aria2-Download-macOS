//
//  PreferenceController.swift
//  PanDownload
//
//  Created by Jano on 2017/8/17.
//  Copyright © 2017年 Jano. All rights reserved.
//

import Cocoa

class PreferenceController: NSViewController {
    
    var pref = Preferences()
    
    @IBOutlet weak var urlOld: NSTextField!
    @IBOutlet weak var urlNew: NSTextField!
    
    // 显示当前偏好设置
    func showPref() {
        urlOld.stringValue = pref.replaceFrom
        urlNew.stringValue = pref.replaceTo
    }
    
    // 保存偏好设置
    func savePref() {
        pref.replaceFrom = urlOld.stringValue
        pref.replaceTo = urlNew.stringValue
        pref.setModified = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showPref()
        // Do view setup here.
    }
    
    // 取消按钮动作
    @IBAction func doCancel(_ sender: Any) {
        view.window?.close()
    }
    
    // 保存按钮动作
    @IBAction func doSave(_ sender: Any) {
        savePref()
        view.window?.close()
    }
    
    //重置偏好设置
    @IBAction func doReset(_ sender: Any) {
        pref.setModified = false
        urlOld.stringValue = pref.replaceFrom
        urlNew.stringValue = pref.replaceTo
    }
}

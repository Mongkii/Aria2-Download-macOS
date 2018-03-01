//
//  ViewController.swift
//  PanDownload
//
//  Created by Jano on 2017/8/17.
//  Copyright © 2017年 Jano. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var pref = Preferences()
    
    @IBOutlet weak var tbURL: NSTextField!
    @IBOutlet weak var btnCopy: NSButton!
    @IBOutlet weak var lbFolder: NSTextField!
    @IBOutlet weak var lbFile: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshPath()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // 刷新下载路径字符颜色
    func refreshPath() {
        lbFolder.stringValue = pref.folderPath
        if (lbFolder.stringValue == "未指定") {
            lbFolder.textColor = NSColor.tertiaryLabelColor
        }
        else {
            lbFolder.textColor = NSColor.black
        }
    }
    
    // 根据当前设置的下载路径修改 aria2 命令
    func Replace(_ Ori: String) -> String {
        // 学习：var New: String = String(Ori.characters.dropLast())
        var New: String = Ori.replacingOccurrences(of: "\n", with: "")
        if (lbFolder.stringValue != "未指定") {
            New = New + " --dir=\"" + lbFolder.stringValue + "\"\n"
        }
        New = New.replacingOccurrences(of: pref.replaceFrom, with: pref.replaceTo)
        return New
    }
    
    // 获取下载文件的文件名
    func GetName(_ In: String) -> String {
        let pattern = "\\-o\\s\\'.+\\'\\s\\-\\-header"
        let process = try!NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let result = process.firstMatch(in: In, options: [], range: NSMakeRange(0, In.count))
        if (result != nil) {
            return result.map({ (r) -> String in
                let str = In as NSString
                let newLocation = r.range.location + 4
                let newLength = r.range.length - 14
                let range: NSRange = NSRange.init(location: newLocation, length: newLength)
                return "文件名：" + str.substring(with: range)
            })!
        }
        else {
            return ""
        }
    }

    // 修改下载路径
    @IBAction func doModify(_ sender: Any) {
        let Selector = NSOpenPanel()
        Selector.allowsMultipleSelection=false
        Selector.canChooseFiles = false
        Selector.canChooseDirectories=true
        Selector.canCreateDirectories=true
        let Result = Selector.runModal()
        if (Result == NSApplication.ModalResponse.OK) {
            pref.folderPath = (Selector.directoryURL?.path)!
            pref.pathModified = true
            refreshPath()
        }
    }
    
    // 将地址复制到剪贴板并打开 Terminal.app
    @IBAction func doCopy(_ sender: Any) {
        let Clip = NSPasteboard.general
        Clip.clearContents()
        Clip.setString(Replace(tbURL.stringValue), forType: .string)
        NSWorkspace.shared.open(URL(fileURLWithPath: "/Applications/Utilities/Terminal.app"))
    }
}

extension ViewController: NSControlTextEditingDelegate {
    override func controlTextDidChange(_ obj: Notification) {
        lbFile.stringValue = GetName(tbURL.stringValue)
        btnCopy.isEnabled = (lbFile.stringValue != "")
    }
}

//
//  File.swift
//  PanDownload
//
//  Created by Jano on 2017/8/17.
//  Copyright © 2017年 Jano. All rights reserved.
//

import Foundation

struct Preferences {
    
    // 设置是否被更改
    var setModified: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "setModified")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "setModified")
        }
    }
    
    // 下载路径是否被更改
    var pathModified: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "pathModified")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "pathModified")
        }
    }
    
    // 设置替换自
    var replaceFrom: String {
        get {
            if (setModified == true) {
                return UserDefaults.standard.string(forKey: "replaceFrom")!
            }
            else {
                return "-c -s10 -k1M -x16 --enable-rpc=false -o"
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "replaceFrom")
        }
    }
    
    // 设置替换为
    var replaceTo: String {
        get {
            if (setModified == true) {
                return UserDefaults.standard.string(forKey: "replaceTo")!
            }
            else {
                return "-c -s256 -k1M -x16 -t1 -m0 --enable-rpc=false -o"
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "replaceTo")
        }
    }
    
    // 下载路径
    var folderPath: String {
        get {
            if (pathModified == true) {
                return UserDefaults.standard.string(forKey: "folderPath")!
            }
            else {
                return "未指定"
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "folderPath")
        }
    }
    
}

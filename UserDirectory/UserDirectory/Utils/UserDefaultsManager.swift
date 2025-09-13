//
//  Ext+UserDefaults.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 14/9/25.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let isLogin = "isLogin"
    }
    
    var isLogin: Bool {
        get { bool(forKey: Keys.isLogin) }
        set { set(newValue, forKey: Keys.isLogin) }
    }
    
    
}

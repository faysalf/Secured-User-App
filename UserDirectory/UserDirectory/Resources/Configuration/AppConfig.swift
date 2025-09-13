//
//  AppConfig.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 13/9/25.
//

import Foundation

enum AppEnvironment: String {
    case dev, staging, prod
}

struct AppConfig {
    static let current: AppEnvironment = .dev
    
    static var baseURL: String {
        switch current {
        case .dev: return "https://reqres.in/"
        case .staging: return "https://reqres.in/"
        case .prod: return "https://reqres.in/"
            
        }
    }
}

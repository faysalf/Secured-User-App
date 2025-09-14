//
//  KeychainManager.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 13/9/25.
//

import Foundation
import Security

final class KeychainManager {
    
    static let shared = KeychainManager()    
    private let service = "com.faysal.UserDirectory"
    private let account = "authToken"
    
    // Save Token
    func saveToken(_ token: String) -> Bool {
        guard let data = token.data(using: .utf8) else { return false }
        
        deleteToken()
        
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account,
            kSecValueData as String   : data
        ]
        
        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }
    
    // Get Token
    func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess, let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    // Delete Token
    @discardableResult
    func deleteToken() -> Bool {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account
        ]
        
        return SecItemDelete(query as CFDictionary) == errSecSuccess
    }
    
    
}

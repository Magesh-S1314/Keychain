//
//  Keychain.swift
//  NTrust
//
//  Created by magesh on 30/01/21.
//

import Foundation
import Security

class Keychain {
    
    class func set<T>(_ value: T, forKey: String) {
        let data = Data(from: value)
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : forKey,
            kSecValueData as String   : data ] as [String : Any]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    class func get<T>(forKey: String, type: T.Type) -> T? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : forKey,
            kSecReturnData as String  : kCFBooleanTrue as Any,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr {
            let data = (dataTypeRef as? Data)
            return data?.to(type: type)
        } else {
            return nil
        }
    }
    
    class func delete(forKey: String) {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : forKey] as [String : Any]
        SecItemDelete(query as CFDictionary)
    }
    
    class func deleteAll()  {
        let secItemClasses =  [kSecClassGenericPassword]
        for itemClass in secItemClasses {
            let spec: NSDictionary = [kSecClass: itemClass]
            SecItemDelete(spec)
        }
    }
}


extension Data {
    
    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}


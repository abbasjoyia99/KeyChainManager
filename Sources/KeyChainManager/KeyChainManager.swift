// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import Security

public class KeychainManager {
    public static let shared = KeychainManager()
    
    private let service = "com.example.app"
    
    private init() {}
    
    /**
     Saves the specified email securely in the keychain.
     
     - Parameters:
        - email: The email to be saved.
        - forKey: The key associated with a value that will be saved or retrieved.
     
     - Returns: A boolean value indicating whether the email was saved successfully.
     */
    public func saveEmail(email: String, forKey:String) -> Bool {
        return saveData(data: email, forKey: forKey)
    }
    
    /**
     Saves the specified password securely in the keychain.
     
     - Parameters:
        - password: The password to be saved.
        - forKey: The key associated with a value that will be saved or retrieved.
     
     - Returns: A boolean value indicating whether the password was saved successfully.
     */
    public func savePassword(password: String,forKey: String) -> Bool {
        return saveData(data: password, forKey: forKey)
    }
    
    private func saveData(data: String, forKey key: String) -> Bool {
        if let data = data.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]
            
            let status = SecItemAdd(query as CFDictionary, nil)
            return status == errSecSuccess
        }
        
        return false
    }
    // MARK: - Get Data
    /**
     Get the specified email securely in the keychain.
     
     - Parameters:
       - forKey: The key associated with a value that will be saved or retrieved.
     
     - Returns: A string value.
     */
    public func getEmail(forKey: String) -> String? {
        return retriveEmail(forKey)
    }
    
   private func retriveEmail(_ key:String) -> String? {
        let query: [String:Any] = [
            kSecClass as String:kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String:true,
            kSecReturnData as String:true
        ]
        var item:CFTypeRef?
        
        if (SecItemCopyMatching(query as CFDictionary, &item) == noErr) {
            guard let existingItem = item as? [String:Any] else {return nil}
            guard let email = existingItem[kSecAttrAccount as String] as? String else {return nil}
            return email
        } else {
            return nil
            //print("Something went wrong while trying to find password in keychain")
        }
        
    }
    
    /**
     Get the specified password securely in the keychain.
     
     - Parameters:
       - forKey: The key associated with a value that will be saved or retrieved.
     
     - Returns: A string value.
     */
    public func getPassword(forKey: String) -> String? {
        return retrivePassword(forKey)
    }
    
   private func retrivePassword(_ key:String)-> String? {
        let query: [String:Any] = [
            kSecClass as String:kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String:true,
            kSecReturnData as String:true
        ]
        var item:CFTypeRef?
        
        if (SecItemCopyMatching(query as CFDictionary, &item) == noErr) {
            guard let existingItem = item as? [String:Any] else {return nil}
            guard let passwordData = existingItem[kSecValueData as String] as? Data else {return nil}
            guard let password = String(data: passwordData, encoding: .utf8) else {return nil}
            return password
        } else {
            return nil
        }
        
    }
    // MARK: - Update Data
    
    /**
     Update the specified email securely in the keychain.
     
     - Parameters:
        - email: The email to be updated.
     
     - Returns: A boolean value indicating whether the email was updated successfully.
     */
    public func updateEmail(newEmail: String,forKey: String) -> Bool {
        return updateData(data: newEmail, forKey: forKey)
    }
    
    /**
     Update the specified password securely in the keychain.
     
     - Parameters:
        - password: The password to be updated.
     
     - Returns: A boolean value indicating whether the password was updated successfully.
     */
    public func updatePassword(newPassword: String, forKey: String) -> Bool {
        return updateData(data: newPassword, forKey: forKey)
    }
    
    private func updateData(data: String, forKey key: String) -> Bool {
        if let data = data.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: key
            ]
            
            let updateAttributes: [String: Any] = [
                kSecValueData as String: data
            ]
            
            let status = SecItemUpdate(query as CFDictionary, updateAttributes as CFDictionary)
            return status == errSecSuccess
        }
        
        return false
    }
    
    // MARK: - Delete Data
    
    /**
     Delete the specified email securely from the keychain.
     
     - Parameters:
        - email: The email to be deleted.
     
     - Returns: A boolean value indicating whether the email was deleted successfully.
     */
    public func deleteEmail(forKey: String) -> Bool {
        return deleteData(forKey: forKey)
    }
    
    /**
     Delete the specified password securely from the keychain.
     
     - Parameters:
        - password: The password to be deleted.
     
     - Returns: A boolean value indicating whether the password was deleted successfully.
     */
    public func deletePassword(forKey: String) -> Bool {
        return deleteData(forKey: forKey)
    }
    
    private func deleteData(forKey key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}

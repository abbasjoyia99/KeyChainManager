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
     
     - Returns: A boolean value indicating whether the email was saved successfully.
     */
    public func saveEmail(email: String) -> Bool {
        return saveData(data: email, forKey: "email")
    }
    
    /**
     Saves the specified password securely in the keychain.
     
     - Parameters:
        - password: The password to be saved.
     
     - Returns: A boolean value indicating whether the password was saved successfully.
     */
    public func savePassword(password: String) -> Bool {
        return saveData(data: password, forKey: "password")
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
    
    // MARK: - Update Data
    
    /**
     Update the specified email securely in the keychain.
     
     - Parameters:
        - email: The email to be updated.
     
     - Returns: A boolean value indicating whether the email was updated successfully.
     */
    public func updateEmail(newEmail: String) -> Bool {
        return updateData(data: newEmail, forKey: "email")
    }
    
    /**
     Update the specified password securely in the keychain.
     
     - Parameters:
        - password: The password to be updated.
     
     - Returns: A boolean value indicating whether the password was updated successfully.
     */
    public func updatePassword(newPassword: String) -> Bool {
        return updateData(data: newPassword, forKey: "password")
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
    public func deleteEmail() -> Bool {
        return deleteData(forKey: "email")
    }
    
    /**
     Delete the specified password securely from the keychain.
     
     - Parameters:
        - password: The password to be deleted.
     
     - Returns: A boolean value indicating whether the password was deleted successfully.
     */
    public func deletePassword() -> Bool {
        return deleteData(forKey: "password")
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

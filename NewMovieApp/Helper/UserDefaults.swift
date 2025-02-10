//
//  UserDefaults.swift
//  NewMovieApp
//
//  Created by Shahmar on 18.01.25.
//

import Foundation

/*struct UserDefaultsHelper {
    
    //set
    
    static func setString(_ string: String,  key: UserDefaultsKeys) {
        UserDefaults.standard.set(string, forKey: key.rawValue)
        UserDefaults.standard.synchronize() // datani update elesin deye istifade edirik
    }
    
    static func setInt(_ int: Int,  key: UserDefaultsKeys) {
        UserDefaults.standard.set(int, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func setBool(_ bool: Bool,  key: UserDefaultsKeys) {
        UserDefaults.standard.set(bool, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func setFloat(_ float: Float,  key: UserDefaultsKeys) {
        UserDefaults.standard.set(float, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func setDouble(_ double: Double,  key: UserDefaultsKeys) {
        UserDefaults.standard.set(double, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    //Get
    
    static func getString(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    static func getInt(key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    static func getBool(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    static func getFloat(key: String) -> Float {
        return UserDefaults.standard.float(forKey: key)
    }
    
    static func getDouble(key: String) -> Double {
        return UserDefaults.standard.double(forKey: key)
    }
    
    // remove
    
    static func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}*/

enum UserDefaultsKeys: String {
    case accountId = "UD_KEY_ACCOUNT_ID"
    
    func setString(_ string: String) {
        UserDefaults.standard.set(string, forKey: self.rawValue)
        UserDefaults.standard.synchronize() // datani update elesin deye istifade edirik
    }
    
    func setInt(_ int: Int) {
        UserDefaults.standard.set(int, forKey: self.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func setBool(_ bool: Bool) {
        UserDefaults.standard.set(bool, forKey: self.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func setFloat(_ float: Float) {
        UserDefaults.standard.set(float, forKey: self.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func setDouble(_ double: Double) {
        UserDefaults.standard.set(double, forKey: self.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getString() -> String? {
        return UserDefaults.standard.string(forKey: self.rawValue)
    }
    
    func getInt(key: String) -> Int {
        return UserDefaults.standard.integer(forKey: self.rawValue)
    }
    
    func getBool(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: self.rawValue)
    }
    
    func getFloat(key: String) -> Float {
        return UserDefaults.standard.float(forKey: self.rawValue)
    }
    
    func getDouble(key: String) -> Double {
        return UserDefaults.standard.double(forKey: self.rawValue)
    }
    
    func remove() {
        UserDefaults.standard.removeObject(forKey: self.rawValue)
        UserDefaults.standard.synchronize()
    }
}

let UD_KEY_ACCOUNT_ID = "UD_KEY_ACCOUNT_ID"

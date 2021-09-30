//
//  UserDefaultsManager.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import Foundation


let DEFAULTS = UserDefaults.standard


final class UserDefaultsManager: NSObject {
    
    //MARK: - Variables
    
    
    //MARK: - User Data
    final class func saveUserModel(user: User.Responce){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            DEFAULTS.set(encoded, forKey: "UserData")
        }
    }
    
    class func getUserModel() -> User.Responce? {
        if let savedUser = DEFAULTS.object(forKey: "UserData") as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.Responce.self, from: savedUser) {
                return loadedUser
            }
        }
        return nil
    }
    
    
    final class func removeUserModel(){
        DEFAULTS.removeObject(forKey: "UserData")
    }
    
    
    //----------------------------------------------------------------------------------------------------
    //MARK: - APNS Token
    final class func saveAPNSToken(_ token: String) {
        DEFAULTS.set(token, forKey: "DeviceToken")
    }


    final class func getAPNSToken() -> String? {
        return DEFAULTS.string(forKey: "DeviceToken")
    }
    
}

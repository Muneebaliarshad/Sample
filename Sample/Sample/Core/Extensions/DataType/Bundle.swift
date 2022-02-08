//
//  Bundle.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import Foundation

extension Bundle {
    static func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version : String = dictionary["CFBundleName"] as? String {
            return version
        } else {
            return ""
        }
    }


    static func getVersionNumber() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? ?? "x.x"
    }
    
    static func getBuildNumber() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String? ?? "x"
    }

    static func getFullVersion() -> String {
        return "\(getVersionNumber()) (\(getBuildNumber()))"
    }
}

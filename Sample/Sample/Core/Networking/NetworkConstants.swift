//
//  NetworkConstants.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//


import Foundation
import Alamofire

struct Servers {
    static let Staging = "https://dog.ceo/api"
    static let Production = "https://dog.ceo/api"
    
    
    static func baseUrl() -> String {
        #if STAGING
        return Staging
        
        #elseif DEBUG
        return Staging
        
        #else
        return Production
        #endif
    }
    
    static func baseURLWith(route: Route) -> String {
        return baseUrl() + route.rawValue
    }
    
    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}


enum Route: String {
    case list = "/breeds/list/all"
}



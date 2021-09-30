//
//  APIManager.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import Alamofire


typealias DefaultAPIFailureClosure = (NSError) -> Void
typealias DefaultAPISuccessClosure = (Dictionary<String,AnyObject>) -> Void


final class APIManager: NSObject {
    static let sharedInstance = APIManager()
    let authenticationManagerAPI = AuthenticationAPIManager()
}

//
//  AuthenticationAPIManager.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import UIKit
import Alamofire

class AuthenticationAPIManager: APIManagerBase {
    
    fileprivate func getRouteAs(method: HTTPMethod, route: String) -> URL {
        switch method {
        case .get:
            return GETURLfor(route: route, parameters: [:])!
            
        case .post:
            return POSTURLforRoute(route: route)!
            
        case .patch, .delete:
            return URL(string: (kBaseURL+route))!
            
        default:
            return URL(string: "")!
        }
    }
    
    
    func serverRequest(parameters: Parameters?,
                       type: HTTPMethod,
                       route: String,
                       success:@escaping DefaultAPISuccessClosure,
                       failure:@escaping DefaultAPIFailureClosure){
        
        
        serverRequestWith(route: getRouteAs(method: type, route: route), parameters: parameters, requestType: type, success: success, failure: failure)
        
    }
    
    
    func multiPartServerRequest(parameters: Parameters?,
                                type: HTTPMethod,
                                route: String,
                                success:@escaping DefaultAPISuccessClosure,
                                failure:@escaping DefaultAPIFailureClosure){
        
        
        requestWithMultipart(route: getRouteAs(method: .post, route: route), parameters: parameters!, requestType: type, success: success, failure: failure)
        
    }
}

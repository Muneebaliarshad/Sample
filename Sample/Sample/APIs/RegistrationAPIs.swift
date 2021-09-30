//
//  RegistrationAPIs.swift
//  Sample
//
//  Created by Muneeb on 30/09/2021.
//

import Foundation
import Alamofire


struct RegestrationAPIs {
    static func loginUser(_ params: Parameters, completionHandler: @escaping (_ status: Bool?, _ message: String?) -> Void) {
        if !(isConnectedToInternet()){
            completionHandler(false, "No Network")
            return
        }
        
        let successClosure: DefaultAPISuccessClosure = {
            (result) in
            do {
                let jsonData = Utility.json(from: result)
                let jsonDecoder = JSONDecoder()
                let dataSource = try jsonDecoder.decode(APIResponseModel<User.Responce>.self, from: (jsonData?.data(using: .utf8)!)!)
                if dataSource.status == "200" {
                    UserDefaultsManager.saveUserModel(user: dataSource.data ?? User.Responce())
                    completionHandler(true, nil)
                } else {
                    completionHandler(false, dataSource.message)
                }
                
            } catch {
                completionHandler(false, "Sorry, we are unable to process your request at the moment.\n\nPlease try again.")
                print("🤦🏻‍♂️🤦🏻‍♂️🤦🏻‍♂️🤦🏻‍♂️ Json Mapping Error : 🤦🏻‍♂️🤦🏻‍♂️🤦🏻‍♂️🤦🏻‍♂️ " + error.localizedDescription)
            }
        }
        
        
        let failureClosure:DefaultAPIFailureClosure = {error in
            completionHandler(false, error.localizedDescription)
        }
        
        
        APIManager.sharedInstance.authenticationManagerAPI.serverRequest(parameters: params, type: .post, route: Route.Login.rawValue, success: successClosure, failure: failureClosure)
    }
}

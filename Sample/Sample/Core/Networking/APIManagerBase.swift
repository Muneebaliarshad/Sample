//
//  APIManagerBase.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import UIKit
import Alamofire


class APIManagerBase: NSObject{
    
    //MARK: - Variables
    var alamoFireManager : Session?
    
    
    //MARK: - Init Methods
    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 100
        alamoFireManager = Alamofire.Session(configuration: configuration)
    }
    
    
    //MARK: - URL Creation
    func POSTURLforRoute(route:String) -> URL?{
        
        if let components: NSURLComponents = NSURLComponents(string: (kBaseURL+route)){
            return components.url! as URL
        }
        return nil
    }
    
    func GETURLfor(route:String, parameters: Parameters) -> URL?{
        var queryParameters = ""
        for key in parameters.keys {
            if queryParameters.isEmpty {
                queryParameters =  "?\(key)=\((String(describing: (parameters[key]!))).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
            } else {
                queryParameters +=  "&\(key)=\((String(describing: (parameters[key]!))).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
            }
            queryParameters =  queryParameters.trimmingCharacters(in: .whitespaces)
            
        }
        
        let str = route.replacingOccurrences(of: " ", with: "%20")
        if let components: NSURLComponents = NSURLComponents(string: (kBaseURL+str+queryParameters)){
            return components.url! as URL
        }
        return nil
    }
    
    //MARK: - Header Creation
    func getAuthorizationHeader() -> HTTPHeaders {
        //        if let userdata = UserDefaultsManager.getUserModel() {
        //            if userdata.token == nil || userdata.token == "" {
        //                return ["Content-Type":"application/json"]
        //            } else {
        //                return ["Content-Type": "application/json", "Authorization": "Bearer " + userdata.token.onEmpty]
        //            }
        //        } else {
        //            return ["Content-Type":"application/json"]
        //        }
        return ["Content-Type":"application/json"]
    }
    
    
    //MARK: - Server Requests
    func serverRequestWith(route: URL,
                           parameters: Parameters?,
                           requestType: HTTPMethod,
                           success:@escaping DefaultAPISuccessClosure,
                           failure:@escaping DefaultAPIFailureClosure){
        
        var alamofireRequest: DataRequest?
        
        if requestType == .get {
            alamofireRequest = alamoFireManager?.request(route, method: requestType, encoding: JSONEncoding.default, headers: getAuthorizationHeader())
        } else {
            alamofireRequest = alamoFireManager?.request(route, method: requestType, parameters: parameters, encoding: JSONEncoding.default, headers: getAuthorizationHeader())
        }
        
        
        alamofireRequest?.responseJSON{ response in
            guard response.error == nil else{
                
                self.showRequestDetailForFailure(responseObject: response)
                failure(response.error! as NSError)
                return
            }
            
            if response.value != nil {
                self.showRequestDetailForSuccess(responseObject: response)
                if let jsonResponse = response.value as? Dictionary<String, AnyObject>{
                    success(jsonResponse)
                } else {
                    success(Dictionary<String, AnyObject>())
                }
            }
        }
    }
    
    
    func requestWithMultipart(route: URL,
                              parameters: Parameters,
                              requestType: HTTPMethod,
                              success:@escaping DefaultAPISuccessClosure,
                              failure:@escaping DefaultAPIFailureClosure){
        
        let URLSTR : URLRequestConvertible = try! URLRequest(url: route.absoluteString, method: requestType, headers: getAuthorizationHeader())
        
        alamoFireManager?.upload(multipartFormData: multipartFormData(parameters: parameters), with: URLSTR)
            .uploadProgress(queue: .main, closure: { progress in
                
                print("Uploading Progress: \(String(describing: progress.localizedDescription))")
            })
            .responseJSON(completionHandler: {  response in
                guard response.error == nil else{
                    
                    self.showRequestDetailForFailure(responseObject: response)
                    failure(response.error! as NSError)
                    return;
                }
                if response.value != nil {
                    
                    self.showRequestDetailForSuccess(responseObject: response)
                    if let jsonResponse = response.value as? Dictionary<String, AnyObject>{
                        
                        success(jsonResponse)
                    } else {
                        success(Dictionary<String, AnyObject>())
                    }
                }
            })
    }
    
    
    
    
    fileprivate func multipartFormData(parameters: Parameters) -> MultipartFormData {
        let formData: MultipartFormData = MultipartFormData()
        if let params:[String:AnyObject] = parameters as [String : AnyObject]? {
            for (key , value) in params {
                
                if let data = (value as? Data) {
                    formData.append(data, withName: key, fileName: "\(key).jpeg", mimeType: "image/jpeg")
                } else {
                    formData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            
            return formData
        }
    }
    
    
    // MARK: - Print Result
    func showRequestDetailForSuccess(responseObject response : AFDataResponse<Any>) {
        
#if DEBUG
        print("\n\n\n📲📲📲📲📲 ------- Success Response Start ------- 📲📲📲📲📲\n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request!.allHTTPHeaderFields!)
        print("\n=========   Request Type   ========== \n")
        print("%@",response.request?.httpMethod?.description ?? "")
        if let bodyData : Data = response.request?.httpBody {
            let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
            print("\n=========   Request httpBody   ========== \n" + (bodyString ?? ""))
        } else {
            print("\n=========   Request httpBody   ========== \n" + "Found Request Body Nil")
        }
        
        if let responseData : Data = response.data {
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            print("\n=========   Response Body   ========== \n" + (responseString ?? ""))
        } else {
            print("\n=========   Response Body   ========== \n" + "Found Response Body Nil")
        }
        print("\n=========   Status Code  ========== \n" + (response.response?.statusCode.description ?? ""))
        print("\n📲📲📲📲📲 ------- Success Response End ------- 📲📲📲📲📲\n\n\n")
        
#endif
    }
    
    func showRequestDetailForFailure(responseObject response : AFDataResponse<Any>) {
        
#if DEBUG
        print("\n\n\n📵📵📵📵📵 ------- Failure Response Start ------- 📵📵📵📵📵\n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request?.allHTTPHeaderFields ?? ["":""])
        print("\n=========   Request Type   ========== \n")
        print("%@",response.request?.httpMethod?.description ?? "")
        if let bodyData : Data = response.request?.httpBody {
            let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
            print("\n=========   Request httpBody   ========== \n" + (bodyString ?? ""))
        } else {
            print("\n=========   Request httpBody   ========== \n" + "Found Request Body Nil")
        }
        
        if let responseData : Data = response.data {
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            print("\n=========   Response Body   ========== \n" + (responseString ?? ""))
        } else {
            print("\n=========   Response Body   ========== \n" + "Found Response Body Nil")
        }
        
        print("\n=========   Status Code  ========== \n" + (response.response?.statusCode.description ?? ""))
        print("\n=========   Error Description  ========== \n" + (response.error?.errorDescription ?? ""))
        print("\n=========   Error  ========== \n" + (response.error.debugDescription))
        print("\n📵📵📵📵📵 ------- Failure Response End ------- 📵📵📵📵📵\n\n\n")
        
#endif
    }
}

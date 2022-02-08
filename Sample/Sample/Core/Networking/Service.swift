//
//  Service.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import Foundation
import Alamofire

enum APIString: String {
    case Success = "✅✅✅✅✅"
    case Failure = "❌❌❌❌❌"
}


final class Service: NSObject  {
    
    //MARK: - Properties
    var sessionManager : Session!
    var accessToken:String? = nil
    static let `default` = Service()
    
    
    //MARK: - init
    override init() {
        let configuration = Session.default.session.configuration
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15
        sessionManager = Session(configuration: configuration)
    }
    
    
    func getAuthorizationHeader() -> HTTPHeaders {
        return ["Content-Type":"application/json"]
    }
    
    
    //MARK: - Helper Methods
    func execute<T>(serviceUrl: String, method: HTTPMethod, params: Parameters?, model: T.Type, serviceResponce: @escaping (T?, String, Bool) -> ()) where T : Decodable {
        
        if !(Servers.isConnectedToInternet()){
            serviceResponce(nil, "No Internet", false)
            return
        }
        
        sessionManager.request(serviceUrl, method: method, parameters: params, encoding: JSONEncoding.default, headers: getAuthorizationHeader())
            .validate(statusCode: 200..<209)
//            .responseJSON { (response) in
            .responseDecodable (of: model.self, decoder: JSONDecoder()) { (response) in
                
            switch response.result {
                
            case .success(_):
                self.showAPIRequestDetail(responseObject: response, symbol: APIString.Success.rawValue)
                
                if response.response?.statusCode == 201 || response.response?.statusCode == 200 {
                    do {
                        let jsonDecoder = try JSONDecoder().decode(model , from: response.data!)
                        serviceResponce(jsonDecoder, "", true)
                        
                    } catch {
                        printData("⛔️⛔️⛔️⛔️⛔️   \(error)   ⛔️⛔️⛔️⛔️⛔️")
                        serviceResponce(nil, error.localizedDescription, false)
                    }
                } else {
                    serviceResponce(nil, String(data: response.data ?? Data(), encoding: String.Encoding.utf8) ?? "Please Try Again", false)
                }
                
            case .failure(let error):
                self.showAPIRequestDetail(responseObject: response, symbol: APIString.Failure.rawValue)
                serviceResponce(nil, error.localizedDescription, false)
                
            }
        }
        
    }
    
    
    //MARK: - Print Methods
    func showAPIRequestDetail<T>(responseObject response : DataResponse<T, AFError>, symbol: String) {
        var apiData = Shake.ShakeResponseModel()
        
        printData("\n\n\n\(symbol) ------- Response Start ------- \(symbol)")
        apiData.symbol = symbol
        printData("\n==========     Response Time     ==========")
        apiData.responseTime = response.serializationDuration.description
        printData(response.serializationDuration)
        
        printData("\n==========     URl     ==========")
        apiData.url = response.request?.url?.absoluteString ?? "-----"
        printData(response.request?.url?.absoluteString ?? "-----")
        
        printData("\n==========     HTTPHeaderFields     ==========")
        apiData.requestHeaders = response.request?.allHTTPHeaderFields?.description ?? "-----"
        printData(response.request?.allHTTPHeaderFields?.description ?? "-----")
        
        printData("\n==========     Request Type     ==========")
        apiData.requestType = response.request?.httpMethod?.description ?? "-----"
        printData(response.request?.httpMethod?.description ?? "-----")
        
        printData("\n==========     Status Code     ==========")
        apiData.statusCode = response.response?.statusCode.description ?? "-----"
        printData(response.response?.statusCode ?? "-----")
        
        printData("\n==========     Response Headers Type     ==========")
        apiData.responseHeaders = response.response?.allHeaderFields.description ?? "-----"
        printData(response.response?.allHeaderFields.description ?? "-----")
        
        if let bodyData : Data = response.request?.httpBody {
            let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
            apiData.requestBody = bodyString ?? "-----"
            printData("\n==========     Request HTTPBody     ==========\n" + (bodyString ?? "-----"))
        } else {
            apiData.requestBody = "Found Request Body Nil"
            printData("\n==========     Request HTTPBody     ==========\n" + "Found Request Body Nil")
        }
        
        if let responseData : Data = response.data {
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            apiData.responseData = responseString ?? "-----"
            printData("\n==========     Response Data     ==========\n" + (responseString ?? ""))
        } else {
            apiData.responseData = "Found Response Body Nil"
            printData("\n==========     Response Data     ==========\n" + "Found Response Body Nil")
        }
        
        printData("\n \(symbol) ------- Response End ------- \(symbol) \n\n\n")
        
        Shake.shakeResponse.append(apiData)
    }
}

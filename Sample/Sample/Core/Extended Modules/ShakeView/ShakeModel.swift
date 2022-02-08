//
//  ShakeModel.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import Foundation


enum Shake {
    static var shakeResponse = [ShakeResponseModel]()
    
    struct ShakeResponseModel {
        var symbol = ""
        var responseTime = ""
        var url = ""
        var requestHeaders = ""
        var requestType = ""
        var statusCode = ""
        var responseHeaders = ""
        var requestBody = ""
        var responseData = ""
    }
}

//
//  BreedService.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import Foundation


protocol BreedProtocol {
    func getBreedData(success: @escaping ((_ response: [String: [String]]?) -> ()), failure: @escaping(_ message: String?) -> ())
}

class BreedService: BreedProtocol {
    func getBreedData(success: @escaping (([String: [String]]?) -> ()), failure: @escaping (String?) -> ()) {
        Spinner.shared.showLoader()
        
        Service.default.execute(serviceUrl: Servers.baseURLWith(route: Route.list), method: .get, params: nil, model: Breed.BreedListModel.self) { responseData, message, status in
            
            Spinner.shared.removeLoader()
            if status == true {
                success(responseData?.message)
            }else {
                failure(message)
            }
        }
    }
}

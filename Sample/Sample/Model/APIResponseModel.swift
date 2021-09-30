//
//  APIResponseModel.swift
//  Sample
//
//  Created by Muneeb on 30/09/2021.
//

import Foundation


//MARK: - Model
struct APIResponseModel<T: Decodable>: Decodable {
    var status: String?
    var message: String?
    var validation_status: ValidationResponseModel?
    var data: T?
    var Data: T?
    var trainerData: T?
}


struct ValidationResponseModel: Decodable {
    var error: Bool?
    var fields: [String: String]?
}

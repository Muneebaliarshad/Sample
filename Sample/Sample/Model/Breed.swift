//
//  Breed.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import Foundation

enum Breed {
    struct BreedListModel: Codable {
        var status: String?
        var message: [String: [String]]?
    }
    
    struct BreadName: Codable {
        let name: String?
        let types: [String]?
    }
    
    struct BreedImageListModel: Codable {
        var status: String?
        var message: [String]?
    }
}

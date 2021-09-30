//
//  InAppProduct.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import Foundation

public struct InAppProduct {
    
    public static let ProductID = "12345678"
    private static let productIdentifiers: Set<ProductIdentifier> = ["12345678", "12345678"]
    public static let store = IAPHelper(productIds: InAppProduct.productIdentifiers)
    
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
    return productIdentifier.components(separatedBy: ".").last
}

//
//  String.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import Foundation

extension String {
    
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    
    ///Convert String to URL
    func createURL() -> URL? {
        let urlString  = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        if let url = URL(string: urlString){
            return url
        }
        return  URL(string: "")
    }
}

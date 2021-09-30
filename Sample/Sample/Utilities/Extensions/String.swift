//
//  String.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import Foundation

extension String {

    //MARK: - Variables
    var length: Int {
        return self.count
    }

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }


    //MARK: - Functions
    func fromBase64() -> String {
        let data = Data(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0))
        return String(data: data!, encoding: String.Encoding.utf8)!
    }
    
    
    func toBase64() -> String {
        let data = self.data(using: String.Encoding.utf8)
        return data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
    func createURL() -> URL {
        let urlString  = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        if let url = URL(string: urlString){
            return url
        }
        return  URL(string: "https://webpage.com")!
    }
    
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        let result =  emailPredicate.evaluate(with: self)
        return result
    }
    
    mutating func replaceFirstOccurrence(original: String, with newString: String) {
        if let range = self.range(of: original) {
            replaceSubrange(range, with: newString)
        }
    }
    
    func replace(_ with: String, at index: Int) -> String {
        var modifiedString = String()
        for (i, char) in self.enumerated() {
            modifiedString += String((i == index) ? with : String(char))
        }
        return modifiedString
    }
}

//
//  NSObject.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}

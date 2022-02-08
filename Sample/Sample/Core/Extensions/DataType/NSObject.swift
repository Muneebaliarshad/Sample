//
//  NSObject.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}

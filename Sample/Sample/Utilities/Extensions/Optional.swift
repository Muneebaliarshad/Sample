//
//  Optional.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import Foundation


extension Optional where Wrapped == String {
    var onEmpty: String {
        return self ?? ""
    }
}


extension Optional where Wrapped == Bool {
    var onEmpty: Bool {
        return self ?? false
    }
}

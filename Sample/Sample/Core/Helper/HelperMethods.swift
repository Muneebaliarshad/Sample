//
//  HelperMethods.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import Foundation
import UIKit
import Alamofire


//MARK: - Localizable
public protocol Localizable {
    var localized: String { get }
}

func printData(_ object: Any) {
#if DEBUG
    Swift.print(object)
#elseif RELEASE
    Swift.print(object)
#endif
}


func deviceUUID() -> String {
    return UIDevice.current.identifierForVendor?.uuidString ?? ""
}

func getScreenWidth() -> CGFloat {
    return UIScreen.main.bounds.width
}

func getScreenHeight() -> CGFloat {
    return UIScreen.main.bounds.height
}

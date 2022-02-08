//
//  UIFont.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

extension UIFont {
    
    public enum FontStyle: String {
        case Regular = "-Regular"
        case Medium = "-Medium"
        case SemiBold = "-SemiBold"
        case Bold = "-Bold"
    }
    
    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }
    
    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
    
    
    static func Poppins(_ type: FontStyle = .Regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Poppins\(type.rawValue)", size: size)!
    }
}

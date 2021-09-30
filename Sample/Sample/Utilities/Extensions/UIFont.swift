//
//  UIFont.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import UIKit

extension UIFont {

    public enum FontStyle: String {
        case Book = "-Book"
        case Bold = "-Bold"
    }

    static func CircularStd(_ type: FontStyle = .Book, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "CircularStd\(type.rawValue)", size: size)!
    }

    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }

    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }

}

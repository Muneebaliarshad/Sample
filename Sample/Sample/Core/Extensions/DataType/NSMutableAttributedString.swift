//
//  NSMutableAttributedString.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

extension NSMutableAttributedString {
    var fontSize:CGFloat { return 14 }
    var boldFont:UIFont { return UIFont(name: "CircularStd-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 25) }
    var normalFont:UIFont { return UIFont(name: "CircularStd-Book", size: 17) ?? UIFont.systemFont(ofSize: 15)}
    
    func bold(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    /* Other styling methods */
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func underlined(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  boldFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func alighCenter() -> NSMutableAttributedString {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        var color = UIColor()
        
        if #available(iOS 13.0, *) {
            color = UIColor.label
        } else {
            color = UIColor.black
        }
        
        let attributes1: [NSAttributedString.Key : Any] = [
            .paragraphStyle: paragraph,
            .foregroundColor: color
        ]
        
        self.addAttributes(attributes1, range: NSRange(location: 0, length: self.length))
        return self
    }
    
    func textColor() -> NSMutableAttributedString {
        let color = UIColor.white
        
        let attributes1: [NSAttributedString.Key : Any] = [
            .foregroundColor: color
        ]
        
        self.addAttributes(attributes1, range: NSRange(location: 0, length: self.length))
        return self
    }
}

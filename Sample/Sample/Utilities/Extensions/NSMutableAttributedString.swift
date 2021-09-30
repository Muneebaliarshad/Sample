//
//  NSMutableAttributedString.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import Foundation
import UIKit


extension NSMutableAttributedString {
    var fontSize:CGFloat { return 14 }
    var boldFont:UIFont { return UIFont(name: "CircularStd-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20) }
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
    
    func blackHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black
            
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
    
    
    func alignRight() -> NSMutableAttributedString {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .right
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
    
    func alighLeft() -> NSMutableAttributedString {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
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

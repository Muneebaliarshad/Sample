//
//  TextView.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

class TextView: UITextView {
    
    init(text : String , textColor : UIColor , font : UIFont, textAlignment: NSTextAlignment = .natural) {
        super.init(frame: .zero, textContainer: nil)
        translatesAutoresizingMaskIntoConstraints = false
        self.textColor = textColor
        self.font = UIFont(name: (font.fontName), size: CGFloat(Int(font.pointSize).autoSized))
        self.textAlignment = .natural
        self.backgroundColor = .clear
        self.layer.cornerRadius = 10.autoSized
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

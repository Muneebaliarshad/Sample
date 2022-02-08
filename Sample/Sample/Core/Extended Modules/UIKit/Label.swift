//
//  Label.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

final class Label : UILabel {
    
    //MARK: - Init Methods
    init(textKey: String, textcolor: UIColor, font: UIFont, alignment: NSTextAlignment = .natural) {
        super.init(frame: .zero)
        self.text = textKey.localized
        self.textColor = textcolor
        self.font = UIFont(name: (font.fontName), size: CGFloat(Int(font.pointSize).autoSized))
        self.textAlignment = alignment
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

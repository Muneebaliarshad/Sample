//
//  Button.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

final class Button: UIButton {
    
    //MARK: - Init Methods
    required init(textKey: String!, font: UIFont ,backgroundColor: UIColor ,textColor: UIColor = .white, alignment: ContentHorizontalAlignment = .center, cornerRadius: CGFloat = 0.0, imageName: String = "") {
        super.init(frame: .zero)
        super.translatesAutoresizingMaskIntoConstraints = false
        
        setTitle(textKey.localized, for: .normal)
        titleLabel?.font = UIFont(name: (font.fontName), size: CGFloat(Int(font.pointSize).autoSized))
        layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        setTitleColor(textColor, for: .normal)
        contentHorizontalAlignment = alignment
        
        if imageName != "" {
            if #available(iOS 13.0, *) {
                titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
                setImage(UIImage(named: imageName)!, for: .normal)
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

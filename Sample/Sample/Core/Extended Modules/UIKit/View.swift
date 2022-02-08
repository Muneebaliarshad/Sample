//
//  View.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

final class View: UIView {
    
    //MARK: - Init Methods
    required init(backgroundColor: UIColor, cornerRadius: CGFloat = 0.0) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

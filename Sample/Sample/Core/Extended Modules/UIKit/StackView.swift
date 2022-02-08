//
//  File.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit


class StackView: UIStackView {
    
    required init(backgroundColor: UIColor = UIColor.clear, cornerRadius: CGFloat = 0, distribution: UIStackView.Distribution = .fillEqually, spacing: CGFloat = 0.0, axis: NSLayoutConstraint.Axis ) {
        super.init(frame: .zero)
        super.translatesAutoresizingMaskIntoConstraints = false
        self.spacing = spacing
        self.distribution = distribution
        self.backgroundColor = backgroundColor
        self.axis = axis
        self.layer.cornerRadius = cornerRadius
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

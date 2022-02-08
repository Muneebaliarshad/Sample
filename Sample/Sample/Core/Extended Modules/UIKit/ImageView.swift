//
//  ImageView.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

final class ImageView: UIImageView {
    
    //MARK: - Init Methods
    required init(imageName: String = "Logo", cornerRadius: CGFloat = 0.0, backgroundColor: UIColor = .clear) {
        super.init(frame: .zero)
        super.translatesAutoresizingMaskIntoConstraints = false
        
        image = UIImage(named: imageName)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.contentMode = .scaleAspectFit
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

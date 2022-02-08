//
//  UICollectionView.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit


extension UICollectionView {
    func setEmptyView(title: String, message: String, messageImage: UIImage) {
        
        ///Initilization
        let emptyView = UIView(frame: self.frame)
        let imageView = UIImageView()
        let titleLabel = UILabel()
        let descriptionLabel = UILabel()
        
        
        ///Attribute Setting
        titleLabel.textColor = .white
        titleLabel.font = .Poppins(.Bold, size: 25)
        
        descriptionLabel.textColor = .white
        descriptionLabel.font = .Poppins(.Regular, size: 15)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
        imageView.contentMode = .scaleAspectFit
        
        ///Add As Subview
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(imageView)
        emptyView.addSubview(descriptionLabel)
        
        
        ///Applying Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: getScreenWidth() - 100).isActive = true
        
        
        
        ///Assigning Values
        imageView.image = messageImage
        titleLabel.text = title.localized
        descriptionLabel.text = message.localized
        
        self.backgroundView = emptyView
    }
    
    
    
    func restore() {
        self.backgroundView = nil
    }
}

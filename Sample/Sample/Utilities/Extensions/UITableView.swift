//
//  UITableView.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import UIKit

extension UITableView {
    
    func registerCell(identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func scrollToTop() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1, section:  self.numberOfSections-1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    func scrollToSelectedRow(selectedRow: Int, selectedSection: Int) {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: selectedRow, section: selectedSection)
            self.scrollToRow(at: indexPath, at: .none, animated: false)
        }
    }
    
    func setEmptyView(title: String, message: String, messageImage: UIImage) {
        
        ///Initilization
        let emptyView = UIView(frame: self.frame)
        let imageView = UIImageView()
        let titleLabel = UILabel()
        let descriptionLabel = UILabel()
        
        
        ///Attribute Setting
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.CircularStd(.Bold, size: 25)
        
        descriptionLabel.textColor = UIColor.lightGray
        descriptionLabel.font = UIFont.CircularStd(size: 20)
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
        imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: getScreenWidth() - 100).isActive = true
        
        
        
        ///Assigning Values
        imageView.image = messageImage
        titleLabel.text = title
        descriptionLabel.text = message
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

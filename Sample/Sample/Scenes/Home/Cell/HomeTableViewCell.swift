//
//  HomeTableViewCell.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

final class HomeTableViewCell: TableViewCell {

    //MARK: - UIElements
    let dataView = View(backgroundColor: .gray, cornerRadius: 20)
    let nameLabel = Label(textKey: "Breed_Name", textcolor: .white, font: .Poppins(.Regular, size: 18))
    let subTypeLabel = Label(textKey: "Sub_Breed", textcolor: .white, font: .Poppins(.Bold, size: 15))
    let subTypeNameLabel = Label(textKey: "Sub_Breed", textcolor: .white, font: .Poppins(.Regular, size: 13))
    let arrowImageView = ImageView(imageName: "RightArrow")
    
    
    
    //MARK: - Nib Methods
    override func setViewUI() {
        addElementsToView()
    }
    
    fileprivate func addElementsToView() {
        addSubview(dataView)
        dataView.addSubview(nameLabel)
        dataView.addSubview(subTypeLabel)
        dataView.addSubview(subTypeNameLabel)
        dataView.addSubview(arrowImageView)
        
        NSLayoutConstraint.activate([
            
            ///dataView
            dataView.topAnchor.constraint(equalTo: topAnchor, constant: 10.autoSized),
            dataView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.autoSized),
            dataView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30.autoSized),
            dataView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30.autoSized),
            
            ///titleLabel
            nameLabel.topAnchor.constraint(equalTo: dataView.topAnchor, constant: 10.autoSized),
            nameLabel.leadingAnchor.constraint(equalTo: dataView.leadingAnchor, constant: 15.autoSized),
            nameLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -10.autoSized),
            
            ///subTypeLabel
            subTypeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5.autoSized),
            subTypeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            subTypeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            ///subTypeNameLabel
            subTypeNameLabel.topAnchor.constraint(equalTo: subTypeLabel.bottomAnchor, constant: 5.autoSized),
            subTypeNameLabel.bottomAnchor.constraint(equalTo: dataView.bottomAnchor, constant: -10.autoSized),
            subTypeNameLabel.leadingAnchor.constraint(equalTo: subTypeLabel.leadingAnchor, constant: 20.autoSized),
            subTypeNameLabel.trailingAnchor.constraint(equalTo: subTypeLabel.trailingAnchor),
            
            
            ///arrowImageView
            arrowImageView.centerYAnchor.constraint(equalTo: dataView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: dataView.trailingAnchor, constant: -20),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        dataView.shadow(color: .black.withAlphaComponent(0.5))
    }
    
    
    //MARK: - Setup Method
    func setUI(data: Breed.BreadName) {
        nameLabel.text = data.name?.capitalized
        if (data.types?.count ?? 0) > 0 {
            subTypeNameLabel.text = data.types?.joined(separator: ", ").capitalized
            
        } else {
            subTypeNameLabel.text = "----"
        }
    }
}

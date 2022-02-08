//
//  SplashViewController.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

final class SplashViewController: BaseViewController {

    //MARK: - UIElements
    let logoImageView = ImageView(imageName: "Logo")
    
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .themeColor
    }
    
    //MARK: - Setup Methods
    override func setViewUI() {
        addElementsToView()
        logoImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        let options: UIView.AnimationOptions = [.curveLinear]
        UIView.animate(withDuration: 2.0, delay: 0, options: options, animations: { [weak self] in
            self?.logoImageView.transform = .identity
        }) { result in
            NavigationManager().navigateToHome()
        }
        
    }
    
    fileprivate func addElementsToView() {
        view.addSubview(logoImageView)
        applyConstraints()
    }
    
    fileprivate func applyConstraints() {
        NSLayoutConstraint.activate([
            
            ///logoImageView
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            logoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
        ])
    }
    
}

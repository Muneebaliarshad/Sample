//
//  Spinner.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

final class Spinner: NSObject {
    
    //MARK: - UIElements
    private let blurView = View(backgroundColor: .black.withAlphaComponent(0.7))
    private let smallView = View(backgroundColor: .white.withAlphaComponent(0.5), cornerRadius: 20)
    private let activityIndicator: UIActivityIndicatorView = {
        let aiView = UIActivityIndicatorView()
        aiView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            aiView.style = .large
        } else {
            aiView.style = .gray
        }
        aiView.color = .themeColor
        return aiView
    }()
    
    
    //MARK: - Variables
    static let shared = Spinner()
    
    //MARK: - Heler Methods
    fileprivate func setView(view: UIView) {
        ///add Views
        view.addSubview(blurView)
        view.addSubview(smallView)
        smallView.addSubview(activityIndicator)
        
        
        ///Constraints
        NSLayoutConstraint.activate([
            
            ///blurView
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            ///smallView
            smallView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smallView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            smallView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13),
            smallView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.29),
            
            ///activityIndicator
            activityIndicator.centerXAnchor.constraint(equalTo: smallView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: smallView.centerYAnchor)
        ])
        
        
        ///attributes
        activityIndicator.transform = CGAffineTransform(scaleX: CGFloat(1.4).autoSized, y: CGFloat(1.4).autoSized)
        activityIndicator.startAnimating()
    }
    
    
    ///Show Loader
    func showLoader(onView: UIView? = nil) {
        if let view = onView {
            setView(view: view)
            
        } else {
            let topController = UIApplication.getTopViewController()
            setView(view: topController?.view ?? UIView())
        }
        
    }
    
    ///Remove Loader
    func removeLoader() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.blurView.removeFromSuperview()
            self.smallView.removeFromSuperview()
            self.activityIndicator.removeFromSuperview()
        }
    }
}

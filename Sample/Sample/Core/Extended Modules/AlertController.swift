//
//  AlertController.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

enum AlertImage : String {
    case success = "success"
    case alert = "alert"
    case warning = "warning"
    case delete = "deletePopup"
    case decision = "decision"
    case logoImage = "LogoText"
}

enum DefaultButton : String {
    case none = "none"
    case no = "No"
    case yes = "Yes"
    case ok = "OK"
    case continuee = "Continue"
}

enum DestructiveButton : String {
    case none = "none"
    case no = "No"
    case yes = "Yes"
    case ok = "OK"
    case continuee = "Continue"
}


protocol AlertControllerDelegate : AnyObject {
    func destructiveButtonPressed()
    func defaultButtonPressed()
}

class AlertController: UIViewController {
    
    //MARK:-UIElement
    let blurView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.backgroundColor = .clear
        view.alpha = 0
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let alertView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20.autoSized
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let headingLabel: Label = Label(textKey: "Alert", textcolor: .black, font: .Poppins(.Bold, size: 20), alignment: .center)
    let descriptionLabel: Label = Label(textKey: "Description Here", textcolor: .black, font: .Poppins(.Bold, size: 15), alignment: .center)
    
    let defaultButton : Button = {
        let button = Button(textKey: "Default", font: .Poppins(.Bold, size: 15), backgroundColor: .themeColor, textColor: .white, cornerRadius: 10.autoSized)
        button.addTarget(self, action: #selector(defaultButtonPressed), for: .touchUpInside)
        return button
    }()
    let destructiveButton: Button = {
        let button = Button(textKey: "destructive", font: .Poppins(.Bold, size: 15), backgroundColor: .black, textColor: .white, cornerRadius: 10.autoSized)
        button.addTarget(self, action: #selector(destructiveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let stackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.spacing = 15.autoSized
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    //MARK:-Properties
    weak var delegate : AlertControllerDelegate? = nil
    
    //MARK:-Override methods
    init(title: String, message: String, image: AlertImage , defaultButton : DefaultButton , destructiveButton: DestructiveButton) {
        super.init(nibName: nil, bundle: nil)
        headingLabel.text = title
        descriptionLabel.text = message
        imageView.image = UIImage(named: image.rawValue)
        
        
        if destructiveButton != .none {
            self.destructiveButton.setTitle(destructiveButton.rawValue, for: .normal)
            stackView.addArrangedSubview(self.destructiveButton)
        }
        if defaultButton != .none {
            self.defaultButton.setTitle(defaultButton.rawValue, for: .normal)
            stackView.addArrangedSubview(self.defaultButton)
        }
        
        generateHeptic(option: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
    }
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.blurView.alpha = 0.6
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showAlertView()
    }
    
    func setupViews(){
        view.addSubview(blurView)
        view.addSubview(alertView)
        alertView.addSubview(imageView)
        alertView.addSubview(headingLabel)
        alertView.addSubview(descriptionLabel)
        alertView.addSubview(stackView)
        
        defaultButton.heightAnchor.constraint(equalToConstant: 40.autoSized).isActive = true
        destructiveButton.heightAnchor.constraint(equalToConstant: 40.autoSized).isActive = true
        NSLayoutConstraint.activate([
            ///BlurView
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            ///AlertView
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            ///ImageView
            imageView.widthAnchor.constraint(equalToConstant: 40.autoSized),
            imageView.heightAnchor.constraint(equalToConstant: 40.autoSized),
            imageView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 40.autoSized),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ///HeadingLabel
            headingLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6.autoSized),
            headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ///DescriptionLabel
            descriptionLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 50.widthRatio),
            descriptionLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -50.widthRatio),
            descriptionLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 6.autoSized),
            
            ///StackView
            stackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 14.widthRatio),
            stackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -14.widthRatio),
            stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50.autoSized),
            stackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -14.autoSized),
            
        ])
    }
    
    func showAlertView() {
        alertView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, options: .transitionCrossDissolve) {
            self.alertView.transform = .identity
        }
        
    }
    
    @objc func hideAlertView() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.alertView.alpha = 0
            self.blurView.alpha = 0
        }
    }
    
    func generateHeptic(option: AlertImage) {
        let generator = UINotificationFeedbackGenerator()
        switch option {
        case .alert:
            generator.notificationOccurred(.error)
        case .success:
            generator.notificationOccurred(.success)
        case .warning , .delete , .decision:
            generator.notificationOccurred(.warning)
        case .logoImage:
            break
        }
    }
    
    //MARK:-Selectors
    @objc func destructiveButtonPressed() {
        hideAlertView()
        self.dismiss(animated: false) { [weak self] in
            guard let self = self else { return }
            if let delegate = self.delegate {
                delegate.destructiveButtonPressed()
            }
        }
    }
    
    @objc func defaultButtonPressed() {
        hideAlertView()
        self.dismiss(animated: false) { [weak self] in
            guard let self = self else { return }
            if let delegate = self.delegate {
                delegate.defaultButtonPressed()
            }
        }
    }
    
}

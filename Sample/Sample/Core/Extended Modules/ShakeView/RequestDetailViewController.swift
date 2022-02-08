//
//  RequestDetailViewController.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

final class RequestDetailViewController: BaseViewController {
    
    //MARK: - UI-Elements
    let serviceTextView : TextView = {
        let textView = TextView(text: "test", textColor: .white, font: .systemFont(ofSize: 20), textAlignment: .justified)
        textView.isEditable = false
        textView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        return textView
    }()
    let backButton : Button = {
        let button = Button(textKey: "Back", font: .systemFont(ofSize: 20), backgroundColor: .clear, textColor: .white, cornerRadius: 25)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.borderWidth = 2
        button.borderColor = .themeColor
        return button
        
    }()
    
    let copyButton : Button = {
        let button = Button(textKey: "Copy", font: .systemFont(ofSize: 20), backgroundColor: .clear, textColor: .white, cornerRadius: 25)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.borderWidth = 2
        button.borderColor = .themeColor
        return button
    }()
    
    lazy var stackView : StackView = {
        let stackView = StackView(backgroundColor: .clear, cornerRadius: 0, distribution: .fillEqually, spacing: 5, axis: .horizontal)
        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(copyButton)
        return stackView
    }()
    
    
    //MARK: - Override Methods
    let serviceDetail: Shake.ShakeResponseModel
    
    init(serviceDetail: Shake.ShakeResponseModel) {
        self.serviceDetail = serviceDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setViewUI() {
        view.addSubview(serviceTextView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            ///serviceDetailTextView
            serviceTextView.topAnchor.constraint(equalTo: view.topAnchor),
            serviceTextView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -10.autoSized),
            serviceTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            serviceTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            ///stackView
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5.autoSized),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.autoSized),
            stackView.heightAnchor.constraint(equalToConstant: 50.autoSized),
        ])
        
        serviceTextView.attributedText = getDetailText()
    }
    
    func getDetailText() -> NSMutableAttributedString {
        return NSMutableAttributedString()
            .bold("\n\(serviceDetail.symbol)")
            .bold("\n------- Response Start -------\n")
            .underlined("\nResponse Time: \n     ")
            .normal(serviceDetail.responseTime)
            .underlined("\n\n URL: \n     ")
            .normal(serviceDetail.url)
            .underlined("\n\n HTTPHeaderFields: \n     ")
            .normal(serviceDetail.requestHeaders)
            .underlined("\n\n Request Type: \n     ")
            .normal(serviceDetail.requestType)
            .underlined("\n\n Status Code: \n     ")
            .normal(serviceDetail.statusCode)
            .underlined("\n\n Response Headers Type: \n     ")
            .normal(serviceDetail.responseHeaders)
            .underlined("\n\n Request HTTPBody: \n     ")
            .normal(serviceDetail.requestBody)
            .underlined("\n\n Response Data: \n     ")
            .normal(serviceDetail.responseData)
            .bold("\n\n------- Response End -------")
            .bold("\n\(serviceDetail.symbol)")
            .textColor()
    }
    
    //MARK: - Selectors
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func copyButtonPressed() {
        UIPasteboard.general.string = serviceTextView.text
        copyButton.setTitle("Copied", for: .normal)
        copyButton.setTitleColor(.themeColor, for: .normal)
    }
}

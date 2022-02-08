//
//  ShakeViewController.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

final class ShakeViewController: BaseViewController {
    
    //MARK: - UI-Elements
    let topContainerView: View = View(backgroundColor: .themeColor, cornerRadius: 0)
    let appNameLabel = Label(textKey: "App Name", textcolor: .white, font: .boldSystemFont(ofSize: 30), alignment: .center)
    let versionNumberLabel = Label(textKey: "Version 0.0.0 (0)", textcolor: .black, font: .systemFont(ofSize: 15), alignment: .center)
    let baseUrlLabel = Label(textKey: "https://", textcolor: .black, font: .systemFont(ofSize: 15), alignment: .center)
    
    let exitButton : Button = {
        let button = Button(textKey: "Exit", font: .systemFont(ofSize: 20), backgroundColor: .clear, textColor: .white, cornerRadius: 25)
        button.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
        button.borderWidth = 2
        button.borderColor = .themeColor
        return button
    }()
    
    let clearResponseButton : Button = {
        let button = Button(textKey: "Clear_Responses", font: .systemFont(ofSize: 20), backgroundColor: .clear, textColor: .white, cornerRadius: 25)
        button.addTarget(self, action: #selector(clearResponseButtonPressed), for: .touchUpInside)
        button.borderWidth = 2
        button.borderColor = .themeColor
        return button
    }()
    
    lazy var stackView : StackView = {
        let sv = StackView(backgroundColor: .clear, cornerRadius: 0, distribution: .fillEqually, spacing: 5, axis: .horizontal)
        sv.addArrangedSubview(exitButton)
        sv.addArrangedSubview(clearResponseButton)
        return sv
    }()
    lazy var tableView : TableView = {
        let tv = TableView()
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .singleLine
        tv.separatorColor = .themeColor
        return tv
    }()
    
    //MARK: - Properties
    
    
    //MARK: - OVerride Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setViewUI() {
        addElementsToView()
        setUIData()
    }
    
    fileprivate func addElementsToView() {
        view.addSubview(topContainerView)
        topContainerView.addSubview(appNameLabel)
        topContainerView.addSubview(versionNumberLabel)
        topContainerView.addSubview(baseUrlLabel)
        view.addSubview(tableView)
        view.addSubview(stackView)
        applyConstraints()
    }
    
    fileprivate func applyConstraints() {
        NSLayoutConstraint.activate([
            
            ///topContainerView
            topContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            topContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            ///appNameLabel
            appNameLabel.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 15.autoSized),
            appNameLabel.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            
            ///versionNumberLabel
            versionNumberLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 5.autoSized),
            versionNumberLabel.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            
            ///baseUrlLabel
            baseUrlLabel.topAnchor.constraint(equalTo: versionNumberLabel.bottomAnchor, constant: 5.autoSized),
            baseUrlLabel.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: -10.autoSized),
            baseUrlLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
            baseUrlLabel.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
            
            ///tableView
            tableView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 10.autoSized),
            tableView.bottomAnchor.constraint(equalTo: stackView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            ///stackView
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5.autoSized),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.autoSized),
            stackView.heightAnchor.constraint(equalToConstant: 50.autoSized),
            
        ])
    }
    
    //MARK: - Setup Methods
    func setUIData() {
        baseUrlLabel.text = Servers.baseUrl()
        versionNumberLabel.text = Bundle.getFullVersion()
        appNameLabel.text = Bundle.appName()
    }
    
    
    //MARK: - Selectors
    @objc func exitButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func clearResponseButtonPressed() {
        Shake.shakeResponse.removeAll()
        tableView.reloadData()
    }
}


//MARK: - UITableViewDataSource
extension ShakeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Shake.shakeResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.text = Shake.shakeResponse[indexPath.row].url
        
        return cell
    }
}


//MARK: - UITableViewDelegate
extension ShakeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = RequestDetailViewController(serviceDetail: Shake.shakeResponse[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
}

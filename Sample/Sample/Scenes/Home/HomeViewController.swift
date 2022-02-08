//
//  HomeViewController.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

final class HomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - UIElements
    var tableView : TableView = {
        let tv = TableView()
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tv.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return tv
    }()
    
    
    //MARK: - Variables
    var homeVM = HomeViewModel()
    
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bread_Names_List".localized
        tableView.setEmptyView(title: "Please_Wait", message: "Data_Is_Loading", messageImage: UIImage(named: "Loading")!)
        homeVM.getBreedList()
    }
    
    
    //MARK: - Setup Methods
    override func setViewUI() {
        tableView.dataSource = self
        tableView.delegate = self
        addElementsToView()
    }
    
    
    override func bindViews() {
        homeVM.errorMessage.bind { message in
            self.showAlert(title: "alert", message: message, image: .logoImage, defaultButton: .ok, destructiveButton: .none)
        }
        
        homeVM.breedListSuccues.bind { _ in
            if self.homeVM.breedListData.count == 0 {
                self.tableView.setEmptyView(title: "No_Result_Found", message: "Try_Again", messageImage: UIImage(named: "NoData")!)
                
            } else {
                self.tableView.restore()
                self.tableView.reloadData()
            }
        }
    }
    
    
    //MARK: - Helper Methods
    fileprivate func addElementsToView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            ///homeTableView
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM.breedListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        cell.setUI(data: homeVM.breedListData[indexPath.row])
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

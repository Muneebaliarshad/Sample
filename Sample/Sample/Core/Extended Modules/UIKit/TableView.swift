//
//  TableView.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit


class TableView: UITableView {
    
    //MARK: - Init Methods
    required init() {
        super.init(frame: .zero, style: .plain)
        super.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        separatorStyle = .none
        contentInsetAdjustmentBehavior = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class TableViewCell: UITableViewCell{
    static var identifier: String {
        return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewUI() {
    }
}

//
//  MainView.swift
//  AvitoTestTask
//
//  Created by admin on 17.10.2022.
//

import Foundation
import UIKit

final class EmployeeListView: UIView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "LIST OF EMPLOYEES"
        return label
    }()
    
    private(set) var listOfEmployeesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
        addSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func addSubviews() {
        [headerLabel, listOfEmployeesTableView].forEach { subview in addSubview(subview) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 60),
            
            listOfEmployeesTableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8),
            listOfEmployeesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listOfEmployeesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listOfEmployeesTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

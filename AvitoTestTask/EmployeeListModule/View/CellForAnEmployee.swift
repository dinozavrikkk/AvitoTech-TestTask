//
//  CellForAnEmployee.swift
//  AvitoTestTask
//
//  Created by admin on 17.10.2022.
//

import Foundation
import UIKit

final class CellForAnEmployee: UITableViewCell {
    
    private let employeesNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let employeesPhoneNumberLabel: UILabel = {
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.textColor = .white
        phoneNumberLabel.font = .boldSystemFont(ofSize: 15)
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        return phoneNumberLabel
    }()
    
    private let employeesSkillsLabel: UILabel = {
        let skillsLabel = UILabel()
        skillsLabel.textColor = .white
        skillsLabel.font = .boldSystemFont(ofSize: 15)
        skillsLabel.numberOfLines = 0
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        return skillsLabel
    }()
    
    private let employeesPhotoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.contentMode = .scaleToFill
        photoImageView.layer.cornerRadius = 60
        photoImageView.clipsToBounds = true
        photoImageView.image = UIImage(named: "avatar")
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        return photoImageView
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        [employeesNameLabel, employeesPhoneNumberLabel, employeesSkillsLabel].forEach { stack.addArrangedSubview($0) }
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func addSubviews() {
        [employeesPhotoImageView, verticalStack].forEach { subview in contentView.addSubview(subview) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            employeesPhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            employeesPhotoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            employeesPhotoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            employeesPhotoImageView.heightAnchor.constraint(equalToConstant: 120),
            employeesPhotoImageView.widthAnchor.constraint(equalToConstant: 120),
            
            verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            verticalStack.leadingAnchor.constraint(equalTo: employeesPhotoImageView.trailingAnchor, constant: 8),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            verticalStack.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func updateCell(data: Employee) {
        employeesNameLabel.text = data.name
        employeesPhoneNumberLabel.text = "Phone number: \(data.phoneNumber)"
        if data.skills.count > 1 {
            employeesSkillsLabel.text = "Skills: \(data.skills.map({ "\($0)" }).joined(separator: ", "))"
        } else if data.skills.count == 1 {
            employeesSkillsLabel.text = "Skills: \(data.skills[0])"
        } else {
            employeesSkillsLabel.text = "No data available"
        }
    }
}

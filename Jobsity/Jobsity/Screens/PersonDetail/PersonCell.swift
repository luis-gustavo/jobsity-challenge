//
//  PersonCell.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/01/22.
//

import UIKit

final class PersonCell: UITableViewCell {
    
    // MARK: - View Properties
    private let personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.cornerRadius = 20
        return imageView
    }()
    
    private let personNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CodableView extension
extension PersonCell: ViewCodable {
    func buildViewHierarchy() {
        contentView.addSubviews([personImageView, personNameLabel])
    }
    
    func setupConstraints() {
        personImageView.setupConstraints { view in
            [
                view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                view.heightAnchor.constraint(equalToConstant: 40),
                view.widthAnchor.constraint(equalToConstant: 40)
            ]
        }
        
        personNameLabel.setupConstraints { view in
            [
                view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                view.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 8),
                view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
            ]
        }
    }
    
    func setupAdditionalConfiguration() { }
}

// MARK: - Internal methods
extension PersonCell {
    func configureWith(name: String, image: String) {
        self.personNameLabel.text = name
        self.personImageView.downloaded(from: image)
    }
}

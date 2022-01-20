//
//  TVShowCell.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

final class TVShowCell: UITableViewCell {
    
    // MARK: - View Properties
    private let tvShowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.cornerRadius = 20
        return imageView
    }()
    
    private let tvShowNameLabel: UILabel = {
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
extension TVShowCell: ViewCodable {
    func buildViewHierarchy() {
        contentView.addSubviews([tvShowImageView, tvShowNameLabel])
    }
    
    func setupConstraints() {
        tvShowImageView.setupConstraints { view in
            [
                view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                view.heightAnchor.constraint(equalToConstant: 40),
                view.widthAnchor.constraint(equalToConstant: 40)
            ]
        }
        
        tvShowNameLabel.setupConstraints { view in
            [
                view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                view.leadingAnchor.constraint(equalTo: tvShowImageView.trailingAnchor, constant: 8),
                view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
            ]
        }
    }
    
    func setupAdditionalConfiguration() { }
}

// MARK: - Internal methods
extension TVShowCell {
    func configureWith(name: String, image: String) {
        self.tvShowNameLabel.text = name
        self.tvShowImageView.downloaded(from: image)
    }
}

//
//  LocalAuthView.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/01/22.
//

import Foundation

import UIKit

final class LocalAuthView: UIView {
    
    // MARK: - Properties
    private let errorDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Inits
    init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CodableView extension
extension LocalAuthView: ViewCodable {
    func buildViewHierarchy() {
        addSubviews([errorDescriptionLabel])
    }
    
    func setupConstraints() {
        errorDescriptionLabel.setupConstraints { view in
            [
                view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
                view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
            ]
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}

// MARK: - Internal methods
extension LocalAuthView {
    func setupErrorDescription(_ errorDescription: String) {
        self.errorDescriptionLabel.text = errorDescription
    }
}

//
//  SetupAuthView.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/01/22.
//

import UIKit

protocol SetupAuthViewDelegate: AnyObject {
    func didChangeLocalAuth(_ enabled: Bool)
}

final class SetupAuthView: UIView {
    
    // MARK: - Properties
    weak var delegate: SetupAuthViewDelegate?
    private var isAuthEnabled: Bool
    
    // MARK: - View Properties
    private let isAuthEnabledLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "\(Localizable.isAuthenticationEnabled.localized):"
        return label
    }()
    
    private lazy var isAuthEnabledSwitch: UISwitch = {
        let `switch` = UISwitch()
        `switch`.isOn = isAuthEnabled
        `switch`.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        return `switch`
    }()
    
    // MARK: - Inits
    init(isAuthEnabled: Bool) {
        self.isAuthEnabled = isAuthEnabled
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CodableView extension
extension SetupAuthView: ViewCodable {
    func buildViewHierarchy() {
        addSubviews([isAuthEnabledLabel, isAuthEnabledSwitch])
    }
    
    func setupConstraints() {

        isAuthEnabledLabel.setupConstraints { view in
            [
                view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: isAuthEnabledSwitch.leadingAnchor, constant: -20)
            ]
        }
        
        isAuthEnabledSwitch.setupConstraints { view in
            [
                view.centerYAnchor.constraint(equalTo: isAuthEnabledLabel.centerYAnchor),
                view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                view.heightAnchor.constraint(equalToConstant: view.intrinsicContentSize.height),
                view.widthAnchor.constraint(equalToConstant: view.intrinsicContentSize.width)
            ]
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}

// MARK: - Targets
private extension SetupAuthView {
    @objc
    func switchValueDidChange(_ sender: UISwitch) {
        self.isAuthEnabled = sender.isOn
        self.delegate?.didChangeLocalAuth(isAuthEnabled)
    }
}

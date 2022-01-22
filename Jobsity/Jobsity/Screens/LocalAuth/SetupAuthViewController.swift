//
//  SetupAuthViewController.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/01/22.
//

import UIKit

final class SetupAuthViewController: UIViewController {
    
    // MARK: - Properties
    private let localAuthProvider: LocalAuthProviderProtocol
    
    // MARK: - View Properties
    private lazy var setupAuthView: SetupAuthView = {
        let view = SetupAuthView(isAuthEnabled: localAuthProvider.isLocalAuthEnabled)
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(localAuthProvider: LocalAuthProviderProtocol) {
        self.localAuthProvider = localAuthProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LoadView
    override func loadView() {
        self.view = setupAuthView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.authentication.localized
    }
}

// MARK: -
extension SetupAuthViewController: SetupAuthViewDelegate {
    func didChangeLocalAuth(_ enabled: Bool) {
        localAuthProvider.setIsLocalAuthEnabled(enabled)
    }
}

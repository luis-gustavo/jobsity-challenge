//
//  LocalAuthViewController.swift
//  Jobsity
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/01/22.
//

import LocalAuthentication
import UIKit

protocol LocalAuthViewControllerDelegate: AnyObject {
    func didAuthenticate()
}

final class LocalAuthViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: LocalAuthViewControllerDelegate?
    
    // MARK: - View Properties
    private let localAuthView = LocalAuthView()
    
    // MARK: - LoadView
    override func loadView() {
        self.view = localAuthView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = LAContext()
        var error: NSError?

        // Check for biometric authentication
        let permissions = context.canEvaluatePolicy(
            .deviceOwnerAuthentication,
            error: &error
        )

        if permissions {
            // Proceed to authentication
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: Localizable.authentication.localized) { [weak self] success, error in
                if success {
                    guard let self = self else { return }
                    self.delegate?.didAuthenticate()
                } else {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.localAuthView.setupErrorDescription("\(error?.localizedDescription ?? "")\n\n\(Localizable.reopenAndTryAgain.localized)")
                    }
                }
            }
        }
        else {
            // Handle permission denied or error
            self.localAuthView.setupErrorDescription("\(error?.localizedDescription ?? "")\n\n\(Localizable.reopenAndTryAgain.localized)")
        }
    }
}

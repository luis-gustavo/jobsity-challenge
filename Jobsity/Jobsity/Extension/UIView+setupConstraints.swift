//
//  UIView+setupConstraints.swift
//  SaeApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

extension UIView {
    
    /// Method to setup a list of constraints to self UIView
    ///
    /// - Parameter activate: Block that provide the constraints list to be activated, that uses self as parameter
    func setupConstraints(_ activate: (UIView) -> [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(activate(self))
    }
}

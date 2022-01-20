//
//  UIStackView+addArrangedSubviews.swift
//  SaeApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

extension UIStackView {
    /// Arrange the array of `UIView` to specific stackview and set `translatesAutoresizingMaskIntoConstraints` to `false`
    ///
    /// - Parameter views: list of subviews
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview($0)
        }
    }
}



//
//  UIView+addSubviews.swift
//  SaeApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

extension UIView {
    
    /// Add the array of `UIView` to specific view and set `translatesAutoresizingMaskIntoConstraints` to `false`
    ///
    /// - Parameter views: list of subviews
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}

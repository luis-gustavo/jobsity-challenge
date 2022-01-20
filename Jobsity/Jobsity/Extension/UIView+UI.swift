//
//  UIView+UI.swift
//  SaeApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/01/22.
//

import UIKit

extension UIView {
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    
    var borderColor: UIColor? {
        get {
            guard let layerBorderColor = layer.borderColor else { return nil }
            return UIColor(cgColor: layerBorderColor)
        } set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

//
//  UIStackView+Extension.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 22/06/23.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangeSubViews: [UIView], axis: NSLayoutConstraint.Axis ,spacing: CGFloat, distribution: UIStackView.Distribution) {
        self.init(arrangedSubviews: arrangeSubViews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
       translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addBackgroundColor(_ color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

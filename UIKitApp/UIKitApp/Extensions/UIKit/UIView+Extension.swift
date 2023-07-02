//
//  UIView+Extension.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 19/06/23.
//

import UIKit

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach{addSubview($0)}
    }
}

extension UIView {
    
    @discardableResult
    func makeConstraints(top: NSLayoutYAxisAnchor?,
                         leading: NSLayoutXAxisAnchor?,
                         trailing: NSLayoutXAxisAnchor?,
                         bottom: NSLayoutYAxisAnchor?,
                         topMargin: CGFloat,
                         leftMargin: CGFloat,
                         rightMargin: CGFloat,
                         bottomMargin: CGFloat,
                         width: CGFloat,
                         height: CGFloat) -> AnchoredConstraints? {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: topMargin)
        }
        
        if let left = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: left, constant: leftMargin)
        }
        
        if let right = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: right, constant: -rightMargin)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -bottomMargin)
        }
        
        if width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: width)
        }
        
        if height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    func makeEdgeConstraints(toView parentView: UIView, edgeMargin: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: parentView.topAnchor, constant: edgeMargin).isActive = true
        self.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: edgeMargin).isActive = true
        self.rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: -edgeMargin).isActive = true
        self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -edgeMargin).isActive = true
    }
    
    func makeCenterConstraints(toView parentView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
    }
    
    func makeConstraints(centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    func makeConstraints(width: CGFloat, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if width != 0 { self.widthAnchor.constraint(equalToConstant: width).isActive = true }
        if height != 0 { self.heightAnchor.constraint(equalToConstant: height).isActive = true }
    }
}

//
//  UIView+Extension.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 19/06/23.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach{addSubview($0)}
    }
}

extension UIView {
    
    func makeConstraints(top: NSLayoutYAxisAnchor?,
                         left: NSLayoutXAxisAnchor?,
                         right: NSLayoutXAxisAnchor?,
                         bottom: NSLayoutYAxisAnchor?,
                         topMargin: CGFloat,
                         leftMargin: CGFloat,
                         rightMargin: CGFloat,
                         bottomMargin: CGFloat,
                         width: CGFloat,
                         height: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topMargin).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: leftMargin).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -rightMargin).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomMargin).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
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

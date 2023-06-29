//
//  UIButton+Extension.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 29/06/23.
//

import UIKit

extension UIButton {
    
    func addSystemImage(imageName: String, _ pointSize: CGFloat = 27.5, state: UIControl.State = .normal) {
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        setImage(image, for: state)
    }
}

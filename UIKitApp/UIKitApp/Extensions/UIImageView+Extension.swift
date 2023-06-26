//
//  UIImageView+Extension.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 26/06/23.
//

import UIKit

extension UIImageView {
    
    convenience init(mode: UIView.ContentMode = .scaleAspectFit, clipsToBounds: Bool = true) {
        self.init(frame: .zero)
        self.contentMode = mode
        self.clipsToBounds = clipsToBounds
    }
}

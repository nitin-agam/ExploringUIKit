//
//  BaseCollectionCell.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 20/06/23.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        backgroundColor = .clear
    }
}

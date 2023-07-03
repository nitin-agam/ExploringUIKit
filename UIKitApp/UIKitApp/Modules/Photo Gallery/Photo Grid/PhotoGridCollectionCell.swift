//
//  PhotoGridCollectionCell.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 30/06/23.
//

import UIKit

class PhotoGridCollectionCell: BaseCollectionCell {
    
    private let imageView: UIImageView = {
        UIImageView(mode: .scaleAspectFill)
    }()
    
    override func initialSetup() {
        super.initialSetup()
        addSubview(imageView)
        imageView.makeEdgeConstraints(toView: self)
    }
    
    func configure(_ photo: PhotoItem) {
        imageView.image = UIImage(named: photo.imageName)
    }
}

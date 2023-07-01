//
//  PhotosGridDataSource.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 30/06/23.
//

import Foundation

class PhotosGridDataSource {
    
    private(set) var photos: [PhotoItem] = []
    
    init() {
        photos.append(contentsOf: [
            PhotoItem(imageName: "image0"),
            PhotoItem(imageName: "image1"),
            PhotoItem(imageName: "image2"),
            PhotoItem(imageName: "image3"),
            PhotoItem(imageName: "image4"),
            PhotoItem(imageName: "image5"),
            PhotoItem(imageName: "image6"),
            PhotoItem(imageName: "image7"),
            PhotoItem(imageName: "image8"),
            PhotoItem(imageName: "image9"),
            PhotoItem(imageName: "image10"),
            PhotoItem(imageName: "image11"),
            PhotoItem(imageName: "image12"),
            PhotoItem(imageName: "image13"),
            PhotoItem(imageName: "image14"),
            PhotoItem(imageName: "image15"),
            PhotoItem(imageName: "image16"),
            PhotoItem(imageName: "image17"),
            PhotoItem(imageName: "image18"),
            PhotoItem(imageName: "image19"),
            PhotoItem(imageName: "image20"),
            PhotoItem(imageName: "image21")
        ])
    }
    
    func deleteAt(_ indexPath: IndexPath) {
        photos.remove(at: indexPath.item)
    }
}

struct PhotoItem {
    let imageName: String
}

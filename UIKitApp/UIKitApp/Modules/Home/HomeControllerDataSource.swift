//
//  HomeControllerDataSource.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 19/06/23.
//

import Foundation

class HomeControllerDataSource {
    
    private(set) var items: [ListItem] = []
    
    init() {
        items.append(contentsOf: [ListItem(title: "UICollectionView with UIContextMenu", description: "Explore about UIContextMenu by configuring actions, providing custom previews, sub-menus, and handling preview interactions.", slug: "GitHub Followers", navigationTitle: "GithubFollowers")])
    }
}

struct ListItem {
    
    let title: String
    let description: String
    let slug: String
    let navigationTitle: String
    
    var navigationDisplayTitle: String {
        "#" + navigationTitle
    }
    
    func listTitle(for index: Int) -> String {
        "TitBit \(index + 1) - " + slug
    }
}

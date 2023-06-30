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
        guard let homeListData = CommonUtility.readJSON(forName: "home_list") else { return }
        do {
            self.items = try JSONDecoder().decode([ListItem].self, from: homeListData)
        } catch {
            print("Something is wrong while decoding home list data.")
        }
    }
}

struct ListItem: Codable {
    
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

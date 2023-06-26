//
//  GitHubFollowersDataSource.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 20/06/23.
//

import Foundation

class GitHubFollowersDataSource {
    
    private(set) var users: [GitHubUser] = []
    
    init() {
        users.append(contentsOf: [
            GitHubUser(profileImage: "profile_1", username: "alina", name: "Alina", followers: 34, following: 1200),
            GitHubUser(profileImage: "profile_2", username: "john", name: "Johny", followers: 34, following: 6507),
            GitHubUser(profileImage: "profile_3", username: "ritaahh", name: "Rita", followers: 34, following: 657),
            GitHubUser(profileImage: "profile_4", username: "tinamartin", name: "Tina", followers: 6784, following: 657),
            GitHubUser(profileImage: "profile_5", username: "milly", name: "Milly", followers: 304, following: 657),
            GitHubUser(profileImage: "profile_6", username: "Garcia", name: "Garcia", followers: 34, following: 657),
            GitHubUser(profileImage: "profile_7", username: "Smily", name: "Smily", followers: 34, following: 657),
            GitHubUser(profileImage: "profile_8", username: "Brown", name: "Brown", followers: 34, following: 657),
            GitHubUser(profileImage: "profile_9", username: "Catie", name: "Catie", followers: 34, following: 657),
            GitHubUser(profileImage: "profile_10", username: "Roney", name: "Roney", followers: 34, following: 657),
            GitHubUser(profileImage: "profile_11", username: "Michael", name: "Michael", followers: 34, following: 657),
            GitHubUser(profileImage: "profile_12", username: "William", name: "William", followers: 34, following: 657),
            GitHubUser(profileImage: "20w", username: "alina", name: "alina", followers: 34, following: 657),
            GitHubUser(profileImage: "21w", username: "Barbara", name: "Barbara", followers: 34, following: 657),
            GitHubUser(profileImage: "22w", username: "ritaahh", name: "rita", followers: 34, following: 657),
            GitHubUser(profileImage: "33w", username: "tinamartin", name: "tina r", followers: 34, following: 657),
            GitHubUser(profileImage: "34m", username: "Miller", name: "Miller", followers: 34, following: 657),
            GitHubUser(profileImage: "39w", username: "Garcia", name: "Garcia", followers: 34, following: 657),
            GitHubUser(profileImage: "32m", username: "Smith", name: "Smith", followers: 34, following: 657),
            GitHubUser(profileImage: "48m", username: "Brown", name: "Brown", followers: 34, following: 657),
            GitHubUser(profileImage: "36m", username: "Williams", name: "Williams", followers: 34, following: 657),
            GitHubUser(profileImage: "30w", username: "Barbara", name: "Barbara", followers: 34, following: 657),
            GitHubUser(profileImage: "28m", username: "Michael", name: "Michael", followers: 34, following: 657),
            GitHubUser(profileImage: "14m", username: "William", name: "William", followers: 34, following: 657)
        ])
    }
}

struct GitHubUser {
    let profileImage: String
    let username: String
    let name: String
    let followers: Int
    let following: Int
}

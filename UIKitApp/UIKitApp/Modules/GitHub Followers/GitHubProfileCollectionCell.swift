//
//  GitHubProfileCollectionCell.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 20/06/23.
//

import UIKit

class GitHubProfileCollectionCell: BaseCollectionCell {
    
    private let profileImageView: UIImageView = {
        UIImageView(mode: .scaleAspectFill)
    }()
    
    private let usernameLabel: UILabel = {
        UILabel(font: .systemFont(ofSize: 16, weight: .semibold), alignment: .center)
    }()
    
    override func initialSetup() {
        super.initialSetup()
        
        backgroundColor = UIColor.tertiarySystemGroupedBackground
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        addSubviews(profileImageView, usernameLabel)
        
        profileImageView.makeConstraints(width: frame.width, height: frame.width)
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        usernameLabel.makeConstraints(top: profileImageView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, topMargin: 10, leftMargin: 8, rightMargin: 8, bottomMargin: 0, width: 0, height: 0)
    }
    
    func configure(_ user: GitHubUser) {
        profileImageView.image = UIImage(named: user.profileImage)
        usernameLabel.text = "@" + user.username.lowercased()
    }
}

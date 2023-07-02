//
//  GitHubProfilePreviewController.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 21/06/23.
//

import UIKit

class GitHubProfilePreviewController: BaseViewController {

    // MARK: - Properties
    private let profileImageView: UIImageView = {
        UIImageView(mode: .scaleAspectFill)
    }()
    
    private let fullNameLabel: UILabel = {
        UILabel(font: .systemFont(ofSize: 20, weight: .semibold))
    }()
    
    private let usernameLabel: UILabel = {
        UILabel(font: .systemFont(ofSize: 16, weight: .medium), textColor: .secondaryLabel)
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel(font: .systemFont(ofSize: 14, weight: .semibold), textColor: .secondaryLabel, alignment: .center)
        label.backgroundColor = .tertiaryLabel.withAlphaComponent(0.1)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel(font: .systemFont(ofSize: 14, weight: .semibold), textColor: .secondaryLabel, alignment: .center)
        label.backgroundColor = .tertiaryLabel.withAlphaComponent(0.1)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        
        let followStatusStackView = UIStackView(arrangeSubViews: [followersLabel, followingLabel],
                                                axis: .horizontal,
                                                spacing: 12,
                                                distribution: .fillEqually)
        followStatusStackView.alignment = .fill
        
        view.addSubviews(followStatusStackView, fullNameLabel, usernameLabel, profileImageView)
        
        followStatusStackView.makeConstraints(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, topMargin: 0, leftMargin: 12, rightMargin: 12, bottomMargin: 10, width: 0, height: 40)
        
        fullNameLabel.makeConstraints(top: nil, leading: view.leadingAnchor, trailing: nil, bottom: followStatusStackView.topAnchor, topMargin: 0, leftMargin: 12, rightMargin: 0, bottomMargin: 0, width: 0, height: 50)
        
        usernameLabel.makeConstraints(centerX: nil, centerY: fullNameLabel.centerYAnchor)
        usernameLabel.leftAnchor.constraint(equalTo: fullNameLabel.rightAnchor, constant: 5).isActive = true
        
        profileImageView.makeConstraints(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: fullNameLabel.topAnchor, topMargin: 0, leftMargin: 0, rightMargin: 0, bottomMargin: 0, width: 0, height: 0)
    }
    
    func configure(with user: GitHubUser) {
        profileImageView.image = UIImage(named: user.profileImage)
        usernameLabel.text = "@" + user.username.lowercased()
        fullNameLabel.text = user.name.capitalized
        
        let followersAttributedString = NSMutableAttributedString(string: "Followers  ")
        followersAttributedString.append(NSAttributedString(string: user.followers.formatWithAbbreviations, attributes: [.foregroundColor: UIColor.label]))
        followersLabel.attributedText = followersAttributedString
        
        let followingAttributedString = NSMutableAttributedString(string: "Following  ")
        followingAttributedString.append(NSAttributedString(string: user.following.formatWithAbbreviations, attributes: [.foregroundColor: UIColor.label]))
        followingLabel.attributedText = followingAttributedString
    }
}

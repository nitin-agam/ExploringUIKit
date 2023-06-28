//
//  ChatMessageViewController.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 27/06/23.
//

import UIKit

class ChatMessageViewController: UITableViewController {
    
    // MARK: - Properties
    private let dataSource = ChatMessageDataSource()
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.groupMessagesByDate()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        tableView.register(cell: ChatMessageTableCell.self)
        tableView.separatorStyle = .none
        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .systemBackground
        
        let backgroundImage = UIImageView(image: UIImage(named: "image_whats_app_bg"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        tableView.backgroundView = backgroundImage
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationController?.navigationBar.tintColor = .label
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        navigationController?.setNeedsStatusBarAppearanceUpdate()
    }
}

extension ChatMessageViewController {
    
    // MARK: - UITableView Methods
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let firstMessageInSection = dataSource.messageGroups[section].first {
            let dateLabel = ChatHeaderDateLabel()
            dateLabel.text = firstMessageInSection.date.asString()
            
            let containerView = UIView()
            containerView.addSubview(dateLabel)
            dateLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            dateLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.messageGroups.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.messageGroups[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ChatMessageTableCell.self, for: indexPath)
        let chatMessage = dataSource.messageGroups[indexPath.section][indexPath.row]
        cell.chatMessage = chatMessage
        return cell
    }
}

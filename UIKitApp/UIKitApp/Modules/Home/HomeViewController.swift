//
//  HomeViewController.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 19/06/23.
//

import UIKit

class HomeViewController: BaseViewController {

    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(cell: HomeListItemTableCell.self)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let dataSource = HomeControllerDataSource()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        navigationItem.title = "#ExploringUIKit"
        view.addSubview(tableView)
        tableView.makeEdgeConstraints(toView: view)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: HomeListItemTableCell.self, for: indexPath)
        cell.configure(dataSource.items[indexPath.row], indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = dataSource.items[indexPath.row]
        var controller: UIViewController?
        
        switch indexPath.row {
        case 0: controller = GitHubFollowersController()
        case 1: controller = ChatMessageViewController()
        case 2: controller = PhotosGridViewController()
        case 3: controller = VideoReelsViewController()
        default: break
        }
        
        guard let targetController = controller else { return }
        targetController.navigationItem.title = selectedItem.navigationDisplayTitle
        navigationController?.pushViewController(targetController, animated: true)
    }
}

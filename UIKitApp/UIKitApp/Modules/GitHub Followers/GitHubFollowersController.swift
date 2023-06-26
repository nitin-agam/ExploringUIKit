//
//  GitHubFollowersController.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 19/06/23.
//

import UIKit

class GitHubFollowersController: BaseViewController {
    
    // MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = gridSpacing
        layout.minimumInteritemSpacing = gridSpacing
        let width = floor((view.frame.width - gridSpacing * (numberOfItemsInRow + 1)) / numberOfItemsInRow)
        layout.itemSize = CGSize(width: width, height: width + 40) // adding margin to give extra height
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cell: GitHubProfileCollectionCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let gridSpacing: CGFloat = 10
    private let numberOfItemsInRow: CGFloat = 3
    private let dataSource = GitHubFollowersDataSource()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.addSubview(collectionView)
        collectionView.makeEdgeConstraints(toView: view)
    }
}

extension GitHubFollowersController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: GitHubProfileCollectionCell.self, for: indexPath)
        cell.configure(dataSource.users[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        UIContextMenuConfiguration(identifier: nil,
                                   previewProvider: { self.makePreview(for: indexPath.item) }) { _ in
            
            let repositoriesAction = UIAction(title: "Repositories", image: UIImage(systemName: "filemenu.and.cursorarrow")) { _ in
                // handle click action here...
            }
            
            let starAction = UIAction(title: "Stars", image: UIImage(systemName: "star")) { _ in
                // handle click action here...
            }
            
            let achievementAction = UIAction(title: "Achievements", image: UIImage(systemName: "trophy")) { _ in
                // handle click action here...
            }
            
            let unfollowAction = UIAction(title: "Unfollow", image: UIImage(systemName: "xmark.bin.fill"), attributes: .destructive) { _ in
                // handle click action here...
            }
            
            
            let shareAction = UIAction(title: "Share Profile", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                // handle click action here...
            }
            
            let copyAction = UIAction(title: "Copy URL", image: UIImage(systemName: "doc.on.doc")) { _ in
                // handle click action here...
            }
            
            // submenu
            let moreMenu = UIMenu(title: "More...", children: [shareAction, copyAction])
            
            return UIMenu(title: "", image: nil, children: [repositoriesAction, starAction, achievementAction, unfollowAction, moreMenu])
        }
    }
    
    private func makePreview(for index: Int) -> UIViewController {
        let profilePreviewController = GitHubProfilePreviewController()
        profilePreviewController.configure(with: dataSource.users[index])
        
        // you can give size according to design's requirement.
        let preferredWidth = view.frame.width * 0.7
        profilePreviewController.preferredContentSize = .init(width: preferredWidth, height: preferredWidth + 100) // adding 100 for names and follow status views
        return profilePreviewController
    }
    
    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        
        // When the preview will be clicked, you can handle the click action here...
        
        animator.addCompletion {
            // you can perform an action on completion of animation after clicking the preview.
        }
        
        /*
         guard let identifier = configuration.identifier as? String else { return }
         print("Identifier: \(identifier)")
         
         // You can identify the cell for which preview has clicked by assigning a unique identifier while configuring UIContextMenuConfiguration in above method. For example, you can pass the indexPath (in string format) as an identifier.
         */
    }
}

//
//  PhotosGridViewController.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 30/06/23.
//

import UIKit

class PhotosGridViewController: BaseViewController {
    
    // MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = gridSpacing
        layout.minimumInteritemSpacing = gridSpacing
        let width = floor((view.frame.width - gridSpacing * (numberOfItemsInRow - 1)) / numberOfItemsInRow)
        layout.itemSize = CGSize(width: width, height: width)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cell: PhotoGridCollectionCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let gridSpacing: CGFloat = 1.5
    private let numberOfItemsInRow: CGFloat = 3
    private let dataSource = PhotosGridDataSource()
    
    
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
    
    private func copyAction(for indexPath: IndexPath) {
        UIPasteboard.general.image = UIImage(named: self.dataSource.photos[indexPath.item].imageName)
    }
    
    private func shareAction(for indexPath: IndexPath) {
        guard let image = UIImage(named: self.dataSource.photos[indexPath.item].imageName) else { return }
        let items: [Any] = [image]
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityController, animated: true)
    }
    
    private func deleteAction(for indexPath: IndexPath) {
        dataSource.deleteAt(indexPath)
        collectionView.deleteItems(at: [indexPath])
    }
}

extension PhotosGridViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: PhotoGridCollectionCell.self, for: indexPath)
        cell.configure(dataSource.photos[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        UIContextMenuConfiguration(identifier: nil,
                                   previewProvider: { self.makePreview(for: indexPath.item) }) { _ in
            
            let copyAction = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
                self.copyAction(for: indexPath)
            }
            
            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                self.shareAction(for: indexPath)
            }
            
            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                self.deleteAction(for: indexPath)
            }
            
            return UIMenu(title: "", image: nil, children: [copyAction, shareAction, deleteAction])
        }
    }
    
    private func makePreview(for index: Int) -> UIViewController {

        let previewController = UIViewController()
        
        guard let image = UIImage(named: dataSource.photos[index].imageName) else { return previewController }
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.frame = .init(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        previewController.view = imageView
        previewController.preferredContentSize = imageView.frame.size
        return previewController
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = PhotoGalleryViewController(photos: dataSource.photos, selectedIndex: indexPath.item)
        navigationController?.pushViewController(controller, animated: true)
    }
}

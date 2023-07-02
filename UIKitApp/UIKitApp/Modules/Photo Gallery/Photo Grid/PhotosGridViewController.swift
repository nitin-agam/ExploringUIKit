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
    
    private var startingFrame: CGRect?
    private var photoGalleryController: PhotoGalleryViewController!
    private var anchoredConstraints: AnchoredConstraints?
    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    private var fullScreenBeginOffset: CGFloat = 0
    
    
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
//        let controller = PhotoGalleryViewController(photos: dataSource.photos, selectedIndex: indexPath.item)
//        navigationController?.pushViewController(controller, animated: true)
        presentPhotoGallery(indexPath)
    }
}

extension PhotosGridViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
    
    private func presentPhotoGallery(_ indexPath: IndexPath) {
        
        // setup controller
        setupPhotoGalleryController(indexPath)
        
        // setup starting position
        setupFullScreenStartingPosition(indexPath)
        
        // begin animation
        beginFullScreenAnimation()
    }
    
    private func setupPhotoGalleryController(_ indexPath: IndexPath) {
        let controller = PhotoGalleryViewController(photos: dataSource.photos, selectedIndex: indexPath.item)
        controller.view.backgroundColor = .yellow
        photoGalleryController = controller
        photoGalleryController.view.layer.cornerRadius = 16
        photoGalleryController.dismissHandler = {
            self.endFullScreenAnimation()
        }
        
        // setup pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePagGesture))
        panGesture.delegate = self
        photoGalleryController.view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePagGesture(gesture: UIPanGestureRecognizer) {
        
        if gesture.state == .began {
            fullScreenBeginOffset = photoGalleryController.collectionView.contentOffset.y
        }
        
        if photoGalleryController.collectionView.contentOffset.y > 0 {
            return
        }
        
        let translationY = gesture.translation(in: photoGalleryController.view).y
        if gesture.state == .changed {
            if translationY > 0 {
                let trueOffset = translationY - fullScreenBeginOffset
                var scale = 1 - trueOffset / 1000
                scale = min(1, scale)
                scale = max(0.5, scale)
                let transform = CGAffineTransform(scaleX: scale, y: scale)
                photoGalleryController.view.transform = transform
            }
        } else if gesture.state == .ended {
            if translationY > 0 {
                self.endFullScreenAnimation()
            }
        }
    }
    
    private func setupStartingFrame(_ indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoGridCollectionCell else {
            return
        }
        
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {
            return
        }
        
        self.startingFrame = startingFrame
    }
    
    private func setupFullScreenStartingPosition(_ indexPath: IndexPath) {
        
        setupStartingFrame(indexPath)
        
        let fullScreenView = photoGalleryController.view!
        view.addSubview(fullScreenView)
        
        addChild(photoGalleryController)
        
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let startingFrame = startingFrame else { return }
        
        self.anchoredConstraints = fullScreenView.makeConstraints(top: view.topAnchor, leading: view.leadingAnchor, trailing: nil, bottom: nil, topMargin: startingFrame.origin.y, leftMargin: startingFrame.origin.x, rightMargin: 0, bottomMargin: 0, width: startingFrame.width, height: startingFrame.height)
        self.view.layoutIfNeeded()
    }
    
    private func beginFullScreenAnimation() {
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            
            self.blurEffectView.alpha = 1
            
            self.anchoredConstraints?.top?.constant = 0
            self.anchoredConstraints?.leading?.constant = 0
            self.anchoredConstraints?.width?.constant = self.view.frame.width
            self.anchoredConstraints?.height?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height
            
//            guard let cell = self.appFullScreenController?.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else { return }
//            cell.todayCollectionCell.topConstraint?.constant = 48
//            cell.layoutIfNeeded()
        }
    }
    
    private func endFullScreenAnimation() {
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            
            self.blurEffectView.alpha = 0
            
            guard let frame = self.startingFrame else { return }
            
            self.anchoredConstraints?.top?.constant = frame.origin.y
            self.anchoredConstraints?.leading?.constant = frame.origin.x
            self.anchoredConstraints?.width?.constant = frame.width
            self.anchoredConstraints?.height?.constant = frame.height
            
            self.view.layoutIfNeeded()
            
            self.photoGalleryController?.collectionView.contentOffset = .zero
            
           // guard let cell = self.photoGalleryController?.collectionView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else { return }
            self.photoGalleryController.closeButton.alpha = 0
           // cell.todayCollectionCell.topConstraint?.constant = 24
          //  cell.layoutIfNeeded()
            
            self.photoGalleryController.view.transform = .identity
            
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
            }
            
        } completion: { _ in
            self.photoGalleryController?.view?.removeFromSuperview()
            self.photoGalleryController?.removeFromParent()
        }
    }
}

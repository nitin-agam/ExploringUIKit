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
}

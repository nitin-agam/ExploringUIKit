//
//  PhotoGalleryViewController.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 01/07/23.
//

import UIKit

class PhotoGalleryViewController: BaseViewController {

    // MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cell: PhotoItemCollectionCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addSystemImage(imageName: "xmark.circle.fill", 25)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleCloseTapped), for: .touchUpInside)
        return button
    }()
    
    private var photos: [PhotoItem]
    private var selectedIndex: Int = 0
    
    
    // MARK: - LifeCycle
    init(photos: [PhotoItem], selectedIndex: Int) {
        self.photos = photos
        self.selectedIndex = selectedIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // moving to selected index
        DispatchQueue.main.async {
            self.moveToIndexPath(IndexPath(item: self.selectedIndex, section: 0), animated: false)
        }
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        
        view.backgroundColor = .black
        
        view.addSubviews(collectionView, closeButton)
        
        collectionView.makeConstraints(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, topMargin: 0, leftMargin: 0, rightMargin: 0, bottomMargin: 0, width: 0, height: 0)
        
        closeButton.makeConstraints(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, trailing: view.trailingAnchor, bottom: nil, topMargin: 0, leftMargin: 0, rightMargin: 4, bottomMargin: 0, width: 50, height: 50)
    }
    
    private func moveToIndexPath(_ indexPath: IndexPath, animated: Bool = true) {
        if collectionView.hasItemAtIndexPath(indexPath) {
            collectionView.selectItem(at: indexPath, animated: animated, scrollPosition: .centeredHorizontally)
        }
    }
    
    @objc private func handleCloseTapped() {
        dismiss(animated: true)
    }
}

extension PhotoGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: PhotoItemCollectionCell.self, for: indexPath)
        cell.configure(photos[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

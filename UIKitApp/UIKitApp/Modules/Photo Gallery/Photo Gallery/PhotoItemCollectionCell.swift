//
//  PhotoItemCollectionCell.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 01/07/23.
//

import UIKit

class PhotoItemCollectionCell: BaseCollectionCell, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    private lazy var zoomScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.zoomScale = 1.0
        scrollView.delegate = self
        return scrollView
    }()
    
    private let previewImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .tertiaryLabel
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    //MARK: - Initial Setup
    override func initialSetup() {
        super.initialSetup()
        
        contentView.addSubviews(zoomScrollView)
        zoomScrollView.makeEdgeConstraints(toView: contentView)
        
        zoomScrollView.addSubview(previewImageView)
        previewImageView.makeEdgeConstraints(toView: zoomScrollView)
        previewImageView.makeCenterConstraints(toView: zoomScrollView)

        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction))
        doubleTapGesture.numberOfTapsRequired = 2
        previewImageView.addGestureRecognizer(doubleTapGesture)
    }
    
    func configure(_ photoItem: PhotoItem) {
        guard let image = UIImage(named: photoItem.imageName) else { return }
        previewImageView.image = image
        previewImageView.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        previewImageView.image = nil
        zoomScrollView.setZoomScale(1.0, animated: false)
    }
    
    // MARK: - Other Methods
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        previewImageView
    }
    
    @objc private func doubleTapAction(gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            if zoomScrollView.zoomScale == zoomScrollView.minimumZoomScale {
                zoomScrollView.zoom(to: zoomRectangle(scale: zoomScrollView.maximumZoomScale, center: gesture.location(in: gesture.view)), animated: true)
            } else {
                zoomScrollView.setZoomScale(zoomScrollView.minimumZoomScale, animated: true)
            }
        }
    }
    
    private func zoomRectangle(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = previewImageView.frame.size.height / scale
        zoomRect.size.width  = previewImageView.frame.size.width  / scale
        zoomRect.origin.x = center.x - (center.x * zoomScrollView.zoomScale)
        zoomRect.origin.y = center.y - (center.y * zoomScrollView.zoomScale)
        return zoomRect
    }
    
    func resetThumbnail() {
        self.zoomScrollView.setZoomScale(zoomScrollView.minimumZoomScale, animated: false)
    }
}

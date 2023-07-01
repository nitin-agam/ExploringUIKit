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
        scrollView.maximumZoomScale = 4.0
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
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            
            guard let image = previewImageView.image else {
                zoomScrollView.contentInset = .zero
                return
            }
            
            // width & height ratio
            let widthRatio = previewImageView.frame.width / image.size.width
            let heightRatio = previewImageView.frame.height / image.size.height
            
            // calculate new width and height from min ratio value
            let ratio = min(widthRatio, heightRatio)
            let newWidth = image.size.width * ratio
            let newHeight = image.size.height * ratio
            
            // calculate left and right edge inset value
            let leftEdgeExpression = newWidth * scrollView.zoomScale > previewImageView.frame.width
            let leftEdgeValue = 0.5 * (leftEdgeExpression ? newWidth - previewImageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
            
            // calculate top and bottom edge inset value
            let topEdgeExpression = newHeight * scrollView.zoomScale > previewImageView.frame.height
            let topEdgeValue = 0.5 * (topEdgeExpression ? newHeight - previewImageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
            
            // fixing the content inset
            zoomScrollView.contentInset = UIEdgeInsets(top: topEdgeValue, left: leftEdgeValue, bottom: topEdgeValue, right: leftEdgeValue)
        } else {
            zoomScrollView.contentInset = .zero
        }
    }
    
    func resetThumbnail() {
        self.zoomScrollView.setZoomScale(zoomScrollView.minimumZoomScale, animated: false)
    }
}

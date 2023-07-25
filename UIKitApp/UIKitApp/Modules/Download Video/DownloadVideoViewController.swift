//
//  DownloadVideoViewController.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 21/07/23.
//

import UIKit
import Photos

extension UIColor {
    static let pulsingBackground = UIColor(r: 21, g: 22, b: 33)
    static let outlineStroke = UIColor(r: 234, g: 46, b: 111)
    static let trackStroke = UIColor(r: 56, g: 25, b: 49)
    static let pulsingFill = UIColor(r: 86, g: 30, b: 63)
}

class DownloadVideoViewController: UIViewController {
    
    // MARK: - Properties
    private let fileUrlString = "https://storage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"
    private let percentageLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 25), text: "Download", textColor: .white, alignment: .center)
    private var isDownloading = false
    private var circleShapeLayer: CAShapeLayer!
    private var pulsingLayer: CAShapeLayer!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupCircles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Adding notification to continue the pulsing animation when app will come in foreground from background.
        setupNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - Private Methods
    private func setupNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }
    
    @objc private func handleEnterForeground() {
        pulsingLayerAnimate()
    }
    
    private func initialSetup() {
        view.backgroundColor = UIColor.pulsingBackground
    }
    
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        // Return a shape layer in circle shape.
        let circlePath = UIBezierPath(arcCenter: .zero,
                                      radius: 100,
                                      startAngle: 0,
                                      endAngle: 2 * CGFloat.pi,
                                      clockwise: true)
        let layer = CAShapeLayer()
        layer.path = circlePath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 15.0
        layer.fillColor = fillColor.cgColor
        layer.lineCap = .round
        layer.position = view.center
        return layer
    }
    
    private func setupCircles() {
        
        // Setup pulsing animate layer
        pulsingLayer = createCircleShapeLayer(strokeColor: UIColor.clear,
                                              fillColor: UIColor.pulsingFill.withAlphaComponent(0.3))
        view.layer.addSublayer(pulsingLayer)
        pulsingLayerAnimate()
        
        
        // Setup track layer
        let trackLayer = createCircleShapeLayer(strokeColor: UIColor.trackStroke,
                                                fillColor: UIColor.pulsingBackground)
        view.layer.addSublayer(trackLayer)
        
        
        // Setup circle outline layer
        circleShapeLayer = createCircleShapeLayer(strokeColor: UIColor.outlineStroke,
                                                  fillColor: UIColor.clear)
        circleShapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        circleShapeLayer.strokeEnd = 0.0
        view.layer.addSublayer(circleShapeLayer)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(handleTapGesture)))
        
        // Setup percentage label
        setupPercentageLabel()
    }
    
    private func setupPercentageLabel() {
        view.addSubview(percentageLabel)
        percentageLabel.makeCenterConstraints(toView: self.view)
    }
    
    @objc private func handleTapGesture() {
        if isDownloading == false {
            beginDownloadFile()
        }
    }
    
    private func beginDownloadFile() {
        circleShapeLayer.strokeEnd = 0
        percentageLabel.text = "Starting..."
        
        let configuration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: configuration,
                                    delegate: self,
                                    delegateQueue: nil)
        
        if let url = URL(string: fileUrlString) {
            let downloadTask = urlSession.downloadTask(with: url)
            downloadTask.resume()
            self.isDownloading = true
        }
    }
    
    
    // MARK: - Animations
    private func pulsingLayerAnimate() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.toValue = 1.4
        pulseAnimation.duration = 0.8
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.infinity
        pulsingLayer.add(pulseAnimation, forKey: "pulsing")
    }
    
    private func drawCircleWithAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 3.0
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        circleShapeLayer.add(animation, forKey: "pulsingAnimation")
    }
    
    
    // MARK - Save Video
    private func saveVideo(from url: URL) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
        }) { (success, error) in
            if success {
                self.showAlert(with: "Video saved to photo gallery successfully!")
            } else {
                self.showAlert(with: error?.localizedDescription ?? "Something is wrong")
            }
        }
    }
    
    private func showAlert(with message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Status", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true)
        }
    }
}

extension DownloadVideoViewController: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        let percentage = Int(progress * 100)
        DispatchQueue.main.async {
            self.percentageLabel.text = "\(percentage)%"
            self.circleShapeLayer.strokeEnd = progress
            
            if percentage == 100 {
                self.percentageLabel.text = "Downloaded"
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        isDownloading = false
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let destinationURL = documentsDirectory.appendingPathComponent(downloadTask.originalRequest?.url?.lastPathComponent ?? "")
        try? FileManager.default.moveItem(at: location, to: destinationURL)
        saveVideo(from: destinationURL)
    }
}

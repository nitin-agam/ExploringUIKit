//
//  ChatMessageViewController.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 27/06/23.
//

import UIKit

extension UIColor {
    static let whatsAppSentMessage = UIColor(named: "WhatsAppSentMessage")!
    static let whatsAppReceivedMessage = UIColor(named: "WhatsAppReceivedMessage")!
    static let whatsAppHeaderBack = UIColor(named: "WhatsAppHeaderBack")!
    static let chatTextViewBackground = UIColor(named: "ChatTextViewBackground")!
}

class ChatMessageViewController: BaseViewController {
    
    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .interactive
        tableView.register(cell: ChatMessageTableCell.self)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = .init(top: 20, left: 0, bottom: 20, right: 0)
        return tableView
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(handleSendMessageClicked), for: .touchUpInside)
        button.addSystemImage(imageName: "arrow.up.circle", state: .disabled)
        button.addSystemImage(imageName: "arrow.up.circle.fill")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .tertiaryLabel
        button.isEnabled = false
        return button
    }()
    
    private lazy var addMediaButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(handleAddMediaClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addSystemImage(imageName: "plus.circle")
        return button
    }()
    
    private lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 17, weight: .regular)
        textView.textColor = UIColor.label
        textView.showsVerticalScrollIndicator = false
        textView.dataDetectorTypes = []
        textView.backgroundColor = .chatTextViewBackground
        textView.autocapitalizationType = .sentences
        textView.layer.cornerRadius = 21.0
        textView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        textView.layer.borderWidth = 1.0
        textView.delegate = self
        textView.textContainerInset = .init(top: 10, left: 10, bottom: 6, right: 10)
        textView.adjustsFontForContentSizeCategory = true
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.autocorrectionType = .no
        return textView
    }()
    
    private let messageInputView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var textViewAttributes = (minHeight: CGFloat(42), maxHeight: CGFloat(120))
    private var inputViewHeight: NSLayoutConstraint!
    private var inputViewBottom: NSLayoutConstraint!
    private let dataSource = ChatMessageDataSource()
    
    private let messageInputViewBackgroundColor = UIColor.black.withAlphaComponent(0.2)
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotificationObservers()
        initialSetup()
        dataSource.groupMessagesByDate()
        updateTableView(true)
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        
        view.backgroundColor = .tertiarySystemGroupedBackground
        
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
        
        
        view.addSubviews(messageInputView, tableView)
        
        messageInputView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        messageInputView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        inputViewHeight = messageInputView.heightAnchor.constraint(equalToConstant: textViewAttributes.minHeight + 20)
        inputViewBottom = messageInputView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        inputViewHeight.isActive = true
        inputViewBottom.isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: messageInputView.topAnchor).isActive = true
        
        messageInputView.addSubviews(sendButton, addMediaButton, messageTextView)
        
        sendButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: messageInputView.bottomAnchor, constant: -10).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: messageInputView.trailingAnchor, constant: -10).isActive = true

        addMediaButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addMediaButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        addMediaButton.bottomAnchor.constraint(equalTo: sendButton.bottomAnchor).isActive = true
        addMediaButton.leadingAnchor.constraint(equalTo: messageInputView.leadingAnchor, constant: 10).isActive = true
        
        messageTextView.leadingAnchor.constraint(equalTo: addMediaButton.trailingAnchor, constant: 10).isActive = true
        messageTextView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10).isActive = true
        messageTextView.topAnchor.constraint(equalTo: messageInputView.topAnchor, constant: 10).isActive = true
        messageTextView.bottomAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 0).isActive = true
    }
    
    private func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func updateTableView(_ shouldScrollToBottom: Bool = false) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if shouldScrollToBottom {
                self.tableView.safeScrollToBottom(animated: false)
            }
        }
    }
    
    
    // MARK: - Messages Methods
    @objc private func handleSendMessageClicked() {
        guard messageTextView.text.isEmpty == false else { return }
        sendButton.isEnabled = false
        self.sendTextMessage(messageTextView.text)
    }
    
    @objc private func handleAddMediaClicked() {
        // open photo gallery to pick media message.
    }
    
    private func sendTextMessage(_ message: String) {
        messageTextView.text.removeAll()
        resetMessageTextViewIfNeeded()
    }
}

extension ChatMessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableView Methods
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let firstMessageInSection = dataSource.messageGroups[section].first {
            let dateLabel = ChatHeaderDateLabel()
            dateLabel.text = firstMessageInSection.date.chatCenterDisplayTime()
            
            let containerView = UIView()
            containerView.addSubview(dateLabel)
            dateLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            dateLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.messageGroups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.messageGroups[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ChatMessageTableCell.self, for: indexPath)
        let chatMessage = dataSource.messageGroups[indexPath.section][indexPath.row]
        cell.chatMessage = chatMessage
        return cell
    }
}

extension ChatMessageViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        sendButton.isEnabled = !textView.text.isEmpty
        sendButton.tintColor = sendButton.isEnabled ? .systemBlue : .tertiaryLabel
        
        let estimatedTextHeight = messageTextView.sizeThatFits(CGSize(width: messageTextView.frame.width, height: .infinity)).height
        let newHeight: CGFloat!
        if estimatedTextHeight <= textViewAttributes.minHeight {
            messageTextView.isScrollEnabled = false
            newHeight = textViewAttributes.minHeight + 20
        } else if estimatedTextHeight <= textViewAttributes.maxHeight {
            newHeight = estimatedTextHeight + 30
        } else {
            messageTextView.isScrollEnabled = true
            newHeight = textViewAttributes.maxHeight + 20
        }
        
        guard inputViewHeight.constant != newHeight else { return }
        animateTextView(newHeight: newHeight)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        resetMessageTextViewIfNeeded()
    }
    
    private func resetMessageTextViewIfNeeded() {
        guard messageTextView.text.isEmpty else { return }
        
        if inputViewHeight.constant != textViewAttributes.minHeight {
            animateTextView(newHeight: textViewAttributes.minHeight + 20)
        }
    }
    
    private func animateTextView(newHeight: CGFloat) {
        inputViewHeight.constant = newHeight
        UIView.animate(withDuration: 0.15,
                       delay: 0,
                       options: [.allowUserInteraction],
                       animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            inputViewBottom.constant = -(keyboardFrame.height - (self.tabBarController?.tabBar.frame.height ?? 0))
            UIView.animate(withDuration: 0,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                self.view.layoutIfNeeded()
                self.tableView.safeScrollToBottom(animated: true)
            }, completion: nil)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let isKeyboardHiding = notification.name == UIResponder.keyboardDidHideNotification
            inputViewBottom.constant = isKeyboardHiding ? keyboardFrame.height - view.safeAreaInsets.bottom : 0
            
            UIView.animate(withDuration: 0,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}

//
//  HomeListItemTableCell.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 19/06/23.
//

import UIKit

class HomeListItemTableCell: BaseTableCell {
    
    private let slugLabel: UILabel = {
        UILabel(font: .systemFont(ofSize: 20, weight: .semibold), textColor: .systemBlue)
    }()
    
    private let titleLabel: UILabel = {
        UILabel(font: .systemFont(ofSize: 18, weight: .semibold))
    }()
    
    private let descriptionLabel: UILabel = {
        UILabel(font: .systemFont(ofSize: 18), textColor: .secondaryLabel, lines: 0)
    }()
    
    override func initialSetup() {
        super.initialSetup()
        
        let contentStackView = UIStackView(arrangeSubViews: [slugLabel, titleLabel, descriptionLabel],
                                           axis: .vertical,
                                           spacing: 8,
                                           distribution: .fill)
        contentStackView.alignment = .top
        contentStackView.layer.cornerRadius = 10
        contentStackView.layer.masksToBounds = true
        contentStackView.addBackgroundColor(.tertiarySystemGroupedBackground)
        contentStackView.layoutMargins = .init(top: 10, left: 12, bottom: 10, right: 12)
        contentStackView.isLayoutMarginsRelativeArrangement = true
        
        addSubview(contentStackView)
        
        contentStackView.makeConstraints(top: topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, topMargin: 10, leftMargin: 15, rightMargin: 15, bottomMargin: 10, width: 0, height: 0)
    }
    
    func configure(_ item: ListItem, indexPath: IndexPath) {
        slugLabel.text = item.listTitle(for: indexPath.row)
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
}

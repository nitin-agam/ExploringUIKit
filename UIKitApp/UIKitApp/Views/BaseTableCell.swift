//
//  BaseTableCell.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 19/06/23.
//

import UIKit

class BaseTableCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}

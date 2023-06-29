//
//  UITableView+Extension.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 19/06/23.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(cell name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }

    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError(
                "Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }
    
    func numberOfRows() -> Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }
    
    func safeScrollToTop(animated: Bool) {
        guard numberOfSections > 0, numberOfRows() > 0 else { return }
        scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: animated)
    }
    
    func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard numberOfSections > 0, section >= 0 else { return nil }
        guard numberOfRows(inSection: section) > 0 else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    
    var lastSection: Int? {
        return numberOfSections > 0 ? numberOfSections - 1 : nil
    }
    
    var indexPathForLastRow: IndexPath? {
        guard let lastSection = lastSection else { return nil }
        return indexPathForLastRow(inSection: lastSection)
    }
    
    func safeScrollToBottom(animated: Bool) {
        guard numberOfSections > 0, numberOfRows() > 0 else { return }
        scrollToRow(at: self.indexPathForLastRow!, at: .bottom, animated: animated)
    }
}

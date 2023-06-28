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
}

//
//  CommonUtility.swift
//  UIKitApp
//
//  Created by Nitin Aggarwal on 30/06/23.
//

import Foundation

class CommonUtility {
    
    class func readJSON(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json") {
                return try String(contentsOfFile: bundlePath).data(using: .utf8)
            }
        } catch {
            print(error)
        }
        return nil
    }
}

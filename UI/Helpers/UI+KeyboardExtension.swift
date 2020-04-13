//
//  UI+KeyboardExtension.swift
//  UI
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardOnTap () {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func hideKeyBoard() {
        view.endEditing(true)
    }
    
}

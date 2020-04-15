//
//  TAP+UIControl.swift
//  UITests
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import UIKit

extension UIControl {
    func simulate (event: UIControl.Event) {
        allTargets.forEach { target in
            self.actions(forTarget: target, forControlEvent: event)?.forEach({ action in
                (target as? NSObject)?.perform(Selector(action))
            })
        }
    }
    
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}

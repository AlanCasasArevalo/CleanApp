//
//  AlertViewSpy.swift
//  PresentationTests
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Presentation

class AlertViewSpy: AlertViewProtocol {

    var emit: ((AlertViewModel) -> Void)?
    
    func observer(completion: @escaping (AlertViewModel) -> Void) {
        self.emit = completion
    }
    
    func showMessage(viewModel: AlertViewModel) {
        self.emit?(viewModel)
    }
}

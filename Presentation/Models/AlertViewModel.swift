//
//  AlertViewModel.swift
//  Presentation
//
//  Created by Alan Casas on 12/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation

public protocol AlertViewProtocol {
    func showMessage (viewModel: AlertViewModel)
}

public struct AlertViewModel: Equatable {
    public var title: String?
    public var message: String?
    
    public init (title: String, message: String) {
        (self.title, self.message) = (title, message)
    }
}

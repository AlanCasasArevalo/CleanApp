//
//  LoaderViewModel.swift
//  Presentation
//
//  Created by Alan Casas on 12/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation

public protocol LoaderViewProtocol {
    func showLoader (viewModel: LoaderViewModel)
}

public struct LoaderViewModel: Equatable {
    public var isLoading: Bool
    
    public init (isLoading: Bool) {
        self.isLoading = isLoading
    }
}

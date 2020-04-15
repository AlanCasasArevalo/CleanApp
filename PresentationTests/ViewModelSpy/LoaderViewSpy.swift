//
//  LoaderViewSpy.swift
//  PresentationTests
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Presentation

class LoaderViewSpy: LoaderViewProtocol {
    
    var emit: ((LoaderViewModel) -> Void)?
    
    func observer(completion: @escaping (LoaderViewModel) -> Void) {
        self.emit = completion
    }
    
    func showLoader(viewModel: LoaderViewModel) {
        self.emit?(viewModel)
    }
}

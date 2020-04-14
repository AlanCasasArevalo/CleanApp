//
//  WeakVarProxy.swift
//  Main
//
//  Created by Alan Casas on 14/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Presentation

final class WeakVarProxy<T: AnyObject> {
    private weak var instance: T?
    
    init(_ instance: T) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertViewProtocol where T: AlertViewProtocol {
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoaderViewProtocol where T: LoaderViewProtocol {
    func showLoader(viewModel: LoaderViewModel) {
        instance?.showLoader(viewModel: viewModel)
    }
}

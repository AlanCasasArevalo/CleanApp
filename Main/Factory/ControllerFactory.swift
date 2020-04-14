//
//  SingUpFactory.swift
//  Main
//
//  Created by Alan Casas on 14/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import UIKit
import UI
import Domain
import Validation
import Presentation

class ControllerFactory {
    static func makeSignUp (addAccount: AddAccountProtocol) -> SignUpViewController {
        let viewController = SignUpViewController.instantiate()
        viewController.signUp = presenter(viewController: viewController, addAccount: addAccount).signUp
        return viewController
    }
    
    static func presenter (viewController: SignUpViewController, addAccount: AddAccountProtocol) -> SignUpPresenter {
        let presenter = SignUpPresenter(alertView: WeakVarProxy(viewController), emailValidator: validator(), addAccount: addAccount, loaderView: WeakVarProxy(viewController))
        return presenter
    }
    
    static func validator () -> EmailValidatorAdapter {
        let validator = EmailValidatorAdapter()
        return validator
    }
}

class WeakVarProxy<T: AnyObject> {
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

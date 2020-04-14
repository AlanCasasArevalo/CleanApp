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
        let presenter = SignUpPresenter(alertView: viewController, emailValidator: validator(), addAccount: addAccount, loaderView: viewController)
        return presenter
    }
    
    static func validator () -> EmailValidatorAdapter {
        let validator = EmailValidatorAdapter()
        return validator
    }
}

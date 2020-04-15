//
//  SignUpComposer.swift
//  Main
//
//  Created by Alan Casas on 14/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Domain
import UI
import Validation
import Presentation


public final class SignUpComposer {
    public static func composeControllerWith (addAccount: AddAccountProtocol) -> SignUpViewController {
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

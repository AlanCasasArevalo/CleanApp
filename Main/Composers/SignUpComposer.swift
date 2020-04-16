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
import Infra

public final class SignUpComposer {
    public static func composeControllerWith (addAccount: AddAccountProtocol) -> SignUpViewController {
        let viewController = SignUpViewController.instantiate()
        viewController.signUp = presenter(viewController: viewController, addAccount: addAccount).signUp
        return viewController
    }
    
    static func presenter (viewController: SignUpViewController, addAccount: AddAccountProtocol) -> SignUpPresenter {
        let presenter = SignUpPresenter(alertView: WeakVarProxy(viewController), addAccount: addAccount, loaderView: WeakVarProxy(viewController), validation: validation())
        return presenter
    }
    
    static func validation () -> ValidationComposite {
        let valitation = ValidationComposite(validations: makeValidation())
        return valitation
    }
    
    public static func makeValidation () -> [ValidationProtocol] {
        return [
            RequiredFieldValidation(fieldName: "name", fieldLabel: "Name"),
            RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
            EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorAdapter()),
            RequiredFieldValidation(fieldName: "password", fieldLabel: "Contraseña"),
            RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmacion de contraseña"),
            CompareFieldValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmacion de contraseña")
        ]
    }
}

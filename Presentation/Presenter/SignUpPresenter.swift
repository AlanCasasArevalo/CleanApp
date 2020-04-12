//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Alan Casas on 12/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation

public final class SignUpPresenter {
    
    private let alertView: AlertViewProtocol
    private let emailValidator: EmailValidatorProtocol
    
    public init(alertView: AlertViewProtocol, emailValidator: EmailValidatorProtocol) {
        self.alertView = alertView
        self.emailValidator = emailValidator
    }
    
    public func signUp (viewModel: SignUpViewModel) {
        if let errorMessage = validateViewModel(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falla la validacion", message: errorMessage))
        }
    }
    
    func validateViewModel (viewModel: SignUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            return "El nombre es obligatorio"
        } else if viewModel.email == nil || viewModel.email!.isEmpty {
            return "El email es obligatorio"
        } else if viewModel.password == nil || viewModel.password!.isEmpty {
            return "El password es obligatorio"
        } else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
            return "El passwordConfirmation es obligatorio"
        } else if viewModel.password != viewModel.passwordConfirmation {
            return "La contraseña y la confirmacion de la contraseña han de ser iguales"
        }
        _ = emailValidator.isEmailValid(email: viewModel.email ?? "")
        return nil
    }
}

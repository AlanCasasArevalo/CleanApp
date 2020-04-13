//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Alan Casas on 12/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Domain

public final class SignUpPresenter {
    
    private let alertView: AlertViewProtocol
    private let emailValidator: EmailValidatorProtocol
    private let addAccount: AddAccountProtocol
    private let loaderView: LoaderViewProtocol
    
    public init(alertView: AlertViewProtocol, emailValidator: EmailValidatorProtocol, addAccount: AddAccountProtocol, loaderView: LoaderViewProtocol) {
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
        self.loaderView = loaderView
    }
    
    public func signUp (viewModel: SignUpViewModel) {
        if let errorMessage = validateViewModel(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falla la validacion", message: errorMessage))
        } else {
            loaderView.showLoader(viewModel: LoaderViewModel(isLoading: true))
            addAccount.addAccount(addAccountModel: SignUpMapper.toAddAccountModel(viewModel: viewModel)) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success:
                    let alertViewModel = AlertViewModel(title: "OK", message: "Todo ha ido bien has creado una cuenta correctamente.")
                    self.alertView.showMessage(viewModel: alertViewModel)
                case .failure:
                    let alertViewModel = AlertViewModel(title: "Error", message: "Ha sucedido un error al crear cuenta")
                    self.alertView.showMessage(viewModel: alertViewModel)
                }
                self.loaderView.showLoader(viewModel: LoaderViewModel(isLoading: false))
            }
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
        } else if !emailValidator.isEmailValid(email: viewModel.email ?? "") {
            return "El email no es de tipo valido."
        }
        return nil
    }
}

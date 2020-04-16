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
    private let addAccount: AddAccountProtocol
    private let loaderView: LoaderViewProtocol
    private let validation: ValidationProtocol
    
    public init(alertView: AlertViewProtocol, addAccount: AddAccountProtocol, loaderView: LoaderViewProtocol, validation: ValidationProtocol) {
        self.alertView = alertView
        self.addAccount = addAccount
        self.loaderView = loaderView
        self.validation = validation
    }
    
    public func signUp (viewModel: SignUpViewModel) {
        if let errorMessage = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falla la validacion", message: errorMessage))
        } else {
            loaderView.showLoader(viewModel: LoaderViewModel(isLoading: true))
            addAccount.addAccount(addAccountModel: SignUpMapper.toAddAccountModel(viewModel: viewModel)) { [weak self] result in
                guard let self = self else { return }
                self.loaderView.showLoader(viewModel: LoaderViewModel(isLoading: false))
                switch result {
                case .success:
                    let alertViewModel = AlertViewModel(title: "OK", message: "Todo ha ido bien has creado una cuenta correctamente.")
                    self.alertView.showMessage(viewModel: alertViewModel)
                case .failure:
                    let alertViewModel = AlertViewModel(title: "Error", message: "Ha sucedido un error al crear cuenta")
                    self.alertView.showMessage(viewModel: alertViewModel)
                }
            }
        }
    }
}

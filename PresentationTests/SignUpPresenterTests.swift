//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Alan Casas on 12/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import XCTest
import Presentation

class SignUpPresenterTests: XCTestCase {

    func test_sign_up_should_show_error_message_if_name_is_not_provider () {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: nil, email: "any_email", password: "any_password", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falla la validacion", message: "El nombre es obligatorio"))
    }

    func test_sign_up_should_show_error_message_if_email_is_not_provider () {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: nil, password: "any_password", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falla la validacion", message: "El email es obligatorio"))
    }
    
    func test_sign_up_should_show_error_message_if_password_is_not_provider () {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email", password: nil, passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falla la validacion", message: "El password es obligatorio"))
    }
    
    func test_sign_up_should_show_error_message_if_password_confirmation_is_not_provider () {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: nil)
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falla la validacion", message: "El passwordConfirmation es obligatorio"))
    }
    
    func test_sign_up_should_show_error_message_if_password_confirmation_is_not_match () {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_other_password_confirmation")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falla la validacion", message: "La contraseña y la confirmacion de la contraseña han de ser iguales"))
    }
}

extension SignUpPresenterTests {
    func makeSut () -> (sut: SignUpPresenter, alertViewSpy: AlertViewSpy) {
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        return (sut, alertViewSpy)
    }
}

extension SignUpPresenterTests {
    class AlertViewSpy: AlertViewProtocol {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
}


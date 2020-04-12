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
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falla la validacion", message: "El nombre es obligatorio"))
    }

    func test_sign_up_should_show_error_message_if_email_is_not_provider () {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falla la validacion", message: "El email es obligatorio"))
    }
    
    func test_sign_up_should_show_error_message_if_password_is_not_provider () {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falla la validacion", message: "El password es obligatorio"))
    }
    
    func test_sign_up_should_show_error_message_if_password_confirmation_is_not_provider () {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel:  makeSignUpViewModel(passwordConfirmation: nil))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falla la validacion", message: "El passwordConfirmation es obligatorio"))
    }
    
    func test_sign_up_should_show_error_message_if_password_confirmation_is_not_match () {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "any_other_password_confirmation"))
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falla la validacion", message: "La contraseña y la confirmacion de la contraseña han de ser iguales"))
    }
    
    func test_sign_up_should_call_emailValidator_with_correct_email () {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
        let signUpViewModel = makeSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
        
    func test_sign_up_should_show_error_message_if_invalid_email_is_provider () {
        let emailValidatorSpy = EmailValidatorSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        let signUpViewModel = makeSignUpViewModel(email: "invalid_email@gmail.com")
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falla la validacion", message: "El email no es de tipo valido."))
    }
    
}

extension SignUpPresenterTests {
    func makeSut (alertView: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy()) -> SignUpPresenter  {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator)
        return sut
    }
    
    func makeSignUpViewModel (name: String? = "any_name", email: String? = "valid_email@gmail.com", password: String? = "any_password", passwordConfirmation: String? = "any_password") -> SignUpViewModel {
        let signUpViewModel = SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
        return signUpViewModel
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

extension SignUpPresenterTests {
    class EmailValidatorSpy: EmailValidatorProtocol {
        var isValid = true
        var email: String?
        
        func isEmailValid (email: String) -> Bool {
            self.email = email
            return isValid
        }
        
        func simulateInvalidEmail () {
            self.isValid = false
        }
    }
}

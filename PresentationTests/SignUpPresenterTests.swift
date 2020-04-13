//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Alan Casas on 12/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import XCTest
import Presentation
import Domain
import Data

class SignUpPresenterTests: XCTestCase {

    func test_sign_up_should_show_error_message_if_name_is_not_provider () {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let expect = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falla la validacion", message: "El nombre es obligatorio"))
            expect.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        wait(for: [expect], timeout: 2)
    }

    func test_sign_up_should_show_error_message_if_email_is_not_provider () {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let expect = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falla la validacion", message: "El email es obligatorio"))
            expect.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        wait(for: [expect], timeout: 2)
    }
    
    func test_sign_up_should_show_error_message_if_password_is_not_provider () {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let expect = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falla la validacion", message: "El password es obligatorio"))
            expect.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        wait(for: [expect], timeout: 2)
    }
    
    func test_sign_up_should_show_error_message_if_password_confirmation_is_not_provider () {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let expect = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falla la validacion", message: "El passwordConfirmation es obligatorio"))
            expect.fulfill()
        }
        sut.signUp(viewModel:  makeSignUpViewModel(passwordConfirmation: nil))
        wait(for: [expect], timeout: 2)
    }
    
    func test_sign_up_should_show_error_message_if_password_confirmation_is_not_match () {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let expect = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falla la validacion", message: "La contraseña y la confirmacion de la contraseña han de ser iguales"))
            expect.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "any_other_password_confirmation"))
        wait(for: [expect], timeout: 2)
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
        let expect = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falla la validacion", message: "El email no es de tipo valido."))
            expect.fulfill()
        }
        let signUpViewModel = makeSignUpViewModel(email: "invalid_email@gmail.com")
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(viewModel: signUpViewModel)
        wait(for: [expect], timeout: 2)
    }
    
    func test_sign_up_should_call_emailValidator_with_correct_values () {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModelRequest, makeAddAccountModelRequest())
    }
        
    func test_sign_up_should_show_error_message_if_addAccount_fails () {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let expect = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Error", message: "Ha sucedido un error al crear cuenta"))
            expect.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completionWithError(error: .unexpected)
        wait(for: [expect], timeout: 2)
    }
        
    func test_sign_up_should_show_loading_is_calling_before_and_after_call_addAccount () {
        let loaderViewSpy = LoaderViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy, loaderView: loaderViewSpy)
        let expect = expectation(description: "waiting")
        loaderViewSpy.observer { loaderViewModel in
            XCTAssertEqual(loaderViewModel, LoaderViewModel(isLoading: true))
            expect.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [expect], timeout: 2)
        let expectAddAccountClousure = expectation(description: "waiting")
        loaderViewSpy.observer { loaderViewModel in
            XCTAssertEqual(loaderViewModel, LoaderViewModel(isLoading: false))
            expectAddAccountClousure.fulfill()
        }
        addAccountSpy.completionWithError(error: .unexpected)
        wait(for: [expectAddAccountClousure], timeout: 2)
    }

}

extension SignUpPresenterTests {
    func makeSut (alertView: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy(), addAccount: AddAccountSpy = AddAccountSpy(), loaderView: LoaderViewSpy = LoaderViewSpy(), file: StaticString = #file, line: UInt = #line) -> SignUpPresenter  {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator, addAccount: addAccount, loaderView: loaderView)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func makeSignUpViewModel (name: String? = "any_name", email: String? = "valid_email@gmail.com", password: String? = "any_password", passwordConfirmation: String? = "any_password") -> SignUpViewModel {
        let signUpViewModel = SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
        return signUpViewModel
    }
}

extension SignUpPresenterTests {
    class AlertViewSpy: AlertViewProtocol {

        var emit: ((AlertViewModel) -> Void)?
        
        func observer(completion: @escaping (AlertViewModel) -> Void) {
            self.emit = completion
        }
        
        func showMessage(viewModel: AlertViewModel) {
            self.emit?(viewModel)
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

extension SignUpPresenterTests {
    class AddAccountSpy: AddAccountProtocol {
        var addAccountModelRequest: AddAccountModelRequest?
        var completionHandler: ((Result<AccountModel, DomainError>) -> Void)?
        
        func addAccount(addAccountModel: AddAccountModelRequest, completionHandler: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModelRequest = addAccountModel
            self.completionHandler = completionHandler
        }
        
        func completionWithError (error: DomainError) {
            completionHandler?(.failure(error))
        }
    }
}

extension SignUpPresenterTests {
    class LoaderViewSpy: LoaderViewProtocol {
        
        var emit: ((LoaderViewModel) -> Void)?
        
        func observer(completion: @escaping (LoaderViewModel) -> Void) {
            self.emit = completion
        }
        
        func showLoader(viewModel: LoaderViewModel) {
            self.emit?(viewModel)
        }
    }
}

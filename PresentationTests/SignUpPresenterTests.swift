//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Alan Casas on 12/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import XCTest

class SignUpPresenter {
    func signUp (viewModel: SignUpViewModel) {
        
    }
}

protocol AlertViewProtocol {
    func showMessage (viewModel: AlertViewModel)
}

struct SignUpViewModel {
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
}

struct AlertViewModel: Equatable {
    var title: String?
    var message: String?
 }

class SignUpPresenterTests: XCTestCase {

    func test_sign_up_should_show_error_message_if_name_is_not_provider () {
        let sut = SignUpPresenter()
        let alertViewSpy = AlertViewSpy()
        let signUpViewModel = SignUpViewModel(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falla la validacion", message: "El nombre es obligatorio"))
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


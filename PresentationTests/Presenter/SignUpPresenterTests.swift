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

class SignUpPresenterTests: XCTestCase {
    
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
    
    
    func test_sign_up_should_show_success_message_if_addAccount_succeeds () {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let expect = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "OK", message: "Todo ha ido bien has creado una cuenta correctamente."))
            expect.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completionWithSuccess(account: makeAccountModel())
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

    func test_sign_up_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeSignUpViewModel()
        sut.signUp(viewModel: viewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }
    
    func test_sign_up_should_show_error_message_if_validation_fails () {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        let expect = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falla la validacion", message: "Error"))
            expect.fulfill()
        }
        validationSpy.simulateError()
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [expect], timeout: 2)
    }
    
}

extension SignUpPresenterTests {
    func makeSut (alertView: AlertViewSpy = AlertViewSpy(), addAccount: AddAccountSpy = AddAccountSpy(), loaderView: LoaderViewSpy = LoaderViewSpy(), validation: ValidationSpy = ValidationSpy(), file: StaticString = #file, line: UInt = #line) -> SignUpPresenter  {
        let sut = SignUpPresenter(alertView: alertView, addAccount: addAccount, loaderView: loaderView, validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }    
}

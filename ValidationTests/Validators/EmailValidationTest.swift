//
//  EmailValidationTest.swift
//  ValidationTests
//
//  Created by Alan Casas on 15/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import XCTest
import Validation
import Presentation

class EmailValidationTest: XCTestCase {
    func test_validate_should_return_error_if_invalid_email_is_provided () {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email" : "invalid_email@gmail.com"])
        XCTAssertEqual(errorMessage, "El campo Email es invalido")
    }

    func test_validate_should_return_error_with_correct_fieldLabel () {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email2", emailValidator: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email" : "invalid_email@gmail.com"])
        XCTAssertEqual(errorMessage, "El campo Email2 es invalido")
    }
    
    func test_validate_should_return_nil_if_valid_email_is_provided () {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email2")
        let errorMessage = sut.validate(data: ["email" : "valid_email@gmail.com"])
        XCTAssertNil(errorMessage)
    }
        
    func test_validate_should_return_nil_if_no_data_is_provided () {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "El campo Email es invalido")
    }
    
}

extension EmailValidationTest {
    func makeSut(fieldName: String, fieldLabel: String, emailValidator: EmailValidatorSpy = EmailValidatorSpy(), file: StaticString = #file, line: UInt = #line) -> EmailValidation {
        let sut = EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel, emailValidator: emailValidator)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}



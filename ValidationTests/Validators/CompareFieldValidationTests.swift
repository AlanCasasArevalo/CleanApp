//
//  File.swift
//  ValidationTests
//
//  Created by Alan Casas on 15/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import XCTest
import Presentation
import Validation

class CompareFieldValidationTests: XCTestCase {
    func test_validate_should_return_error_if_comparation_fails () {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Contraseña")
        let errorMessage = sut.validate(data: ["password" : "1234", "passwordConfirmation": "12345"])
        XCTAssertEqual(errorMessage, "El campo Contraseña es invalido")
    }
    
    func test_validate_should_return_error_if_with_correct_fieldLabel () {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar contraseña")
        let errorMessage = sut.validate(data: ["password" : "1234", "passwordConfirmation": "12345"])
        XCTAssertEqual(errorMessage, "El campo Confirmar contraseña es invalido")
    }
    
    func test_validate_should_return_nil_if_comparation_succeds () {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar contraseña")
        let errorMessage = sut.validate(data: ["password" : "1234", "passwordConfirmation": "1234"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_return_nil_if_no_data_is_provider () {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar contraseña")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "El campo Confirmar contraseña es invalido")
    }
}

extension CompareFieldValidationTests {
    func makeSut (fieldName: String, fieldNameToCompare: String, fieldLabel: String, file: StaticString = #file, line: UInt = #line) -> ValidationProtocol {
        let sut = CompareFieldValidation(fieldName: fieldName, fieldNameToCompare: fieldNameToCompare, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut, file: file, line:line)
        return sut
    }
}

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

class RequiredFieldValidationTests: XCTestCase {
    func test_validate_should_return_error_if_field_is_not_provider () {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: ["name" : "email@gmail.com"])
        XCTAssertEqual(errorMessage, "El campo Email es obligatorio")
    }
    
    func test_validate_should_return_error_with_correct_fieldLabel () {
        let sut = makeSut(fieldName: "age", fieldLabel: "Edad")
        let errorMessage = sut.validate(data: ["name" : "Alan"])
        XCTAssertEqual(errorMessage, "El campo Edad es obligatorio")
    }
    
    func test_validate_should_return_nil_if_field_is_provided () {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let errorMessage = sut.validate(data: ["email" : "email@gmail.com"])
        XCTAssertNil(errorMessage)
    }
    
     func test_validate_should_return_nil_if_data_is_not_provided () {
         let sut = makeSut(fieldName: "email", fieldLabel: "Email")
         let errorMessage = sut.validate(data: nil)
         XCTAssertEqual(errorMessage, "El campo Email es obligatorio")
     }
}

extension RequiredFieldValidationTests {
    func makeSut (fieldName: String, fieldLabel: String, file: StaticString = #file, line: UInt = #line) -> ValidationProtocol {
        let sut = RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut, file: file, line:line)
        return sut
    }
}

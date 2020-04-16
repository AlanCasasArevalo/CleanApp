//
//  ValidationCompositeTest.swift
//  ValidationTests
//
//  Created by Alan Casas on 15/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import XCTest
import Presentation
import Validation

class ValidationCompositeTest: XCTestCase {
    func test_validate_should_return_error_if_validation_fails () {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        validationSpy.simulateError(errorMessage: "Error 1")
        let errorMessage = sut.validate(data: ["name" : "Alan"])
        XCTAssertEqual(errorMessage, "Error 1")
    }
    
    func test_validate_should_return_correct_error_message () {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        validationSpy.simulateError(errorMessage: "Error 2")
        let errorMessage = sut.validate(data: ["name" : "Alan"])
        XCTAssertEqual(errorMessage, "Error 2")
    }
    
    func test_validate_should_return_correct_error_message_with_two_validators () {
        let validationSpy = ValidationSpy()
        let validationSpy2 = ValidationSpy()
        let sut = makeSut(validations: [validationSpy, validationSpy2])
        validationSpy2.simulateError(errorMessage: "Error 3")
        let errorMessage = sut.validate(data: ["name" : "Alan"])
        XCTAssertEqual(errorMessage, "Error 3")
    }
    
    func test_validate_should_return_the_first_error_message () {
        let validationSpy = ValidationSpy()
        let validationSpy2 = ValidationSpy()
        let validationSpy3 = ValidationSpy()
        let sut = makeSut(validations: [validationSpy, validationSpy2, validationSpy3])
        validationSpy2.simulateError(errorMessage: "Error 2")
        validationSpy3.simulateError(errorMessage: "Error 3")
        let errorMessage = sut.validate(data: ["name" : "Alan"])
        XCTAssertEqual(errorMessage, "Error 2")
    }
    
    func test_validate_should_return_nil_if_validation_succeds () {
        let sut = makeSut(validations: [ValidationSpy()])
        let errorMessage = sut.validate(data: ["name" : "Alan"])
        XCTAssertNil(errorMessage)
    }

    func test_validate_should_call_validation_with_correct_data () {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        let data = ["name" : "Alan"]
        let _ = sut.validate(data: data)
        XCTAssert(NSDictionary(dictionary: validationSpy.data!).isEqual(to: data))
    }
}

extension ValidationCompositeTest {
    func makeSut (validations: [ValidationSpy] , file: StaticString = #file, line: UInt = #line) -> ValidationProtocol {
        let sut = ValidationComposite(validations: validations)
        checkMemoryLeak(for: sut, file: file, line:line)
        return sut
    }
}

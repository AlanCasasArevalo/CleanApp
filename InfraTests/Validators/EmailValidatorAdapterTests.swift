//
//  EmailValidatorAdapterTests.swift
//  ValidationTests
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import XCTest
import Infra

class EmailValidatorAdapterTests: XCTestCase {

    func test_invalid_emails () {
        let sut = makeSut()
        XCTAssertFalse(sut.isEmailValid(email: ""))
        XCTAssertFalse(sut.isEmailValid(email: "a"))
        XCTAssertFalse(sut.isEmailValid(email: "aa"))
        XCTAssertFalse(sut.isEmailValid(email: "aa@"))
        XCTAssertFalse(sut.isEmailValid(email: "aa@2"))
        XCTAssertFalse(sut.isEmailValid(email: "aa@aa"))
        XCTAssertFalse(sut.isEmailValid(email: "aa@a2"))
        XCTAssertFalse(sut.isEmailValid(email: "aa@@"))
        XCTAssertFalse(sut.isEmailValid(email: "@"))
        XCTAssertFalse(sut.isEmailValid(email: "@rr"))
        XCTAssertFalse(sut.isEmailValid(email: "@r.com"))
        XCTAssertFalse(sut.isEmailValid(email: "asj@r.@.com"))
    }
    
    func test_valid_emails () {
        let sut = makeSut()
        XCTAssertTrue(sut.isEmailValid(email: "aa@hotmail.com"))
        XCTAssertTrue(sut.isEmailValid(email: "aa@mail.com"))
        XCTAssertTrue(sut.isEmailValid(email: "aa@gmail.com"))
        XCTAssertTrue(sut.isEmailValid(email: "aa@hotmail.com.br"))
        XCTAssertTrue(sut.isEmailValid(email: "aa@hotmail.es"))
        XCTAssertTrue(sut.isEmailValid(email: "aa@outlook.org"))
    }

}

extension EmailValidatorAdapterTests {
    func makeSut () -> EmailValidatorAdapter {
        let sut = EmailValidatorAdapter()
        return sut
    }
}

//
//  EmailValidatorAdapterTests.swift
//  ValidationTests
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import XCTest
import Presentation


class EmailValidatorAdapter: EmailValidatorProtocol {
    private let patter = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    func isEmailValid(email: String) -> Bool {
        return true
    }
}

class EmailValidatorAdapterTests: XCTestCase {

    func test_invalid_emails () {
        let sut = EmailValidatorAdapter()
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

}

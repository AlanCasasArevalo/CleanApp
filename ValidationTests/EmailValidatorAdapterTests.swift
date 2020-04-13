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
        XCTAssertFalse(sut.isEmailValid(email: "eee@@jd.com"))
    }

}

//
//  SignUpIntegrationTests.swift
//  MainTests
//
//  Created by Alan Casas on 14/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import XCTest
import Main

class SignUpIntegrationTests: XCTestCase {

    func test_memory_leak_integration () {
        let sut = SignUpComposer.composeControllerWith(addAccount: AddAccountSpy())
        checkMemoryLeak(for: sut)
    }
    
    func test_enviroment_correct_api_base_url () {
        let valueToTest = getValue(for: EnviromentHelper.EnviromentVariable.apiBaseUrl.rawValue)
        #if DEBUG
        XCTAssertNotNil(valueToTest)
        XCTAssertEqual(valueToTest, "http://localhost:5050/api")
        #elseif RELEASE
        XCTAssertNotNil(valueToTest)
        XCTAssertEqual(valueToTest, "http://localhost:5050/api")
        #endif
    }
    
    func getValue(for key: String) -> String? {
        return Bundle.main.infoDictionary?[key] as? String
    }

}

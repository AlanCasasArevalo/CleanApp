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
    
    func test_enviroment_correct_debug_api_base_url () {
        let valueToTest = getValue(for: EnviromentHelper.EnviromentVariable.apiBaseUrl.rawValue)
        XCTAssertNotNil(valueToTest)
        XCTAssertEqual(valueToTest, "http://localhost:5050/api")
    }
    
    func test_enviroment_correct_release_api_base_url () {
        let valueToTest = getValue(for: EnviromentHelper.EnviromentVariable.apiBaseUrl.rawValue)
        XCTAssertNotNil(valueToTest)
        XCTAssertEqual(valueToTest, "https://clean-node-api.herokuapp.com/api")
    }
    
    func getValue(for key: String) -> String? {
        return Bundle.main.infoDictionary?[key] as? String
    }

}

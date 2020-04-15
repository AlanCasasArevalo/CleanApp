//
//  SignUpIntegrationTests.swift
//  MainTests
//
//  Created by Alan Casas on 14/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import XCTest
import Main
import UI
import Presentation

class SignUpComposerTests: XCTestCase {
    
    func test_memory_leak_integration () {
        let (sut, _) = makeSut()
        checkMemoryLeak(for: sut)
    }
    
    func test_enviroment_correct_debug_api_base_url () {
        let valueToTest = getValue(for: EnviromentHelper.EnviromentVariable.apiBaseUrl.rawValue)
        XCTAssertNotNil(valueToTest)
        XCTAssertNotEqual(valueToTest, "http://localhost:5050/api")
    }
    
    func test_enviroment_correct_release_api_base_url () {
        let valueToTest = getValue(for: EnviromentHelper.EnviromentVariable.apiBaseUrl.rawValue)
        XCTAssertNotNil(valueToTest)
        XCTAssertEqual(valueToTest, "https://clean-node-api.herokuapp.com/api")
    }
    
    func test_background_request_should_complete_on_main_thread () {
        let (sut, addAccountSpy) = makeSut()
        sut.loadViewIfNeeded()
        sut.signUp?(makeSignUpViewModel())
        let expect = expectation(description: "waiting")
        DispatchQueue.global().async {
            addAccountSpy.completionWithError(error: .unexpected)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2)
    }
}

extension SignUpComposerTests {
    func makeSut (file: StaticString = #file, line: UInt = #line) -> (sut: SignUpViewController, addAccountSpy: AddAccountSpy){
        let addAccountSpy = AddAccountSpy()
        let remoteAddAccount = MainQueueDispatchDecorator(addAccountSpy)
        let sut = SignUpComposer.composeControllerWith(addAccount: remoteAddAccount)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: addAccountSpy, file: file, line: line)
        return (sut, addAccountSpy)
    }
}

extension SignUpComposerTests {
    func getValue(for key: String) -> String? {
        return Bundle.main.infoDictionary?[key] as? String
    }
}

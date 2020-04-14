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

}

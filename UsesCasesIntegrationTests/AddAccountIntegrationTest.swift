//
//  UsesCasesIntegrationTests.swift
//  UsesCasesIntegrationTests
//
//  Created by Alan Casas on 12/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import XCTest
import Data
import Infra
import Domain

class AddAccountIntegrationTest: XCTestCase {

    func test_add_account () {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        let sut = RemoteAddAccount(urlToCall: url, httpClient: alamofireAdapter)
        let addAccountModelRequest = AddAccountModelRequest(name: "Alan", email: "alan@gmail.com", password: "test123", passwordConfirmation: "test123")
        let expect = expectation(description: "waiting")
        sut.addAccount(addAccountModel: addAccountModelRequest) { (result) in
            switch result {
            case .success(let account):
                XCTAssertNotNil(account)
                XCTAssertNotNil(account.id)
                XCTAssertNotNil(account.password)
                XCTAssertEqual(account.name, addAccountModelRequest.name)
                XCTAssertEqual(account.email, addAccountModelRequest.email)
            case .failure: XCTFail("Expect success got \(result) instead")
            }
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 10)
    }

}

//
//  InfraTests.swift
//  InfraTests
//
//  Created by Alan Casas on 08/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import XCTest
import Data
import Infra
import Alamofire

class AlamofireAdapterTests: XCTestCase {
    
    func test_post_should_make_request_with_valid_url_and_method () {
        let urlToCall = makeUrl()
        
        testRequestFor(url: urlToCall, data: makeValidData()) { request in
            XCTAssertEqual(urlToCall, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
        }
    }
    
    func test_post_should_make_request_with_no_data () {
        testRequestFor(url: makeUrl(), data: nil) { request in
            XCTAssertNil(request.httpBodyStream)
        }
    }
    
    func test_post_should_complete_with_error_when_request_completes_with_error () {
        expectResult(.failure(.noConnectivityError), when: (data: nil, response: nil, error: makeError()))
    }
    
    func test_post_should_complete_with_error_on_all_invalid_cases () {
        expectResult(.failure(.noConnectivityError), when: (data: makeValidData(), response: makeHttpResponse(), error: makeError()))
        expectResult(.failure(.noConnectivityError), when: (data: makeValidData(), response: nil, error: makeError()))
        expectResult(.failure(.noConnectivityError), when: (data: makeValidData(), response: nil, error: nil))
        expectResult(.failure(.noConnectivityError), when: (data: nil, response: makeHttpResponse(), error: makeError()))
        expectResult(.failure(.noConnectivityError), when: (data: nil, response: makeHttpResponse(), error: nil))
        expectResult(.failure(.noConnectivityError), when: (data: nil, response: nil, error: nil))
    }
    
    func test_post_should_complete_with_data_when_request_completes_with_200 () {
        expectResult(.success(makeValidData()), when: (data: makeValidData(), response: makeHttpResponse(), error: nil))
    }
    
    func test_post_should_complete_with_no_data_when_request_completes_with_204 () {
        expectResult(.success(nil), when: (data: nil, response: makeHttpResponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: (data: makeEmptyData(), response: makeHttpResponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 204), error: nil))
    }

    func test_post_should_complete_with_error_when_request_completes_with_non_200 () {
        expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectResult(.failure(.unauthorized), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
        expectResult(.failure(.forbidden), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil))
        expectResult(.failure(.not_found), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 404), error: nil))
        expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 450), error: nil))
        expectResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
        expectResult(.failure(.noConnectivityError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 300), error: nil))
        expectResult(.failure(.noConnectivityError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 100), error: nil))
    }
}

extension AlamofireAdapterTests {
    
    func makeSut (file: StaticString = #file, line: UInt = #line) -> AlamofireAdapter {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: sessionConfiguration)
        let sut = AlamofireAdapter(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func testRequestFor (url: URL, data: Data?, actionToDo: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let expect = expectation(description: "waiting")
        var request: URLRequest?
        sut.post(to: url, with: data) { _ in
            expect.fulfill()
        }
        UrlProtocolStub.observerRequest { request = $0 }
        wait(for: [expect], timeout: 2)
        actionToDo(request!)
    }

    func expectResult (_ expectedResult: Result<Data?, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #file, line: UInt = #line) {
        let sut = makeSut()
        UrlProtocolStub.simulation(data: stub.data, response: stub.response, error: stub.error)
        let expect = expectation(description: "waiting")
        sut.post(to: makeUrl(), with: makeValidData()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedSuccess), .success(let receivedSuccess)): XCTAssertEqual(expectedSuccess, receivedSuccess, file: file, line: line)
            default:XCTFail("Expected \(expectedResult) but got \(receivedResult) instead", file: file, line: line)
            }
            
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 2)
    }
    
    
}

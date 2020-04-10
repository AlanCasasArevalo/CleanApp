//
//  InfraTests.swift
//  InfraTests
//
//  Created by Alan Casas on 08/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import XCTest
import Data
import Alamofire

class AlamofireAdapter {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post (to urlToCall: URL, with data: Data?, completionHandler: @escaping (Result<Data, HttpError>) -> Void) {
        let json = data?.toJson()
        session.request(urlToCall, method: .post, parameters: json, encoding: JSONEncoding.default).responseData { dataResponse in
            switch dataResponse.result {
            case .success: break
            case .failure: completionHandler(.failure(.noConnectivityError))
            }
        }
    }
}
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
    
    func expectResult (_ expectedResult: Result<Data, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #file, line: UInt = #line) {
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

class UrlProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    static var data: Data?
    static var response: HTTPURLResponse?
    static var error: Error?
    
    static func observerRequest (completionHandler: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completionHandler
    }
    
    static func simulation (data: Data?, response: HTTPURLResponse?, error: Error?) {
        UrlProtocolStub.data = data
        UrlProtocolStub.response = response
        UrlProtocolStub.error = error
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        UrlProtocolStub.emit?(request)
        if let data = UrlProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        if let response = UrlProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let error = UrlProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}

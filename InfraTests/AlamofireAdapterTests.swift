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
        let sut = makeSut()
        UrlProtocolStub.simulation(data: nil, response: nil, error: makeError())
        let expect = expectation(description: "waiting")
        sut.post(to: makeUrl(), with: makeValidData()) { result in
            switch result {
            case .success: XCTFail("Expected error got \(result) instead")
            case .failure(let error): XCTAssertEqual(error, .noConnectivityError)
            }
            
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 2)
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
        sut.post(to: url, with: data) { _ in }
        let expect = expectation(description: "waiting")
        UrlProtocolStub.observerRequest { request in
            actionToDo(request)
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

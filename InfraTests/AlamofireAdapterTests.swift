//
//  InfraTests.swift
//  InfraTests
//
//  Created by Alan Casas on 08/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import XCTest
import Alamofire

class AlamofireAdapter {
    private let session: Session

    init(session: Session = .default) {
        self.session = session
    }
    
    func post (to urlToCall: URL, with data: Data?) {
        let json = data == nil ? nil : try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Parameters
        session.request(urlToCall, method: .post, parameters: json, encoding: JSONEncoding.default).resume()
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
}

extension AlamofireAdapterTests {
    func makeSut () -> AlamofireAdapter {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: sessionConfiguration)
        let sut = AlamofireAdapter(session: session)

        return sut
    }
    
    func testRequestFor (url: URL, data: Data?, actionToDo: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        sut.post(to: url, with: data)
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
    
    static func observerRequest (completionHandler: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completionHandler
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        UrlProtocolStub.emit?(request)
    }
    
    override func stopLoading() {
        
    }
}

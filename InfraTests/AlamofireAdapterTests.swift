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
    
    func post (to urlToCall: URL) {
        session.request(urlToCall, method: .post).resume()
    }
}
class AlamofireAdapterTests: XCTestCase {

    func test_ () {
        let urlToCall = makeUrl()
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: sessionConfiguration)
        let sut = AlamofireAdapter(session: session)
        sut.post(to: urlToCall)
        
        let expect = expectation(description: "waiting")
        UrlProtocolStub.observerRequest { request in
            XCTAssertEqual(urlToCall, request.url)
            XCTAssertEqual("POST", request.httpMethod)
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

//
//  TestFactory.swift
//  DataTests
//
//  Created by Alan Casas on 08/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation

func makeInvalidData () -> Data {
    let data = Data("invalid_data".utf8)
    return data
}

func makeValidData () -> Data {
    let data = Data("{ \"name\" : \"Alan\" }".utf8)
    return data
}

func makeUrl () -> URL {
    let urlToCall = URL(string: "www.google.com")!
    return urlToCall
}

func makeError() -> Error{
    let error = NSError(domain: "any_error", code: 0)
    return error
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    let response = HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    return response
}

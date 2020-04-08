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

func makeUrl () -> URL {
    let urlToCall = URL(string: "www.google.com")!
    return urlToCall
}

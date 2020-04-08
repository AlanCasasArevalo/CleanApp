//
//  Test+Extension.swift
//  DataTests
//
//  Created by Alan Casas on 08/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {    
    func checkMemoryLeak (for instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}

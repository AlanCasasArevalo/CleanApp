//
//  EmailValidatorAdapter.swift
//  Validation
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Validation

public class EmailValidatorAdapter: EmailValidatorProtocol {
    
    private let patter = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    public init () {}
    
    public func isEmailValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try? NSRegularExpression(pattern: patter)
        let match = regex?.firstMatch(in: email, options: [], range: range) != nil
        return match
    }
}

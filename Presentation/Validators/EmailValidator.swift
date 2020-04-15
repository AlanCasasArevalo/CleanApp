//
//  EmailValidator.swift
//  Presentation
//
//  Created by Alan Casas on 12/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation

public protocol EmailValidatorProtocol {
    func isEmailValid (email: String) -> Bool 
}

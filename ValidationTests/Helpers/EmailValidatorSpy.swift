//
//  EmailValidatorSpy.swift
//  PresentationTests
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Validation

class EmailValidatorSpy: EmailValidatorProtocol {
     var isValid = true
     var email: String?
     
     func isEmailValid (email: String) -> Bool {
         self.email = email
         return isValid
     }
     
     func simulateInvalidEmail () {
         isValid = false
     }
 }

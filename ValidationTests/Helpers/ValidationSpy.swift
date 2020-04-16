//
//  ValidationSpy.swift
//  ValidationTests
//
//  Created by Alan Casas on 15/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Presentation

class ValidationSpy: ValidationProtocol {
    var errorMessage: String?
    var data: [String: Any]?
    
    func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
    func simulateError(errorMessage: String ) {
        self.errorMessage = errorMessage
    }
}

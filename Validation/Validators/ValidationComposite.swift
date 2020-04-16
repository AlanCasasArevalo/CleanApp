//
//  ValidationComposite.swift
//  Validation
//
//  Created by Alan Casas on 15/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Presentation

public final class ValidationComposite: ValidationProtocol {
    private let validations: [ValidationProtocol]
    
    public init(validations: [ValidationProtocol]) {
        self.validations = validations
    }
    
    public func validate(data: [String : Any]?) -> String? {
        for validation in validations {
            if let errorMessage = validation.validate(data: data) {
                return errorMessage
            }
        }
        return nil
    }
}

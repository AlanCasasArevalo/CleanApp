//
//  EmailValidation.swift
//  Validation
//
//  Created by Alan Casas on 15/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Presentation

public final class EmailValidation: ValidationProtocol {
    private let fieldName: String
    private let fieldLabel: String
    private let emailValidator: EmailValidatorProtocol
    
    public init(fieldName: String, fieldLabel: String, emailValidator: EmailValidatorProtocol) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.emailValidator = emailValidator
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let fieldValue = data?[fieldName] as? String, emailValidator.isEmailValid(email: fieldValue) else {
            return "El campo \(fieldLabel) es invalido"
        }
        return nil
    }
}

extension EmailValidation: Equatable {
    public static func == (lhs: EmailValidation, rhs: EmailValidation) -> Bool {
        return lhs.fieldName == rhs.fieldName && lhs.fieldLabel == rhs.fieldLabel 
    }
}

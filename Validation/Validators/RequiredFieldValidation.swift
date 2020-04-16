//
//  RequiredFieldValidation.swift
//  Validation
//
//  Created by Alan Casas on 15/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Presentation

public final class RequiredFieldValidation: ValidationProtocol {
    private let fieldName: String
    private let fieldLabel: String

    public init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let fieldName = data?[fieldName] as? String, !fieldName.isEmpty else {
            return "El campo \(fieldLabel) es obligatorio"
        }
        return nil
    }
}

extension RequiredFieldValidation : Equatable {
    public static func == (lhs: RequiredFieldValidation, rhs: RequiredFieldValidation) -> Bool {
        return lhs.fieldLabel == rhs.fieldLabel && lhs.fieldName == rhs.fieldName
    }
}

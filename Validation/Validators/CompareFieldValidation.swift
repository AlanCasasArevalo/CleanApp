//
//  CompareFieldValidation.swift
//  Validation
//
//  Created by Alan Casas on 15/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Presentation

public final class CompareFieldValidation: ValidationProtocol {
    private let fieldName: String
    private let fieldNameToCompare: String
    private let fieldLabel: String

    public init(fieldName: String, fieldNameToCompare: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.fieldNameToCompare = fieldNameToCompare
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let fieldName = data?[fieldName] as? String, let fieldNameToCompare = data?[fieldNameToCompare] as? String, fieldName == fieldNameToCompare else {
            return "El campo \(fieldLabel) es invalido"
        }
        return nil
    }
}

extension CompareFieldValidation: Equatable {
    public static func == (lhs: CompareFieldValidation, rhs: CompareFieldValidation) -> Bool {
        return lhs.fieldLabel == rhs.fieldLabel && lhs.fieldName == rhs.fieldName && lhs.fieldNameToCompare == rhs.fieldNameToCompare
    }
}

//
//  SignUpViewModel.swift
//  Presentation
//
//  Created by Alan Casas on 12/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Domain

public struct SignUpViewModel: ModelProtocol {
    public var name: String?
    public var email: String?
    public var password: String?
    public var passwordConfirmation: String?
    
    public init (name: String?, email: String?, password: String?, passwordConfirmation: String?) {
        (self.name, self.email, self.password, self.passwordConfirmation) = (name, email, password, passwordConfirmation)
    }
    
}

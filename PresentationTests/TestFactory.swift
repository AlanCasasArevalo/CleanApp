//
//  TestFactory.swift
//  PresentationTests
//
//  Created by Alan Casas on 15/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Presentation

func makeSignUpViewModel (name: String? = "any_name", email: String? = "valid_email@gmail.com", password: String? = "any_password", passwordConfirmation: String? = "any_password") -> SignUpViewModel {
    let signUpViewModel = SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    return signUpViewModel
}

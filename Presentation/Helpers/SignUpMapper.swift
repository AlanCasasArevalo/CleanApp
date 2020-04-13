//
//  SignUpMapper.swift
//  Presentation
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Domain

public final class SignUpMapper {
    static func toAddAccountModel (viewModel: SignUpViewModel) -> AddAccountModelRequest {
        let addAccountRequest = AddAccountModelRequest(name: viewModel.name ?? "",
                                                       email: viewModel.email ?? "",
                                                       password: viewModel.password ?? "",
                                                       passwordConfirmation: viewModel.passwordConfirmation ?? "")
        
        return addAccountRequest
    }
}

//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Alan Casas on 08/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Domain

func makeAccountModel () -> AccountModel {
    let accountModel = AccountModel(id: "any_id", name: "any_name", email: "valid_email@gmail.com", password: "any_password")
    return accountModel
}

func makeAddAccountModelRequest () -> AddAccountModelRequest {
    let addAccountModelRequest = AddAccountModelRequest(name: "any_name", email: "valid_email@gmail.com", password: "any_password", passwordConfirmation: "any_password")
    return addAccountModelRequest
}

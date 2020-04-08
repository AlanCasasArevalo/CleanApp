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
    let accountModel = AccountModel(id: "any_id", name: "any_name", email: "any_email", password: "any_password")
    return accountModel
}

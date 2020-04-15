//
//  AddAccountSpy.swift
//  PresentationTests
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Domain

class AddAccountSpy: AddAccountProtocol {
    var addAccountModelRequest: AddAccountModelRequest?
    var completionHandler: ((Result<AccountModel, DomainError>) -> Void)?
    
    func addAccount(addAccountModel: AddAccountModelRequest, completionHandler: @escaping (Result<AccountModel, DomainError>) -> Void) {
        self.addAccountModelRequest = addAccountModel
        self.completionHandler = completionHandler
    }
    
    func completionWithError (error: DomainError) {
        completionHandler?(.failure(error))
    }
    
    func completionWithSuccess(account: AccountModel) {
        completionHandler?(.success(account))
    }
}

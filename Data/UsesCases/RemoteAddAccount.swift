//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Alan Casas on 08/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Domain

public final class RemoteAddAccount: AddAccountProtocol {
    private let urlToCall: URL
    private let httpClient: HttpPostClientProtocol

    public init(urlToCall: URL, httpClient: HttpPostClientProtocol) {
        self.urlToCall = urlToCall
        self.httpClient = httpClient
    }
    
    public func addAccount(addAccountModel: AddAccountModelRequest, completationHandler: @escaping (Result<AccountModel, DomainError>) -> Void) {
        httpClient.post(to: urlToCall, with: addAccountModel.toData()) { result in
            switch result {
            case .success(let data):
                if let model: AccountModel = data.toModel() {
                    completationHandler(.success(model))
                } 
            case .failure: completationHandler(.failure(.unexpected))
            }
        }
    }
}

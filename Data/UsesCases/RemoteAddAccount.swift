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
    
    public func addAccount(addAccountModel: AddAccountModelRequest, completionHandler: @escaping (Result<AccountModel, DomainError>) -> Void) {
        httpClient.post(to: urlToCall, with: addAccountModel.toData()) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case .success(let data):
                if let model: AccountModel = data?.toModel() {
                    completionHandler(.success(model))
                } else {
                    completionHandler(.failure(.unexpected))
                }
            case .failure: completionHandler(.failure(.unexpected))
            }
        }
    }
}

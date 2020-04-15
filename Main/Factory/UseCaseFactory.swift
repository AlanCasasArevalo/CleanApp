//
//  UseCaseFactory.swift
//  Main
//
//  Created by Alan Casas on 14/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Domain
import Data
import Infra

public class UseCaseFactory {
    
    private static let apiBasicUrl = EnviromentHelper.variable(keyToAcces: .apiBaseUrl)
    
    static func remoteAddAccount () -> AddAccountProtocol {
        let remoteAddAccount = RemoteAddAccount(urlToCall: makeUrlWith(path: "signup"), httpClient: httpClient())
        return MainQueueDispatchDecorator(remoteAddAccount)
    }
    
    static func httpClient () -> AlamofireAdapter {
        let httpClient = AlamofireAdapter()
        return httpClient
    }
    
    static func makeUrlWith (path: String) -> URL {
        let url = URL(string: "\(apiBasicUrl)/\(path)")!
        return url
    }
}

public final class MainQueueDispatchDecorator<T>  {
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch (completionHandler: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completionHandler)
        }
        completionHandler()
    }
}
 
extension MainQueueDispatchDecorator: AddAccountProtocol where T: AddAccountProtocol {
    public func addAccount(addAccountModel: AddAccountModelRequest, completionHandler: @escaping (Result<AccountModel, DomainError>) -> Void) {
        instance.addAccount(addAccountModel: addAccountModel) { [weak self] result in
            self?.dispatch {
                completionHandler(result)
            }
        }
    }
}

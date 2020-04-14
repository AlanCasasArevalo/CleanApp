//
//  UseCaseFactory.swift
//  Main
//
//  Created by Alan Casas on 14/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Data
import Infra

public class UseCaseFactory {
    
    private static let apiBasicUrl = EnviromentHelper.variable(keyToAcces: .apiBaseUrl)
    
    static func remoteAddAccount () -> RemoteAddAccount {
        let remoteAddAccount = RemoteAddAccount(urlToCall: makeUrlWith(path: "signup"), httpClient: httpClient())
        return remoteAddAccount
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

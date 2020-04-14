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
    static func remoteAddAccount () -> RemoteAddAccount {
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        let remoteAddAccount = RemoteAddAccount(urlToCall: url, httpClient: webService())
        return remoteAddAccount
    }
    
    static func webService () -> AlamofireAdapter {
        let webService = AlamofireAdapter()
        return webService
    }
}

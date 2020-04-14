//
//  SingUpFactory.swift
//  Main
//
//  Created by Alan Casas on 14/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import UIKit
import UI
import Presentation
import Validation
import Data
import Infra

class SingUpFactory {
    static func makeController () -> SignUpViewController {
        let viewController = SignUpViewController.instantiate()
        viewController.signUp = presenter(viewController: viewController).signUp
        return viewController
    }
    
    static func presenter (viewController: SignUpViewController) -> SignUpPresenter {
        let presenter = SignUpPresenter(alertView: viewController, emailValidator: validator(), addAccount: remoteAddAccount(), loaderView: viewController)
        return presenter
    }
    
    static func validator () -> EmailValidatorAdapter {
        let validator = EmailValidatorAdapter()
        return validator
    }
    
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

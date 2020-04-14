//
//  SignUpComposer.swift
//  Main
//
//  Created by Alan Casas on 14/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Domain
import Data
import UI

public final class SignUpComposer {
    static func composeControllerWith (addAccount: RemoteAddAccount) -> SignUpViewController {
        let signUp = ControllerFactory.makeSignUp(addAccount: addAccount)
        return signUp
    }
}

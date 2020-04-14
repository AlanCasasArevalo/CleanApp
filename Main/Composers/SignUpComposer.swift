//
//  SignUpComposer.swift
//  Main
//
//  Created by Alan Casas on 14/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Domain
import UI

public final class SignUpComposer {
    public static func composeControllerWith (addAccount: AddAccountProtocol) -> SignUpViewController {
        let signUp = ControllerFactory.makeSignUp(addAccount: addAccount)
        return signUp
    }
}

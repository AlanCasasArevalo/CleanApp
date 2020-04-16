//
//  ValidationProtocol.swift
//  Presentation
//
//  Created by Alan Casas on 15/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation

public protocol ValidationProtocol {
    func validate (data: [String: Any]?) -> String?
}

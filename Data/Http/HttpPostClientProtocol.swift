//
//  HttpPostClientProtocol.swift
//  Data
//
//  Created by Alan Casas on 08/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation

public protocol HttpPostClientProtocol {
    func post(to urlToCall: URL, with data: Data?, completationHandler: @escaping (HttpError) -> Void)
}

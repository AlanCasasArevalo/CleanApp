//
//  Data+Decodable.swift
//  Data
//
//  Created by Alan Casas on 08/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation

extension Data {
    func toModel<T: Decodable> () -> T? {
        let model = try? JSONDecoder().decode(T.self, from: self)
        return model
    }
}

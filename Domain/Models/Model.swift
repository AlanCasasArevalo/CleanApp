//
//  Model.swift
//  Domain
//
//  Created by Alan Casas on 08/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation

public protocol ModelProtocol: Codable, Equatable {}

public extension ModelProtocol {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    func toJson() -> [String: Any]? {
        guard let data = self.toData() else { return nil }
        let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return dict
    }
}


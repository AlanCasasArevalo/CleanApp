//
//  EnviromentHelper.swift
//  Main
//
//  Created by Alan Casas on 14/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation

public final class EnviromentHelper {
    public enum EnviromentVariable: String {
        case apiBaseUrl = "API_BASE_URL"
    }
    
    public static func variable (keyToAcces: EnviromentVariable) -> String {
        guard let baseURL = Bundle.main.infoDictionary?[keyToAcces.rawValue] as? String else { return "" }
        return baseURL
    }
}

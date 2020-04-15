//
//  Storyboard.swift
//  UI
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import UIKit

public protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    public static func instantiate() -> Self {
        let vcName = String(describing: self)
        // Esta linea podemos usarla si no queremos llamar al Storyboard igual que al controlador.
        // let sbName = vcName.components(separatedBy: "ViewController")[0]
        let bundle = Bundle(for: Self.self)
        let sb = UIStoryboard(name: vcName, bundle: bundle)
        return sb.instantiateViewController(identifier: vcName) as! Self
    }

}

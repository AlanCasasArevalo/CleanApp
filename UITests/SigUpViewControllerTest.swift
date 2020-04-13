//
//  UITests.swift
//  UITests
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import XCTest
import UIKit
@testable import UI

class SigUpViewControllerTest: XCTestCase {

    func test_loading_is_hidden_on_start () {
        // Si usas StoryBoards necesitas inicializar el Sb
        let sb = UIStoryboard(name: "SignUpViewController", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.beginAppearanceTransition(true, animated: false)
        sut.loadViewIfNeeded()
        sut.viewDidLoad()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
        sut.endAppearanceTransition()
    }

}

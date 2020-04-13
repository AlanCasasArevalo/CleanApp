//
//  UITests.swift
//  UITests
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import XCTest
import UIKit
import Presentation
@testable import UI

class SignUpViewControllerTest: XCTestCase {
    
    func test_sign_up_is_not_nil () {
        let sut = makeSut()
        XCTAssertNotNil(sut)
        sut.endAppearanceTransition()
    }
    
    func test_loading_is_hidden_on_start () {
        let sut = makeSut()
        sut.viewDidLoad()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
        sut.endAppearanceTransition()
    }
    
    func test_sut_is_implements_loaderViewProtocol () {
        let sut = makeSut()
        XCTAssertNotNil(sut as LoaderViewProtocol)
        sut.endAppearanceTransition()
    }
    
    func test_sut_is_implements_alertViewProtocol () {
        let sut = makeSut()
        XCTAssertNotNil(sut as AlertViewProtocol)
        sut.endAppearanceTransition()
    }
}

extension SignUpViewControllerTest {
    func makeSut () -> SignUpViewController {
        let sb = UIStoryboard(name: "SignUpViewController", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.beginAppearanceTransition(true, animated: false)
        sut.loadViewIfNeeded()
        return sut
    }
}

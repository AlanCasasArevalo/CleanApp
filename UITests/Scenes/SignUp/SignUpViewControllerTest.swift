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

    func test_save_button_is_not_nil () {
        let sut = makeSut()
        XCTAssertNotNil(sut.saveButton)
        sut.endAppearanceTransition()
    }

    func test_save_button_calls_signUp_on_tap () {
        var callsCount = 0
        let sut = makeSut(signUpSpy: { _ in
            callsCount += 1
        })
        sut.saveButton?.simulateTap()
        XCTAssertEqual(callsCount, 1)
        sut.endAppearanceTransition()
    }
        
    func test_save_button_calls_with_correct_values () {
        var signUpViewModel: SignUpViewModel?
        let sut = makeSut(signUpSpy: { signUpViewModel = $0 })
        sut.saveButton?.simulateTap()
        let name = sut.nameTextField?.text
        let email = sut.emailTextField?.text
        let password = sut.passwordTextField?.text
        let passwordConfirmation = sut.passwordConfirmationTextField?.text
        XCTAssertEqual(signUpViewModel, SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation))
        sut.endAppearanceTransition()
    }
}

extension SignUpViewControllerTest {
    func makeSut (signUpSpy: ((SignUpViewModel) -> Void)? = nil) -> SignUpViewController {
        let sb = UIStoryboard(name: "SignUpViewController", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.beginAppearanceTransition(true, animated: false)
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        return sut
    }
}

extension UIControl {
    func simulate (event: UIControl.Event) {
        allTargets.forEach { target in
            self.actions(forTarget: target, forControlEvent: event)?.forEach({ action in
                (target as? NSObject)?.perform(Selector(action))
            })
        }
    }
    
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}

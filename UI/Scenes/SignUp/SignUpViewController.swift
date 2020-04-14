//
//  SignUpViewController.swift
//  UI
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import UIKit
import Presentation

public final class SignUpViewController: UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var passwordConfirmationTextField : UITextField!

    public var signUp: ((SignUpViewModel) -> Void)?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension SignUpViewController: Storyboarded {
    
}

extension SignUpViewController {
    private func configure(){
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        saveButton.addTarget(self, action: #selector(saveButtonTouched), for: .touchUpInside)
        hideKeyboardOnTap()
    }
    
    @objc private func saveButtonTouched() {
        let viewModel: SignUpViewModel = SignUpViewModel(name: nameTextField.text, email: emailTextField.text, password: passwordTextField.text, passwordConfirmation: passwordConfirmationTextField.text)
        signUp?(viewModel)
    }
    
}

extension SignUpViewController: LoaderViewProtocol {
    public func showLoader(viewModel: LoaderViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            loadingIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            loadingIndicator.stopAnimating()
        }
    }
}

extension SignUpViewController: AlertViewProtocol {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

//
//  SignUpXIBViewController.swift
//  UI
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import UIKit
import Presentation

final class SignUpXIBViewController: UIViewController {

    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var passwordConfirmationTextField : UITextField!
    
    var signUp: ((SignUpViewModel) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

extension SignUpXIBViewController {
    private func configure(){
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        saveButton.addTarget(self, action: #selector(saveButtonTouched), for: .touchUpInside)
    }
    
    @objc private func saveButtonTouched() {
        let viewModel: SignUpViewModel = SignUpViewModel(name: nameTextField.text, email: emailTextField.text, password: passwordTextField.text, passwordConfirmation: passwordConfirmationTextField.text)
        signUp?(viewModel)
    }
    
}

extension SignUpXIBViewController: LoaderViewProtocol {
    func showLoader(viewModel: LoaderViewModel) {
        if viewModel.isLoading {
            loaderView.startAnimating()
            view.isUserInteractionEnabled = false
        } else {
            view.isUserInteractionEnabled = true
            loaderView.stopAnimating()
        }
    }
}

extension SignUpXIBViewController: AlertViewProtocol {
    func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

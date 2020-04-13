//
//  SignUpViewController.swift
//  UI
//
//  Created by Alan Casas on 13/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import UIKit
import Presentation

final class SignUpViewController: UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    
    var signUp: ((SignUpViewModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension SignUpViewController {
    private func configure(){
        saveButton.addTarget(self, action: #selector(saveButtonTouched), for: .touchUpInside)
    }
    
    @objc private func saveButtonTouched() {
        signUp?(SignUpViewModel(name: nil, email: nil, password: nil, passwordConfirmation: nil))
    }
    
}

extension SignUpViewController: LoaderViewProtocol {
    func showLoader(viewModel: LoaderViewModel) {
        if viewModel.isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
}

extension SignUpViewController: AlertViewProtocol {
    func showMessage(viewModel: AlertViewModel) {
        
    }
}

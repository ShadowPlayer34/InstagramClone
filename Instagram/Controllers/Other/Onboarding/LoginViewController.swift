//
//  LoginViewController.swift
//  Instagram
//
//  Created by Андрей Худик on 12.02.23.
//

import UIKit

class LoginViewController: UIViewController {

    private let emailUsernameTextField: UITextField = {
        return UITextField()
    }()
    
    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: UIButton = {
        return UIButton()
    }()
    
    private let createAccountButton: UIButton = {
        return UIButton()
    }
    
    private let termsButton: UIButton = {
        return UIButton()
    }()
    
    private let privacyButton: UIButton = {
        return UIButton()
    }()
    
    private let logoView: UIView = {
        return UIView()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // asign frames
    }
    
    private func addSubviews() {
        view.addSubview(emailUsernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(logoView)
    }
    
    @objc private func loginButtonTapped() {}
    @objc private func createAccountButtonTapped() {}
    @objc private func termsButtonTapped() {}
    @objc private func privacyButtonTapped() {}

}

//
//  LoginViewController.swift
//  Instagram
//
//  Created by Андрей Худик on 12.02.23.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct Constsants {
        static var cornerRadius: CGFloat = 8.0
    }
    
    private let emailUsernameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.returnKeyType = .next
        field.layer.cornerRadius = Constsants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.autocapitalizationType = .none
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        return field
    }()
    
    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.layer.cornerRadius = Constsants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.autocapitalizationType = .none
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Constsants.cornerRadius
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create an Account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let logoView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        let background = UIImageView(image: UIImage(named: "gradient"))
        view.addSubview(background)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailUsernameTextField.delegate = self
        passwordTextField.delegate = self
        view.backgroundColor = .systemBackground
        addSubviews()
        loginButton.addTarget(self,
                              action: #selector(loginButtonTapped),
                              for: .touchUpInside)
        createAccountButton.addTarget(self,
                                      action: #selector(createAccountButtonTapped),
                                      for: .touchUpInside)
        termsButton.addTarget(self,
                              action: #selector(termsButtonTapped),
                              for: .touchUpInside)
        privacyButton.addTarget(self,
                                action: #selector(privacyButtonTapped),
                                for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // asign frames
        logoView.frame = CGRect(x: 0,
                                y: 0,
                                width: view.width,
                                height: view.height / 3.0)
        emailUsernameTextField.frame = CGRect(x: 25,
                                              y: logoView.bottom + 40,
                                              width: view.width - 50,
                                              height: 52.0)
        passwordTextField.frame = CGRect(x: 25,
                                         y: emailUsernameTextField.bottom + 10,
                                         width: view.width - 50,
                                         height: 52.0)
        loginButton.frame = CGRect(x: 25,
                                   y: passwordTextField.bottom + 10,
                                   width: view.width - 50,
                                   height: 52.0)
        createAccountButton.frame = CGRect(x: 25,
                                           y: loginButton.bottom + 10,
                                           width: view.width - 50,
                                           height: 52.0)
        termsButton.frame = CGRect(x: 10,
                                   y: view.height - view.safeAreaInsets.bottom - 100,
                                   width: view.width - 20,
                                   height: 50)
        privacyButton.frame = CGRect(x: 10,
                                     y: view.height - view.safeAreaInsets.bottom - 50,
                                     width: view.width - 20,
                                     height: 50)
        configureLogoView()
    }
    
    private func configureLogoView() {
        guard logoView.subviews.count == 1 else { return }
        guard let backgroundImage = logoView.subviews.first else { return }
        backgroundImage.frame = logoView.bounds
        
        // add logo
        let imageView = UIImageView(image: UIImage(named: "logo"))
        logoView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: backgroundImage.width / 4.0,
                                 y: view.safeAreaInsets.top,
                                 width: logoView.width / 2.0,
                                 height: logoView.height - view.safeAreaInsets.top)
        
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
    
    @objc private func loginButtonTapped() {
        emailUsernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let emailText = emailUsernameTextField.text, !emailText.isEmpty,
              let passwordText = passwordTextField.text, passwordText.count >= 8 else {
                  return
              }
        
    }
    @objc private func createAccountButtonTapped() {
        let vc = RegistrationViewController()
        present(vc, animated: true)
    }
    @objc private func termsButtonTapped() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc private func privacyButtonTapped() {
        guard let url = URL(string: "https://privacycenter.instagram.com/policy") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailUsernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            loginButtonTapped()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

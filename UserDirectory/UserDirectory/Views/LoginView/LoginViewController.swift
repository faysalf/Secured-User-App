//
//  LoginViewController.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 14/9/25.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    static func instantiate() -> LoginViewController {
        UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "LoginViewControllerID") as! LoginViewController
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var indicator = LoadingIndicator.shared
    var vm = AuthenticationViewModel(service: AuthenticationService())
    var cancellables: Set<AnyCancellable> = []
    
    
    // Life Cycles
    override
    func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        networkSetup()
    }
    
    override
    func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override
    func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // setup
    private func setup() {
        navigationItem.title = "Login"
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // Actions
    @IBAction
    private func loginButtonAction(_ sender: UIButton) {
        login()
    }
    
}

// MARK: - Methods
extension LoginViewController {
    private func login() {
        guard let email = emailTextField.text else {
            showBottomPopup(isError: true, withMessage: "Please enter a correct email")
            return
        }
        guard let password = passwordTextField.text else {
            showBottomPopup(isError: true, withMessage: "Please enter password")
            return
        }
        vm.login(email: email, password: password)
    }
    
    private func networkSetup() {
        vm.$isLoading
            .sink {[weak self] loading in
                guard let self else { return }
                
                if loading {
                    indicator.startAnimating(on: view)
                }else {
                    indicator.stopAnimating()
                }
            }
            .store(in: &cancellables)
        
        vm.$errorMessage
            .sink {[weak self] message in
                if let message, message != "" {
                    self?.showBottomPopup(isError: true, withMessage: message)
                }
            }
            .store(in: &cancellables)
        
    }
    
}

// Text Field Delegates
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            login()
        }
        
        return true
    }
    
    
}

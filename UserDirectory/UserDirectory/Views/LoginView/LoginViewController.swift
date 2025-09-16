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
        setupKeyboardDismissal()
    }
    
    // setup
    private func setup() {
        overrideUserInterfaceStyle = .light
        navigationItem.title = "Login"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Theme.cardBackground
        appearance.titleTextAttributes = [
            .foregroundColor: Theme.textPrimary
        ]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
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
        view.endEditing(true)
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
        
        vm.$loginSuccess
            .sink {[weak self] success in
                if success {
                    self?.goToNextVc()
                }
            }
            .store(in: &cancellables)
        
    }
    
    private func goToNextVc() {
        sceneDelegate?.setRootViewController()
        //let vc = UsersListViewController.instantiate()
        //navigationController?.pushViewController(vc, animated: true)
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

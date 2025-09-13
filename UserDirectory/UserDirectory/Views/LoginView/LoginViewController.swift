//
//  LoginViewController.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 14/9/25.
//

import UIKit

class LoginViewController: UIViewController {
    static func instantiate() -> LoginViewController {
        UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "LoginViewControllerID") as! LoginViewController
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    // Life Cycles
    override
    func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
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
        
    }
    
    // Actions
    @IBAction
    private func loginButtonAction(_ sender: UIButton) {
        LoadingIndicator.shared.startAnimating(on: view)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
            LoadingIndicator.shared.stopAnimating()
        }
        
    }
    
    
    
}


//struct WrappedLoginViewController: UIViewControllerRepresentable {
//    
//    func makeUIViewController(context: Context) -> UIViewController {
//        return context.makeViewController()
//    }
//    
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        
//    }
//}
//
//#Preview {
//    LoginViewController()
//}

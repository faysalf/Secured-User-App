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

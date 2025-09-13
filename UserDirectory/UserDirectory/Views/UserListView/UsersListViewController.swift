//
//  UsersListViewController.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 14/9/25.
//

import UIKit
import Combine

class UsersListViewController: UIViewController {
    static func instantiate() -> UsersListViewController {
        UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "UsersListViewControllerID") as! UsersListViewController
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
        navigationItem.title = "Members"
    }
    
}

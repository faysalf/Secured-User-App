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
    @IBOutlet weak private var userTableView: UITableView!
    private var kcm = KeychainManager.shared
    private var udm = UserDefaults.standard
    private var indicator = LoadingIndicator.shared
    private var cancellables: Set<AnyCancellable> = []
    private var vm = DashboardViewModel(service: DashboardService())
    
    
    // Life Cycles
    override
    func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIs()
        configure()
    }
    
    override
    func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vm.pageNo = 1
        vm.users = []
        vm.isLoading = true
    }
    
    override
    func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchUsers()
    }
    
    // setup
    private func setupUIs() {
        navigationItem.title = "Members"
        navigationItem.setRightBarButton(
            UIBarButtonItem(
                image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
                style: .plain,
                target: self,
                action: #selector(logoutButtonAction(_:))
            ),
            animated: true
        )
        
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        userTableView.register(nib, forCellReuseIdentifier: UserTableViewCell.IDENTIFIER)
        userTableView.delegate = self
        userTableView.dataSource = self
    }
    
    private func configure() {
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
        
        vm.$users
            .sink {[weak self] users in
                if !users.isEmpty {
                    self?.reloadUIs()
                }
            }
            .store(in: &cancellables)
        
    }
    
    // Actions
    @objc
    private func logoutButtonAction(_ sender: UIButton) {
        kcm.deleteToken()
        udm.isLogin = false
        sceneDelegate?.setRootViewController()
    }
    
    // Methods
    private func fetchUsers() {
        vm.getUsers()
                
    }
    
    private func reloadUIs() {
        DispatchQueue.main.async {
            self.userTableView.reloadData()
        }
    }
    
}

// MARK: - UI table view delegata & datasource
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        vm.users.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = userTableView.dequeueReusableCell(withIdentifier: UserTableViewCell.IDENTIFIER, for: indexPath) as! UserTableViewCell
        cell.configure(with: vm.users[indexPath.row])
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        112
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        debugPrint("selected user name \(vm.users[indexPath.row].fullName)")
    }
    
}

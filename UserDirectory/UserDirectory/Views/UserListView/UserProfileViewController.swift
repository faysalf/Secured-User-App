//
//  UserProfileViewController.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 14/9/25.
//

import UIKit
import Combine

class UserProfileViewController: UIViewController {
    
    static func instantiate(
        with user: User,
        viewModel: DashboardViewModel
    ) -> UserProfileViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "UserProfileViewControllerID") as! UserProfileViewController
        vc.user = user
        vc.vm = viewModel
        return vc
    }
    @IBOutlet weak private var userProfileImgView: UIImageView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var userEmailLabel: UILabel!
    var user: User!
    var vm: DashboardViewModel!
    var cancellables: Set<AnyCancellable> = []
    
    // Life cycles
    override
    func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override
    func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configure()
    }
    
    // setup
    private func setup() {
        navigationItem.title = "Profile"
        navigationItem.leftBarButtonItem?.tintColor = Theme.textPrimary
    }
    
    private func configure() {
        UIView.animate(withDuration: 0.5) {[weak self] in
            guard let self else { return }
            self.userNameLabel.text = user.fullName
            self.userEmailLabel.text = user.email
        }
        
        UIImage.iconDownloader(with: user.avatar)
            .sink { completion in
                if case .failure(let error) = completion {
                    debugPrint("Error to fetch user profile image: \(error)")
                }
            } receiveValue: { [weak self] image in
                self?.userProfileImgView.image = image
            }
            .store(in: &cancellables)

    }
    
}

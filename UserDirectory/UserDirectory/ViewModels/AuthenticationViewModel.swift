//
//  AuthenticationViewModel.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 13/9/25.
//

import Foundation
import Combine

class AuthenticationViewModel {
    let service: AuthenticationServiceProtocol
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    
    init(service: AuthenticationServiceProtocol) {
        self.service = service
    }
    
    func login(email: String, password: String) {
        isLoading = true
        service.login(email: email, password: password)
            .sink {[weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = handleMyError(error)
                }
                
            } receiveValue: {[weak self] data in
                debugPrint("Token found", data.token)
            }
            .store(in: &cancellables)
        
    }
    
}

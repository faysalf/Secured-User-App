//
//  DashboardViewModel.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 14/9/25.
//

import Foundation
import Combine

class DashboardViewModel {
    
    let service: DashboardServiceProtocol
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var loginSuccess: Bool = false
    private var cancellables = Set<AnyCancellable>()
    var pageNo = 1
    var perPage = 10
    var totalUser = 19
    
    init(service: DashboardServiceProtocol) {
        self.service = service
    }
    
    func getUsers() {
        guard users.count < totalUser else {
            isLoading = false
            return
        }
        
        service.getUser(currentPage: pageNo, pageSize: perPage)
            .sink {[weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = handleMyError(error)
                }
                
            } receiveValue: {[weak self] data in
                guard let self else { return }
                debugPrint("User's found", data.total)
                pageNo += 1
                totalUser = data.total
                users += data.data
            }
            .store(in: &cancellables)
        
    }
    
}

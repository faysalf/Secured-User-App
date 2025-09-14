//
//  DashboardService.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 14/9/25.
//

import Foundation
import Combine

class DashboardService: DashboardServiceProtocol {
    let client = NetworkClient()
    
    func getUser(currentPage: Int, pageSize: Int) -> AnyPublisher<UserListModel, any Error> {
        return client.request(
            endPoint: "api/users?page=\(currentPage)&per_page=\(pageSize)",
            method: .get,
            params: nil,
            isAuthenticationNeeded: true
        )
        .tryMap { (response: UserListModel) in
            return response
        }
        .eraseToAnyPublisher()
    }
    
}

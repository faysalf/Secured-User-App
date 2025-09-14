//
//  DashboardServiceProtocol.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 14/9/25.
//

import Foundation
import Combine

protocol DashboardServiceProtocol {
    func getUser(currentPage: Int, pageSize: Int) -> AnyPublisher<UserListModel, Error>
    
}

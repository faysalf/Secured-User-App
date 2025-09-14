//
//  DashboardServiceProtocol.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 14/9/25.
//

import Foundation
import Combine

protocol DashboardServiceProtocol {
    func getUserList(currentPage: Int, pageSize: Int) -> AnyPublisher<UserListModel, Error>
    
}

//
//  LoginServiceProtocol.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 14/9/25.
//

import Foundation
import Combine

protocol AuthenticationServiceProtocol {
    func login(email: String, password: String) -> AnyPublisher<LoginResponseModel, Error>
    
}

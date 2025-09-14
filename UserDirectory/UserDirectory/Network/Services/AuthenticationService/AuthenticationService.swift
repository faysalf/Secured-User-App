//
//  AuthenticationService.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 13/9/25.
//

import Foundation
import Combine
import Alamofire

class AuthenticationService: AuthenticationServiceProtocol {
    let client = NetworkClient()
    
    func login(
        email: String,
        password: String
    ) -> AnyPublisher<LoginResponseModel, any Error> {
        let params: Parameters = [
            "email": email,
            "password": password
        ]
        
        return client.request(
            endPoint: "api/login",
            method: .post,
            params: params,
            isAuthenticationNeeded: false
        )
        .tryMap { (response: LoginResponseModel) in
            return response
        }
        .eraseToAnyPublisher()
        
    }
    
    
}

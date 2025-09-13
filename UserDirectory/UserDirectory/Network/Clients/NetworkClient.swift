//
//  NetworkClient.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 14/9/25.
//

import UIKit
import Combine
import Alamofire

class NetworkClient {
    func request<T: Decodable>(
        endPoint: String,
        method: HTTPMethod = .get,
        params: Parameters?,
        isAuthenticationNeeded: Bool = true
    ) -> AnyPublisher<T, Error> {
        return AF.request(
            getUrl(with: endPoint),
            method: method,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: getHeader(withAuth: isAuthenticationNeeded)
        )
        .validate()
        .publishDecodable(type: T.self, decoder: JSONDecoder())
        .tryMap { response in
            switch response.result {
            case .success(let value):
                debugPrint("Salon profile info: \(value)")
                return value
                
            case .failure(let error):
                debugPrint("Error to fetch-", error)
                let errorMessage: String = extractMessage(response)
                throw CustomError.error(message: errorMessage)
            }
        }
        .retry(2)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
        
    }
    
    func getUrl(with endPoint: String)-> String {
        AppConfig.baseURL + endPoint
    }
    
    func getHeader(withAuth: Bool)-> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "x-api-key": "reqres-free-v1"
        ]
        if withAuth {
            headers["Authorization"] = "Bearer "
        }
        return headers
        
    }
    
    
}

//
//  CustomError.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed 13/9/25.
//

import Foundation
import Alamofire

enum CustomError: Error {
    case error(message: String)
}

func handleMyError(_ error: Error)-> String {
    if let myError = error as? CustomError {
        switch myError {
        case .error(let message):
            return message
        }
    } else {
        return "Something went wrong!"
    }
}

func extractMessage<T>(_ response: DataResponse<T, AFError>) -> String {
    if let data = response.data,
       let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
       let message = json["error"] as? String {
        return message
    }
    
    if let afError = response.error as? AFError,
       case let .responseValidationFailed(reason) = afError,
       case let .unacceptableStatusCode(code) = reason {
        return "HTTP Error: \(code)"
    }
    return "Something went wrong!"
}


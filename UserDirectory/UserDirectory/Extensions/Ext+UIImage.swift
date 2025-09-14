//
//  Ext+UIImage.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 14/9/25.
//

import Foundation
import UIKit
import Combine
import Alamofire

extension UIImage {
    
    static func iconDownloader(
        with url: String
    ) -> AnyPublisher<UIImage, Error> {
        
        return Future<UIImage, Error> { promis in
            AF.download(url)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        if let image = UIImage(data: data) {
                            promis(.success(image))
                        }else {
                            promis(.success(UIImage(systemName: "person.circle.fill")!))
                        }
                    case .failure(let error):
                        promis(.failure(CustomError.error(message: "Something went wrong!")))
                    }
                }
        }
        .retry(2)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
}

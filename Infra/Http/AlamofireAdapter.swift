//
//  AlamofireAdapter.swift
//  Infra
//
//  Created by Alan Casas on 12/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Data
import Alamofire

public final class AlamofireAdapter: HttpPostClientProtocol {
    
    private let session: Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    public func post (to urlToCall: URL, with data: Data?, completionHandler: @escaping (Result<Data?, HttpError>) -> Void) {
        let json = data?.toJson()
        session.request(urlToCall, method: .post, parameters: json, encoding: JSONEncoding.default).responseData { dataResponse in
            guard let statusCode = dataResponse.response?.statusCode else {
                return completionHandler(.failure(.noConnectivityError))
            }
            
            switch dataResponse.result {
            case .failure: completionHandler(.failure(.noConnectivityError))
            case .success(let data):
                switch statusCode {
                case 204:
                    completionHandler(.success(nil))
                case 200...299:
                    completionHandler(.success(data))
                case 400:
                    completionHandler(.failure(.badRequest))
                case 401:
                    completionHandler(.failure(.unauthorized))
                case 403:
                    completionHandler(.failure(.forbidden))
                case 404:
                    completionHandler(.failure(.not_found))
                case 400...499:
                    completionHandler(.failure(.badRequest))
                case 500...599:
                    completionHandler(.failure(.serverError))
                default:
                    completionHandler(.failure(.noConnectivityError))
                }
            }
        }
    }
}

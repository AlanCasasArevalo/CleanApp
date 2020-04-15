//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Alan Casas on 08/04/2020.
//  Copyright © 2020 Alan Casas. All rights reserved.
//

import Foundation
import Data

class HttpClientSpy: HttpPostClientProtocol {
    
    var urlsToCall = [URL]()
    var data: Data?
    var completionHandler: ((Result<Data?, HttpError>) -> Void)?
    
    func post(to urlToCall: URL, with data: Data?, completionHandler: @escaping (Result<Data?, HttpError>) -> Void) {
        self.urlsToCall.append(urlToCall)
        self.data = data
        self.completionHandler = completionHandler
    }
    
    func completeWithError (_ error: HttpError) {
        completionHandler?(.failure(error))
    }
    
    func completeWithData (_ data: Data) {
        completionHandler?(.success(data))
    }
}

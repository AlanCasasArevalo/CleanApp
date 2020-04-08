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
       var completationHandler: ((Result<Data, HttpError>) -> Void)?
       
       func post(to urlToCall: URL, with data: Data?, completationHandler: @escaping (Result<Data, HttpError>) -> Void) {
           self.urlsToCall.append(urlToCall)
           self.data = data
           self.completationHandler = completationHandler
       }
       
       func completeWithError (_ error: HttpError) {
           completationHandler?(.failure(error))
       }
       
       func completeWithData (_ data: Data) {
           completationHandler?(.success(data))
       }
   }

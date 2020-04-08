
import XCTest
import Domain
import Data

class RemoteAddAccountTest: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url () {
        let urlToCall = URL(string: "www.google.com")!
        let (sut, httpClientSpy) = makeSut(urlToCall: urlToCall)
        // Aqui no se precisa hacer nada en el completionHandler porque no es lo que queremos testar.
        sut.addAccount(addAccountModel: makeAddAccountModelRequest()) {_ in }
        XCTAssertEqual(httpClientSpy.urlsToCall, [urlToCall])
    }
    
    func test_add_should_call_httpClient_with_correct_data () {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModelRequest = makeAddAccountModelRequest()
        // Aqui no se precisa hacer nada en el completionHandler porque no es lo que queremos testar.
        sut.addAccount(addAccountModel: makeAddAccountModelRequest()) {_ in }
        XCTAssertEqual(httpClientSpy.data, addAccountModelRequest.toData())
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_fails () {
        let (sut, httpClientSpy) = makeSut()
        expectationTest(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivityError)
        })
    }
    
    func test_add_should_complete_with_account_if_client_completes_with_success () {
        let (sut, httpClientSpy) = makeSut()
        let account = makeAccountModel()
        expectationTest(sut, completeWith: .success(account), when: {
            httpClientSpy.completeWithData(account.toData()!)
        })
    }
    
    func test_add_should_complete_with_error_if_client_completes_with_invalid_data () {
        let (sut, httpClientSpy) = makeSut()
        expectationTest(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithData(Data("invalid_data".utf8))
        })        
    }
}

extension RemoteAddAccountTest {
    
    func makeSut(urlToCall: URL = URL(string: "www.any_url.com")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(urlToCall: urlToCall, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func expectationTest(_ sut: RemoteAddAccount, completeWith expectedResult: Result<AccountModel, DomainError>, when action: ()-> Void) {
        let expect = expectation(description: "waiting")
        sut.addAccount(addAccountModel: makeAddAccountModelRequest()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount)
            default: XCTFail("Expected \(expectedResult) received \(receivedResult) instead")
            }
            expect.fulfill()
        }
        action()
        wait(for: [expect], timeout: 3)
    }
    
    func makeAddAccountModelRequest () -> AddAccountModelRequest {
        let addAccountModelRequest = AddAccountModelRequest(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_password")
        return addAccountModelRequest
    }
    
    func makeAccountModel () -> AccountModel {
        let accountModel = AccountModel(id: "any_id", name: "any_name", email: "any_email", password: "any_password")
        return accountModel
    }
    
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
}





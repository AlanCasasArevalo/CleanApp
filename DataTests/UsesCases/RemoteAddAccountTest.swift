
import XCTest
import Domain
import Data

class RemoteAddAccountTest: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url () {
        let urlToCall = makeUrl()
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
            httpClientSpy.completeWithData(makeInvalidData())
        })
    }
    
    func test_add_should_not_complete_if_sut_has_been_deallocated () {
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteAddAccount? = RemoteAddAccount(urlToCall: makeUrl(), httpClient: httpClientSpy)
        var result: Result<AccountModel, DomainError>?
        sut?.addAccount(addAccountModel: makeAddAccountModelRequest()) {
            result = $0
        }
        sut = nil
        httpClientSpy.completeWithError(.noConnectivityError)
        XCTAssertNil(result)
    }
}

extension RemoteAddAccountTest {
    
    func makeSut(urlToCall: URL = URL(string: "www.any_url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(urlToCall: urlToCall, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func checkMemoryLeak (for instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
    
    func expectationTest(_ sut: RemoteAddAccount, completeWith expectedResult: Result<AccountModel, DomainError>, when action: ()-> Void, file: StaticString = #file, line: UInt = #line) {
        let expect = expectation(description: "waiting")
        sut.addAccount(addAccountModel: makeAddAccountModelRequest()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) received \(receivedResult) instead", file: file, line: line)
            }
            expect.fulfill()
        }
        action()
        wait(for: [expect], timeout: 3)
    }
    
    func makeInvalidData () -> Data {
        let data = Data("invalid_data".utf8)
        return data
    }
    
    func makeUrl () -> URL {
        let urlToCall = URL(string: "www.google.com")!
        return urlToCall
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





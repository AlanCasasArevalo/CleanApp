
import XCTest
import Domain
import Data

class RemoteAddAccountTest: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url () {
        let urlToCall = URL(string: "www.google.com")!
        let (sut, httpClientSpy) = makeSut(urlToCall: urlToCall)
        sut.addAccount(addAccountModel: makeAddAccountModelRequest())
        XCTAssertEqual(httpClientSpy.urlsToCall, [urlToCall])
    }
    
    func test_add_should_call_httpClient_with_correct_data () {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModelRequest = makeAddAccountModelRequest()
        sut.addAccount(addAccountModel: addAccountModelRequest)
        XCTAssertEqual(httpClientSpy.data, addAccountModelRequest.toData())
    }
}

extension RemoteAddAccountTest {

    func makeSut(urlToCall: URL = URL(string: "www.any_url.com")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(urlToCall: urlToCall, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func makeAddAccountModelRequest () -> AddAccountModelRequest {
        let addAccountModelRequest = AddAccountModelRequest(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_password")
        return addAccountModelRequest
    }
    
    class HttpClientSpy: HttpPostClientProtocol {
        var urlsToCall = [URL]()
        var data: Data?
        var callsCount = 0
        
        func post(to urlToCall: URL, with data: Data?) {
            self.urlsToCall.append(urlToCall)
            self.data = data
        }
        
    }
}





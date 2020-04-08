
import XCTest
import Domain

class RemoteAddAccount {
    private let urlToCall: URL
    private let httpClient: HttpPostClientProtocol

    init(urlToCall: URL, httpClient: HttpPostClientProtocol) {
        self.urlToCall = urlToCall
        self.httpClient = httpClient
    }
    
    func addAccount(addAccountModel: AddAccountModelRequest){
        let data = try? JSONEncoder().encode(addAccountModel)
        httpClient.post(to: urlToCall, with: data)
    }
}

protocol HttpPostClientProtocol {
    func post(to urlToCall: URL, with data: Data?)
}

class RemoteAddAccountTest: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url () {
        let urlToCall = URL(string: "www.google.com")!
        let (sut, httpClientSpy) = makeSut(urlToCall: urlToCall)
        sut.addAccount(addAccountModel: makeAddAccountModelRequest())
        XCTAssertEqual(httpClientSpy.urlToCall, urlToCall)
    }
    
    func test_add_should_call_httpClient_with_correct_data () {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModelRequest = makeAddAccountModelRequest()
        sut.addAccount(addAccountModel: addAccountModelRequest)
        let data = try? JSONEncoder().encode(addAccountModelRequest)
        XCTAssertEqual(httpClientSpy.data, data)
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
        var urlToCall: URL?
        var data: Data?
        
        func post(to urlToCall: URL, with data: Data?) {
            self.urlToCall = urlToCall
            self.data = data
        }
        
    }
}





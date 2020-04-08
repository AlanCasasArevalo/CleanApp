
import XCTest

class RemoteAddAccount {
    private let urlToCall: URL
    private let httpClient: HttpPostClientProtocol

    init(urlToCall: URL, httpClient: HttpPostClientProtocol) {
        self.urlToCall = urlToCall
        self.httpClient = httpClient
    }
    
    func addAccount(addAccountModel: AddAccountModelRequest){
        httpClient.post(urlToCall: urlToCall)
    }
}

protocol HttpPostClientProtocol {
    func post(urlToCall: URL)
}

class RemoteAddAccountTest: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url () {
        let urlToCall = URL(string: "www.any_url.com")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(urlToCall: urlToCall, httpClient: httpClientSpy)
        sut.addAccount()
        XCTAssertEqual(httpClientSpy.urlToCall, urlToCall)
    }
    
    func test_add_should_call_httpClient_with_correct_data () {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(urlToCall: URL(string: "www.any_url.com")!, httpClient: httpClientSpy)
        sut.addAccount()
        XCTAssertEqual(httpClientSpy.data, data)
    }
}

extension RemoteAddAccountTest {
    class HttpClientSpy: HttpPostClientProtocol {
        var urlToCall: URL?

        func post(urlToCall: URL) {
            self.urlToCall = urlToCall
        }
        
    }
}





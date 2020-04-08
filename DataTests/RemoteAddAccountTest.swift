
import XCTest

class RemoteAddAccount {
    private let urlToCall: URL
    private let httpClient: HttpPostClientProtocol

    init(urlToCall: URL, httpClient: HttpPostClientProtocol) {
        self.urlToCall = urlToCall
        self.httpClient = httpClient
    }
    
    func addAccount(){
        httpClient.post(urlToCall: urlToCall)
    }
}

protocol HttpPostClientProtocol {
    func post(urlToCall: URL)
}

class RemoteAddAccountTest: XCTestCase {
    
    class HttpClientSpy: HttpPostClientProtocol {
        var urlToCall: URL?

        func post(urlToCall: URL) {
            self.urlToCall = urlToCall
        }
        
    }

    func test_() {
        let urlToCall = URL(string: "www.any_url.com")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(urlToCall: urlToCall, httpClient: httpClientSpy)
        sut.addAccount()
        XCTAssertEqual(httpClientSpy.urlToCall, urlToCall)
    }
}







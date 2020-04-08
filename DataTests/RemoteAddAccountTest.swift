
import XCTest

class RemoteAddAccount {
    private let urlToCall: URL
    
    init(urlToCall: URL) {
        self.urlToCall = urlToCall
    }
}

protocol HttpClientProtocol {
    func post(urlToCall: URL)
}

class RemoteAddAccountTest: XCTestCase {
    
    class HttpClientSpy: HttpClientProtocol {
        var urlToCall: URL?

        func post(urlToCall: URL) {
            
        }
        
    }

    func test_() {
        let urlToCall = URL(string: "www.any_url.com")!
        let httpClient = HttpClientSpy()
        let sut = RemoteAddAccount(urlToCall: urlToCall)
        XCTAssertEqual(httpClient.urlToCall, urlToCall)
    }
}







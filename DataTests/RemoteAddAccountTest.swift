
import XCTest

class RemoteAddAccount {
    private let urlToCall: URL
    
    init(urlToCall: URL) {
        self.urlToCall = urlToCall
    }
}

class RemoteAddAccountTest: XCTestCase {

    func test_() {
        let urlToCall = URL(string: "www.any_url.com")!
        let sut = RemoteAddAccount(urlToCall: urlToCall)
    }
}







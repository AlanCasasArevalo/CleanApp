
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
    
    func test_add_should_complete_with_error_if_client_fails () {
        let (sut, httpClientSpy) = makeSut()
        // Se necesita hacer una nueva variable de expectation debido a que usamos test con respuestas asincronas
        let expect = expectation(description: "waiting")
        sut.addAccount(addAccountModel: makeAddAccountModelRequest()) { error in
            XCTAssertEqual(error, .unexpected)
            // Aqui hacemos que se libere la espera de la respuesta asincrona
            expect.fulfill()
        }
        httpClientSpy.completeWithError(.noConnectivityError)
        // Aqui hacemos que espere la respuesta asincrona, de no estar recibiendo los callbacks correspondientes se fallaria el test. 
        wait(for: [expect], timeout: 5)
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
        var completationHandler: ((HttpError) -> Void)?
        
        func post(to urlToCall: URL, with data: Data?, completationHandler: @escaping (HttpError) -> Void) {
            self.urlsToCall.append(urlToCall)
            self.data = data
            self.completationHandler = completationHandler
        }
        
        func completeWithError (_ error: HttpError) {
            completationHandler?(error)
        }
    }
}





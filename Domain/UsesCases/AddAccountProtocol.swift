import Foundation

public protocol AddAccountProtocol {
    func addAccount(addAccountModel: AddAccountModelRequest, completionHandler: @escaping (Result<AccountModel, DomainError>) -> Void)
}





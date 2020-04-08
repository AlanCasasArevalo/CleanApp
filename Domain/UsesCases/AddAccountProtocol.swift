import Foundation

public protocol AddAccountProtocol {
    func addAccount(addAccountModel: AddAccountModelRequest, completationHandler: @escaping (Result<AccountModel, DomainError>) -> Void)
}





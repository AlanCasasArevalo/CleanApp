import Foundation

public enum HttpError: Error {
    case noConnectivityError
    case badRequest
    case serverError
    case unauthorized
    case not_found
    case forbidden
}

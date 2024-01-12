import Foundation
import UIKit

public protocol HTTPService {
    func fetchData<T: Endpoint>(for endpoint: T) async throws -> Data
}

public struct DefaultHTTPService: HTTPService {
    
    let urlSession: URLSessionProtocol
    
    public init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    public func fetchData<T: Endpoint>(for endpoint: T) async throws -> Data {
        let request = endpoint.makeUrlRequest()
        return try await urlSession.data(for: request, delegate: nil).0
    }
}

enum HTTPError: Error {
    case urlError
}

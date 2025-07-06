import Foundation

public protocol HeadersRequestDecoratorProtocol {
    var requestHeaders: [String: String?] { get }
    func decorate(urlRequest: inout URLRequest)
}

// MARK: HeadersRequestDecorator
// Contains methods for decorating HTTP header like BearerToken
public class HeadersRequestDecorator: HeadersRequestDecoratorProtocol {
    public var requestHeaders: [String: String?] {
        // We need to change Token for Bearer in the feature!
        [HeaderRequestKey.xAuthorization.rawValue: "Token"]
    }
    
    public init() {}
    
    /// Adds headers for the `urlRequest` from requestHeaders
    public func decorate(urlRequest: inout URLRequest) {
        requestHeaders.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
    }
}

public enum HeaderRequestKey: String {
    case xAuthorization = "Authorization"
}

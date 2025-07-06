import Foundation

#if DEBUG
public class HeadersRequestDecoratorProtocolMock: HeadersRequestDecoratorProtocol {
    public var requestHeaders: [String: String?] {
        [HeaderRequestKey.xAuthorization.rawValue: "Bearer Token"]
    }
    
    public func decorate(urlRequest: inout URLRequest) {
        requestHeaders.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    public init() {}
}
#endif

import Foundation

#if DEBUG
public class URLSessionMock: URLSession {
    public typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    // Properties that enable us to set exactly what data or error
    // we want our mocked URLSession to return for any request.
    public var data: Data?
    public var response: HTTPURLResponse?
    public var error: Error?
    
    public init(data: Data? = nil, response: HTTPURLResponse? = nil, error: Error? = nil) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    public override func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error
        
        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
}

// We create a partial mock by subclassing the original class
public class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    public init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    public override func resume() {
        closure()
    }

    public override func cancel() {}
}

public extension HTTPURLResponse {
    static func mock(_ statusCode: Int, _ headerFields: [String: String] = [:]) -> HTTPURLResponse {
        HTTPURLResponse(url: URL.mock, statusCode: statusCode, httpVersion: nil, headerFields: headerFields)!
    }
}
#endif

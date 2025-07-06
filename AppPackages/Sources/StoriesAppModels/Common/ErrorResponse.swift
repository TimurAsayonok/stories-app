import Foundation

public struct ErrorResponse: Codable, Equatable, Error, LocalizedError {
    public let message: String
    
    public init(message: String) {
        self.message = message
    }
    
    enum CodingKeys: String, CodingKey {
        case message
    }
    
    public var errorDescription: String? {
        "We have error with message: \(message)"
    }
}

#if DEBUG
public extension ErrorResponse {
    static var sut: Self {
        .init(message: "error")
    }
}
#endif


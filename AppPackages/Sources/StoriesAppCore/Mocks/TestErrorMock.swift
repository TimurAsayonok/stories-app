import Foundation

#if DEBUG
public struct TestErrorMock: Error, Equatable, Codable {
    public let error: String

    public init(error: String = "error") {
        self.error = error
    }
}
#endif

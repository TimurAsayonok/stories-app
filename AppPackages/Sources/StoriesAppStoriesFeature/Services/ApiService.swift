import Foundation
import StoriesAppCore

// MARK: ApiService
// Contains api service methods
public protocol ApiServiceProtocol {
    func getStrories(for userId: Int) -> [Story]
}

public struct ApiService: ApiServiceProtocol {
    public func getStrories(for userId: Int) -> [Story] {
        return [
            Story.mocked(for: userId),
            Story.mocked(for: userId),
            Story.mocked(for: userId)
        ]
    }
}

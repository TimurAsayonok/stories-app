import Foundation
import StoriesAppModels

public struct Page: Codable, Sendable {
    public let users: [User]
}

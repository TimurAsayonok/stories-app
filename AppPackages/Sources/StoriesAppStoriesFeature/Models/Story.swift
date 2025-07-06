import Foundation

public struct Story: Codable, Identifiable, Hashable {
    public let id: UUID
    public let imageURL: String
    public let userId: String
    public var isSeen = false
    public var isLiked = false
}

public extension Story {
    static func mocked(for userId: String) -> Story {
        .init(
            id: .init(),
            imageURL: "https://picsum.photos/400/700?random=\(Int.random(in: 1...10))",
            userId: userId
        )
    }
}

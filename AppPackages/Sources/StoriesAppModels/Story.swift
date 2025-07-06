import Foundation

public struct Story: Codable, Identifiable, Hashable {
    public let id: UUID
    public let imageURL: String
    public let userId: Int
    public var isSeen = false
    public var isLiked = false
}

public extension Story {
    static func mocked(for userId: Int) -> Story {
        let randomImageId = Int.random(in: 0...userId + 10)
        return Story(
            id: UUID(),
            imageURL: "https://picsum.photos/id/\(randomImageId)/400/700",
            userId: userId
        )
    }
}

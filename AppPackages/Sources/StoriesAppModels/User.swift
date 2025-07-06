import Foundation

public struct User: Codable, Hashable, Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let profilePictureURL: URL?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePictureURL = "profile_picture_url"
    }
}

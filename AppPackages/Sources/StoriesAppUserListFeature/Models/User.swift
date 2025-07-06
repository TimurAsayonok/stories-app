import Foundation

public struct User: Codable, Hashable, Identifiable {
    public let id: String
    public let name: String
    public let profilePictureURL: URL?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePictureURL = "profile_picture_url"
    }
}

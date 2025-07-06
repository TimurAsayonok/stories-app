import Foundation
import StoriesAppModels

public class StoriesPersistence {
    private let usersKey = "persistedUserList"
    private func storiesKey(for userId: String) -> String { "stories_\(userId)" }
    
    public init() {}

    public func persistUserList(_ userList: [User]) {
        if let data = try? JSONEncoder().encode(userList) {
            UserDefaults.standard.set(data, forKey: usersKey)
        }
    }

    public func loadUserList() -> [User]? {
        if let data = UserDefaults.standard.data(forKey: usersKey),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            return users
        }
        return nil
    }

    public func persistStories(_ stories: [Story], for userId: Int) {
        if let data = try? JSONEncoder().encode(stories) {
            UserDefaults.standard.set(data, forKey: storiesKey(for: "\(userId)"))
        }
    }

    public func loadStories(for userId: Int) -> [Story]? {
        if let data = UserDefaults.standard.data(forKey: storiesKey(for: "\(userId)")),
           let stories = try? JSONDecoder().decode([Story].self, from: data) {
            return stories
        }
        return nil
    }
    
    public func hasUnseenStories(for userId: Int) -> Bool {
        guard let stories = loadStories(for: userId) else { return true }
        print("Stories: \(stories)")
        return stories.contains { $0.isSeen == false }
    }
}

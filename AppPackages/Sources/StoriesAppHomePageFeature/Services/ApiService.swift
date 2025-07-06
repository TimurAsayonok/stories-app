import Foundation
import StoriesAppCore

// MARK: ApiService
// Contains api service methods
public protocol ApiServiceProtocol {
    func getUsersList() throws -> UserList
}

public struct ApiService: ApiServiceProtocol {
    let jsonLoader: LocalJSONLoader

    public init(jsonLoader: LocalJSONLoader) {
        self.jsonLoader = jsonLoader
    }

    public func getUsersList() throws -> UserList {
        let userList: UserList = try jsonLoader.load(from: "users", as: UserList.self, bundle: .module)
        return userList
    }
}

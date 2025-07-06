import Foundation
import StoriesAppCore


// MARK: ApiService
// Contains api service methods
public protocol ApiServiceProtocol {
    func getUsersList() -> [User]
}

public struct ApiService: ApiServiceProtocol {    
    func getUsersList() -> [User]
}

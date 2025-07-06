import Foundation
import StoriesAppUserListFeature

public class StoriesViewModel: ObservableObject, Identifiable {
    public enum Direction {
        case next, previous
    }
    
    @Published public var stories: [Story] = []
    let user: User
    private let service: ApiServiceProtocol = ApiService()
    private var presentUser: (Direction) -> Void

    public init(user: User, presentUser: @escaping (Direction) -> Void) {
        self.user = user
        self.presentUser = presentUser
        fetchStories()
    }

    func fetchStories() {
        stories = service.getStrories(for: user.id)
    }
    
    func onUserChanged(to direction: Direction) {
        presentUser(direction)
    }
}


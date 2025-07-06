import Foundation
import StoriesAppModels
import StoriesAppCore

public class UserListViewModel: ObservableObject {    
    @Published var users: [User] = []
    let onUserTap: (User) -> Void
    private let loadMoreStories: (Bool) -> Void
    private var persistenceService: StoriesPersistence

    public init(
        users: [User],
        persistenceService: StoriesPersistence,
        onUserTap: @escaping (User) -> Void,
        loadMoreStories: @escaping (Bool) -> Void
    ) {
        self.users = users
        self.onUserTap = onUserTap
        self.loadMoreStories = loadMoreStories
        self.persistenceService = persistenceService
    }
    
    func isSeen(_ user: User) -> Bool {
        return persistenceService.hasUnseenStories(for: user.id)
    }
    
    func onUserViewAppeared(_ userId: Int) {
        if userId == users.last?.id {
            loadMoreStories(true)
        }
    }
}

import Foundation
import Combine
import StoriesAppModels
import StoriesAppStoriesFeature
import StoriesAppUserListFeature
import StoriesAppCore

public class StoriesHomePageViewModel: ObservableObject {
    @Published var userList: [User] = []
    @Published var userToPresent: User?
    @Published var onPresentStoriesView = false
    var storiesViewModel: StoriesViewModel?
    var userListViewModel: UserListViewModel {
        .init(users: userList, persistenceService: persistenceService, onUserTap: presentStories(for:))
    }
    var selectedPage = 0
    private var pages: [Page] = []
    private var cancellables = Set<AnyCancellable>()
    private let service: ApiServiceProtocol = ApiService()
    private let persistenceService: StoriesPersistence
    
    public init(persistenceService: StoriesPersistence) {
        self.persistenceService = persistenceService
    }
    
    func loadOrFetchUsers() {
        if let persistedUsers = persistenceService.loadUserList(), !persistedUsers.isEmpty {
            userList = persistedUsers
        } else {
            fetchHomePage()
        }
    }

    func fetchHomePage(pageNumber: Int = 0) {
        do {
            pages = try service.getUsersList().pages
            userList = pages[pageNumber].users
            persistenceService.persistUserList(userList)
        } catch {
            // add error handling here
            print("Error fetching user list: \(error)")
        }
    }
    
    func presentStories(for user: User) {
        userToPresent = user
        storiesViewModel = StoriesViewModel(
            user: user,
            persistenceService: persistenceService,
            presentUser: presentUser
        )
        onPresentStoriesView = true
    }
    
    func presentUser(_ direction: StoriesViewModel.Direction) {
        guard let currentUser = userToPresent else { return }
        // Flatten all users from all pages
        guard let currentIndex = userList.firstIndex(where: { $0.id == currentUser.id }) else { return }
        
        var newIndex: Int?
        switch direction {
        case .next:
            if currentIndex < userList.count - 1 {
                newIndex = currentIndex + 1
            } else {
                onPresentStoriesView = false
            }
        case .previous:
            if currentIndex > 0 {
                newIndex = currentIndex - 1
            }
        }
        
        if let newIndex = newIndex {
            let nextUser = userList[newIndex]
            userToPresent = nextUser
            storiesViewModel = StoriesViewModel(
                user: nextUser,
                persistenceService: persistenceService,
                presentUser: presentUser
            )
        }
    }
}

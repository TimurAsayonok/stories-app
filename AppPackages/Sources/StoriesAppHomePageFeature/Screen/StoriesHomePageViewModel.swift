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
        .init(
            users: userList,
            persistenceService: persistenceService,
            onUserTap: presentStories(for:),
            loadMoreStories: loadMoreStories
        )
    }
    var pageIndex = 0
    private var pages: [Page] = []
    private var cancellables = Set<AnyCancellable>()
    private let service: ApiServiceProtocol
    private let storiesApiService: StoriesAppStoriesFeature.ApiServiceProtocol
    private let persistenceService: StoriesPersistence
    
    public init(
        persistenceService: StoriesPersistence,
        service: ApiServiceProtocol,
        storiesApiService: StoriesAppStoriesFeature.ApiServiceProtocol
    ) {
        self.persistenceService = persistenceService
        self.storiesApiService = storiesApiService
        self.service = service
    }
    
    func loadOrFetchUsers() {
        if let persistedUsers = persistenceService.loadUserList(), !persistedUsers.isEmpty {
            userList = persistedUsers
        } else {
            fetchPages()
        }
    }
    
    func loadMoreStories(_ loading: Bool) {
        if loading {
            if pageIndex < pages.count - 1 {
                pageIndex += 1
                updateUserList(for: pageIndex)
            }
        }
    }

    func fetchPages() {
        do {
            pages = try service.getUsersList().pages
            updateUserList(for: 0)
        } catch {
            // add error handling here
            print("Error fetching user list: \(error)")
        }
    }
    
    private func updateUserList(for page: Int) {
        userList += pages[page].users
        persistenceService.persistUserList(userList)
    }
    
    func presentStories(for user: User) {
        userToPresent = user
        storiesViewModel = StoriesViewModel(
            user: user,
            apiService: storiesApiService,
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
                apiService: storiesApiService,
                persistenceService: persistenceService,
                presentUser: presentUser
            )
        }
    }
}

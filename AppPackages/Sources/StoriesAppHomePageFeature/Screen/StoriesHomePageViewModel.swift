import Foundation
import Combine
import StoriesAppStoriesFeature
import StoriesAppUserListFeature

class StoriesHomePageViewModel: ObservableObject {
    @Published var userList: [User] = []
    @Published var userToPresent: User?
    @Published var onPresentStoriesView = false
    var storiesViewModel: StoriesViewModel?
    var selectedPage = 0
    private var pages: [Page] = []
    private var cancellables = Set<AnyCancellable>()
    private let service: ApiServiceProtocol
    
    init(service: ApiServiceProtocol = ApiService()) {
        self.service = service
    }

    func fetchHomePage() {
        do {
            pages = try service.getUsersList().pages
            userList = pages[0].users
        } catch {
            // add error handling here
            print("Error fetching user list: \(error)")
        }
    }
    
    func presentStories(for user: User) {
        userToPresent = user
        storiesViewModel = StoriesViewModel(
            user: user,
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
                presentUser: presentUser
            )
        }
    }
}

import Foundation
import Combine

final class StoriesHomePageViewModel: ObservableObject {
    @Published var users: [User] = []
    private var cancellables = Set<AnyCancellable>()

    func fetchUsers() {
        // Simulate network delay and fetching
    }
}
